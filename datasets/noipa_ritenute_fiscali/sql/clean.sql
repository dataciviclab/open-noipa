-- noipa_ritenute_fiscali: clean layer
-- Dati già puliti dal portale NoiPA. Cast minimi.
-- eta_max può essere ' ' per la fascia 65+ → convertito in 999.
SELECT
    comune_della_sede,
    amministrazione,
    CAST(eta_min AS INTEGER) AS eta_min,
    CASE
        WHEN TRIM(eta_max) = '' OR eta_max IS NULL THEN 999
        ELSE CAST(TRIM(eta_max) AS INTEGER)
    END AS eta_max,
    sesso,
    CAST(imponibile_fiscale AS DOUBLE) AS imponibile_fiscale,
    CAST(importo_IRPEF AS DOUBLE) AS importo_IRPEF,
    CAST(numero_cedolini AS BIGINT) AS numero_cedolini,
    month
FROM raw_input
