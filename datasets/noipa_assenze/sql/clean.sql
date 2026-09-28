-- noipa_assenze: clean layer
-- Dati già puliti dal portale NoiPA. Cast minimi.
-- eta_max può essere ' ' per la fascia 65+.
SELECT
    comune_della_sede,
    amministrazione,
    CAST(eta_min AS INTEGER) AS eta_min,
    CASE
        WHEN TRIM(eta_max) = '' OR eta_max IS NULL THEN 999
        ELSE CAST(TRIM(eta_max) AS INTEGER)
    END AS eta_max,
    sesso,
    motivazione_assenza,
    granularita_assenza,
    CAST(numero AS DOUBLE) AS numero,
    month
FROM raw_input
