# Decisioni

## 2026-09-28: CSV dal portale invece di SPARQL

**Decisione**: Usare i CSV aggregati dal portale open data anziché interrogare
l'endpoint SPARQL.

**Motivazione**: L'endpoint SPARQL ha un hard limit Virtuoso di 10k righe per
query. Con ~500k triples/mese × 80 mesi, il fetch richiedeva ~10 ore.
Il portale fornisce CSV già puliti e aggregati (~18-36k righe/mese) in
~100-300KB ZIP, scaricabili in ~1 secondo.

**Trade-off**: I CSV sono aggregati (non triples raw) — meno flessibili
per query SPARQL arbitrarie, ma perfetti per analisi tabulare.

## 2026-11-26: `noipa_assenze` sospeso dalle analisi finché la fonte non chiarisce l'unità

**Stato**: aperto. Issue [#13](https://github.com/dataciviclab/open-noipa/issues/13).

**Evidenza**:
- `howManyAssenze`/`numero` è descritto dalla fonte come «numero di ore o
  giorni», senza scala né periodo di cumulo.
- I valori `GG` sono incompatibili con giorni per dipendente al mese
  (2024-04: 199,36 M unità / 1,81 M amministrati ≈ 110; per età 2,5–157).
- L'ipotesi più coerente è **centesimi di giornata** (÷100): per età
  0,03–1,57 giorni/mese; `HH` tornano come ore.
- Da **2025-06** la fonte ha cambiato tassonomia (`G`/`H` → `GG`/`HH`,
  causali rinominate/accorpate) e copertura (83 → 56 enti; spariscono ASL,
  comuni, ARPAL, ...). Lo stesso calo di enti è in contratti, fiscali e
  previdenziali: è un cambio di fonte, non dell'extract.

**Decisione**:
- non applicare conversioni (÷100) a clean/mart finché MEF/RGS non conferma;
- non usare `noipa_assenze` per confronti pre/post giugno 2025 né per claim
  su «giorni di malattia»;
- aggiornare README, data dictionary e Discussion #10 con l'avvertenza;
- chiedere chiarimento a `ufficio9dsii.dag@mef.gov.it` (punto di contatto DCAT).

**Riferimenti**: manuale LOD NoiPA §2.27, OWL `howManyAssenze`,
metadati DCAT del dataset, Discussion #10.
