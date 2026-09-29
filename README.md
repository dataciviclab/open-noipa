# open-noipa

**Dove vanno i soldi della PA? Quanto costano i dipendenti pubblici? Dove vivono vs dove lavorano?**

NoiPA è il sistema che paga ogni dipendente della Pubblica Amministrazione italiana — ministeri, agenzie, scuole, difesa. Questi dati aprono quello che prima era un bollino nero: stipendi reali, contributi previdenziali, assenze, pendolarismo, per ogni comune d'Italia.

## Cosa contengono

| Dataset | Righe/mese | Periodo | Cosa misura |
|---|---|---|---|
| `noipa_amministrati` | ~20k | 2019-2026 | Dipendenti per comune, fascia di età, genere |
| `noipa_contratti` | ~25k | 2019-2026 | Comparto, inquadramento, amministrazione |
| `noipa_ritenute_fiscali` | ~25k | 2019-2026 | Imponibile, IRPEF, numero cedolini |
| `noipa_pendolarismo` | ~25k | 2021-2026 | Domicilio vs sede di lavoro, distanza KM |
| `noipa_assenze` | ~140k | 2019-2026 | Assenze per causale (malattia, congedi, aspettative) |
| `noipa_ritenute_previdenziali` | ~110k | 2019-2026 | Contributi INPS: split dipendente/datore |

**Totale**: ~345k righe/mese, ~33 milioni di righe dal 2019.

Fonte: [dati-noipa.mef.gov.it](https://dati-noipa.mef.gov.it/cl/web/open-data/dataset) (MEF/RGS, CC-BY-4.0).

## Esempi di domande

- **Quanti dipendenti ha Roma vs Napoli?** E come crescono dal 2019?
- **Quanto guadagna in media un funzionario comunale?** (imponibile medio per cedolino)
- **Quanto costa all'erario ogni dipendente?** (stipendio + contributi previdenziali)
- **Dove vivono i dipendenti pubblici?** (pendolarismo: 61% commuta, 26% oltre 60km)
- **Quanti giorni di malattia per comparto?** (assenze: 800M giorni/anno solo per malattia)
- **Quanto paga il datore di lavoro di contributi?** (72.5% del totale previdenziale)

## Come accedere

### DuckDB (consigliato)

```sql
-- Esempio: top 10 comuni per dipendenti
SELECT comune_della_sede, SUM(totale_amministrati) as totale
FROM read_parquet('out/data/mart/noipa_amministrati/*/mart_amministrati.parquet')
GROUP BY 1 ORDER BY 2 DESC LIMIT 10;
```

### Parquet direttamente

I file `.parquet` in `out/data/mart/` sono leggibili da pandas, Polars, DuckDB, Spark.

### Pipeline completa

```bash
pip install -e ".[dev,pipeline]"
TOOLKIT_ALLOW_SCRIPT_SOURCE=1 make run
```

## Approfondimenti

- [Confronto NoiPA vs Conto Annuale](../../pubblica-amministrazione/open-conto-annuale/) — NoiPA copre ~50% della PA (MEF), Conto Annuale tutta
- [Dati IPA](../../pubblica-amministrazione/indice-pa/) — anagrafica enti pubblici

## Partecipa

Hai domande sui dipendenti pubblici? Vuoi analisi specifiche? [Aprile una Discussion](../../dataciviclab/discussions).

## Licenza

[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) — dati MEF/RGS, elaborazione DataCivicLab.
