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

## noipa_assenze

| Colonna | Tipo | Descrizione |
|---|---|---|
| comune_della_sede | VARCHAR | Comune della sede di servizio |
| amministrazione | VARCHAR | Nome amministrazione |
| eta_min | INTEGER | Limite inferiore fascia di età |
| eta_max | INTEGER | Limite superiore fascia di età (999 = aperta) |
| sesso | VARCHAR | F / M |
| motivazione_assenza | VARCHAR | Causale (malattia, congedi, aspettative, ...) |
| granularita_assenza | VARCHAR | `GG` giornaliera / `HH` oraria (prima di 2025-06: `G` / `H`) |
| numero | DOUBLE | Quantità di assenza. **Unità non documentata dalla fonte**: per `GG` l'ipotesi è centesimi di giornata (÷100), per `HH` ore. Non usare come giorni finché MEF/RGS non conferma |
| month | VARCHAR | YYYYMM |

### Discontinuità giugno 2025

Da `2025-06` la fonte ha cambiato tassonomia e copertura:

- granularità `G`/`H` → `GG`/`HH`;
- causali rinominate o accorpate (es. `ALTRE ASSENZE` → `ALTRE RIDUZIONI`; spariscono `CONGEDI PARENTALI`, `INDENNITA' ART.42`, `ASSEGNI ALIMENTARI`, ...);
- amministrazioni distinte 83 → 56, poi 51-57; spariscono 27 enti locali (ASL, comuni, ARPAL, ...);
- lo stesso calo di enti si osserva in `noipa_contratti` (56 → 51), `noipa_ritenute_fiscali` (63 → 50) e `noipa_ritenute_previdenziali` (64 → 49).

Le serie prima e dopo giugno 2025 **non sono confrontabili** per causale e per ente. Per le analisi, trattare i due periodi separatamente.

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
