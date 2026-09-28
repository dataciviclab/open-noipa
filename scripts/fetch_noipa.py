#!/usr/bin/env python3
"""Fetch NoiPA data from the open data portal CSV endpoint.

Downloads aggregated CSVs per entry type per month, adds month column,
and writes a single concatenated CSV.

Uso: python fetch_noipa.py [entry_type] [output_path] [start_ym] [end_ym]

Entry types disponibili:
  EntryAmministrati, EntryResidenti, EntryAccreditoStipendi,
  EntryPendolarismo, EntryAccessoAmministrati, EntryStrutturaOrganizzativa,
  EntryInquadramenti, EntryContrattiGestiti, EntryMotivoAssunzione,
  EntryMotivoCessazione, EntryDetrazioniFamiliari, EntryAssegniFamiliari,
  EntryAssenzeContabilizzate, EntryCedolinoRitenutePrevidenziali,
  EntryCedolinoRitenuteFiscali, EntryRitenutePrestiti,
  EntryRitenuteSindacali, EntryCertificazioniUniche,
  EntryAmministratiPerFasciaDiReddito
"""

import csv
import io
import os
import sys
import urllib.parse
import zipfile

WORKSPACE = os.path.dirname(
    os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
)
sys.path.insert(0, WORKSPACE)

from lab_connectors.http import HttpClient

_PORTLET = "it_gov_mef_opendata_portlet_NoipaOpendataPortlet_INSTANCE_k0QJbYynlaqN"
_BASE = "https://dati-noipa.mef.gov.it/cl/web/open-data/dataset"

ENTRY_TYPES = [
    "EntryAmministrati",
    "EntryResidenti",
    "EntryAccreditoStipendi",
    "EntryPendolarismo",
    "EntryAccessoAmministrati",
    "EntryStrutturaOrganizzativa",
    "EntryInquadramenti",
    "EntryContrattiGestiti",
    "EntryMotivoAssunzione",
    "EntryMotivoCessazione",
    "EntryDetrazioniFamiliari",
    "EntryAssegniFamiliari",
    "EntryAssenzeContabilizzate",
    "EntryCedolinoRitenutePrevidenziali",
    "EntryCedolinoRitenuteFiscali",
    "EntryRitenutePrestiti",
    "EntryRitenuteSindacali",
    "EntryCertificazioniUniche",
    "EntryAmministratiPerFasciaDiReddito",
]


def build_url(entry_type: str, year: int, month: int) -> str:
    p = _PORTLET
    # Use list of tuples — duplicate keys (p_p_lifecycle, _id) are required by Liferay
    params = [
        ("p_p_id", p),
        ("p_p_lifecycle", "2"),
        ("p_p_state", "normal"),
        ("p_p_mode", "view"),
        ("p_p_cacheability", "cacheLevelPage"),
        (f"_{p}_anno", str(year)),
        (f"_{p}_formato", "CSV"),
        (f"_{p}_mese", f"{month:02d}"),
        (f"_{p}_id", entry_type),
        (f"_{p}_id", entry_type),
        (f"_{p}_jspPage", "/dettaglio/dettaglioDataSet.jsp"),
        ("p_p_lifecycle", "1"),
        (f"_{p}_javax.portlet.action", "getDettaglio"),
    ]
    return f"{_BASE}?{urllib.parse.urlencode(params)}"


def download_csv(
    client: HttpClient, entry_type: str, year: int, month: int
) -> list[dict[str, str]] | None:
    """Download and parse a single CSV from the portal."""
    url = build_url(entry_type, year, month)
    result = client.get(url, headers={"Accept": "*/*"})
    if not result.is_ok or result.response is None:
        return None
    if result.response.status_code != 200:
        return None

    content_type = (result.response.headers.get("Content-Type") or "").lower()
    body = result.response.content

    # ZIP response — extract CSV
    if "zip" in content_type or body[:2] == b"PK":
        try:
            with zipfile.ZipFile(io.BytesIO(body)) as zf:
                csv_names = [n for n in zf.namelist() if n.endswith(".csv")]
                if not csv_names:
                    return None
                csv_bytes = zf.read(csv_names[0])
        except zipfile.BadZipFile:
            return None
    elif "csv" in content_type:
        csv_bytes = body
    else:
        return None

    text = csv_bytes.decode("utf-8", errors="replace")
    # Skip readme line (line 1 is a privacy note)
    lines = text.split("\n")
    header_idx = 0
    for i, line in enumerate(lines):
        if "," in line and not line.startswith("Il "):
            header_idx = i
            break

    reader = csv.DictReader(lines[header_idx:])
    rows = list(reader)

    # Normalizza nomi colonne che cambiano tra anni
    COLUMN_ALIASES = {
        "qualifica_contrattuale": "inquadramento",
    }
    for row in rows:
        for old_key, new_key in COLUMN_ALIASES.items():
            if old_key in row and new_key not in row:
                row[new_key] = row.pop(old_key)

    return rows


def months_in_range(start: str, end: str) -> list[tuple[int, int]]:
    months = []
    y, m = int(start[:4]), int(start[4:])
    y_end, m_end = int(end[:4]), int(end[4:])
    while (y, m) <= (y_end, m_end):
        months.append((y, m))
        m += 1
        if m > 12:
            m = 1
            y += 1
    return months


def main():
    entry_type = sys.argv[1] if len(sys.argv) > 1 else "EntryAmministrati"
    output_path = sys.argv[2] if len(sys.argv) > 2 else "raw_input.csv"
    start_ym = sys.argv[3] if len(sys.argv) > 3 else "201901"
    end_ym = sys.argv[4] if len(sys.argv) > 4 else "202608"

    client = HttpClient(timeout=60)
    all_months = months_in_range(start_ym, end_ym)
    print(
        f"Entry type: {entry_type}", file=sys.stderr
    )
    print(f"Mesi: {len(all_months)} ({start_ym} - {end_ym})", file=sys.stderr)

    all_rows: list[dict[str, str]] = []
    fieldnames: list[str] = []

    for year, month in all_months:
        ym = f"{year}{month:02d}"
        print(f"  {ym}...", end="", flush=True, file=sys.stderr)
        rows = download_csv(client, entry_type, year, month)
        if rows is None:
            print(" SKIP (non disponibile)", file=sys.stderr)
            continue
        if not fieldnames and rows:
            fieldnames = list(rows[0].keys()) + ["month"]
        for row in rows:
            row["month"] = ym
        all_rows.extend(rows)
        print(f" {len(rows)} righe", file=sys.stderr)

    if all_rows:
        if not fieldnames:
            fieldnames = ["month"]
        with open(output_path, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
            writer.writeheader()
            writer.writerows(all_rows)
        print(
            f"\nTotale: {len(all_rows)} righe in {output_path}",
            file=sys.stderr,
        )
    else:
        print("\nNessun dato recuperato!", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
