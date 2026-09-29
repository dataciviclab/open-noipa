-- noipa_ritenute_previdenziali: mart principale
-- Aggregazione per tipo contributo: somma importi e cedolini, split % datore.
-- I dati raw hanno righe per comune/amministrazione/eta → qui si aggregano tutto.
SELECT
    ritenuta_previdenziale,
    ROUND(SUM(importo_lavoratore) / 1e6, 2) AS totale_lavoratore,
    ROUND(SUM(importo_datore) / 1e6, 2) AS totale_datore,
    ROUND((SUM(importo_lavoratore) + SUM(importo_datore)) / 1e6, 2) AS totale,
    SUM(numero_cedolini) AS n_cedolini,
    ROUND(SUM(importo_datore) * 100.0 / NULLIF(SUM(importo_lavoratore) + SUM(importo_datore), 0), 1) AS pct_datore,
    month
FROM clean_input
GROUP BY ritenuta_previdenziale, month
