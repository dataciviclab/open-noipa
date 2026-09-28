# open-noipa

Personale della Pubblica Amministrazione italiana — dati NoiPA/MEF (2019-2026).

CSV aggregati dal portale open data `dati-noipa.mef.gov.it`, 3 dataset:
- **noipa_amministrati**: anagrafica per comune, età, genere
- **noipa_contratti**: comparto e inquadramento per provincia
- **noipa_ritenute_fiscali**: imponibile e IRPEF per comune

## Setup

```bash
pip install -e ".[dev,pipeline]"
```

## Uso

```bash
make check    # valida tutti i dataset.yml
make run      # esegui la pipeline
make clean    # pulisci output
```

## Fonte

- Portale: https://dati-noipa.mef.gov.it/cl/web/open-data/dataset
- SPARQL: https://sparql-noipa.mef.gov.it/sparql
- License: CC-BY-4.0

## Struttura

```
datasets/
├── noipa_amministrati/     anagrafica PA
├── noipa_contratti/        comparto + inquadramento
└── noipa_ritenute_fiscali/ redditi + IRPEF
scripts/
└── fetch_noipa.py          download CSV dal portale
```
