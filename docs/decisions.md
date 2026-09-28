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
