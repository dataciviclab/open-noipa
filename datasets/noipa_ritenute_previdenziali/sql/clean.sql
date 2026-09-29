-- noipa_ritenute_previdenziali: clean layer
-- Solo typing/cast. Niente aggregazioni.
SELECT
    comune_della_sede,
    amministrazione,
    CAST(eta_min AS INTEGER) AS eta_min,
    CASE
        WHEN TRIM(eta_max) = '' OR eta_max IS NULL THEN 999
        ELSE CAST(TRIM(eta_max) AS INTEGER)
    END AS eta_max,
    sesso,
    ritenuta_previdenziale,
    CAST(importo_lavoratore AS DOUBLE) AS importo_lavoratore,
    CAST(importo_datore AS DOUBLE) AS importo_datore,
    CAST(numero_cedolini AS BIGINT) AS numero_cedolini,
    month
FROM raw_input
