# Contributing

Guida alla contribuzione per open-noipa.

## Setup

```bash
git clone https://github.com/dataciviclab/open-noipa.git
cd open-noipa
pip install -e ".[dev,pipeline]"
```

## Pipeline

I dati vengono scaricati dal portale open data NoiPA come CSV aggregati,
poi passati attraverso clean (cast) e mart (pass-through).

### Aggiungere un nuovo entry type

1. Creare `datasets/noipa_<slug>/dataset.yml` con `type: script`
2. Creare `sql/clean.sql` e `sql/mart_<slug>.sql`
3. Usare `scripts/fetch_noipa.py <EntryType> raw_input.csv`

### Eseguire

```bash
make run      # tutti i dataset
make check    # valida config
make clean    # pulisci output
```

## Fonte dati

- Portale: https://dati-noipa.mef.gov.it/cl/web/open-data/dataset
- License: CC-BY-4.0
- Dati mensili 2019-2026, 19 entry types disponibili
