# Dizionario dati

## noipa_amministrati

| Colonna | Tipo | Descrizione |
|---|---|---|
| comune_della_sede | VARCHAR | Comune della sede di servizio |
| eta_min | INTEGER | Limite inferiore fascia di età |
| eta_max | INTEGER | Limite superiore fascia di età |
| sesso | VARCHAR | F / M |
| numero | BIGINT | Numero di amministrati |
| month | VARCHAR | YYYYMM (es. 202608) |

## noipa_contratti

| Colonna | Tipo | Descrizione |
|---|---|---|
| provincia_della_sede | VARCHAR | Provincia della sede |
| amministrazione | VARCHAR | Nome amministrazione |
| eta_min | INTEGER | Limite inferiore fascia di età |
| eta_max | INTEGER | Limite superiore fascia di età |
| sesso | VARCHAR | F / M |
| comparto | VARCHAR | Comparto di appartenenza |
| inquadramento | VARCHAR | Livello/tipo di inquadramento |
| numero | BIGINT | Numero di amministrati |
| month | VARCHAR | YYYYMM |

## noipa_ritenute_fiscali

| Colonna | Tipo | Descrizione |
|---|---|---|
| comune_della_sede | VARCHAR | Comune della sede |
| amministrazione | VARCHAR | Nome amministrazione |
| eta_min | INTEGER | Limite inferiore fascia di età |
| eta_max | INTEGER | Limite superiore fascia di età |
| sesso | VARCHAR | F / M |
| imponibile_fiscale | DOUBLE | Totale imponibile fiscale (€) |
| importo_IRPEF | DOUBLE | Totale importo IRPEF (€) |
| numero_cedolini | BIGINT | Numero di cedolini |
| month | VARCHAR | YYYYMM |
