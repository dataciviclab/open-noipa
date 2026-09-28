-- noipa_contratti: clean layer
-- Solo typing/cast. Niente aggregazioni (vanno nel mart).
-- 2019 usa 'qualifica_contrattuale', 2020+ usa 'inquadramento' → lo script normalizza.
SELECT
    provincia_della_sede,
    amministrazione,
    CAST(eta_min AS INTEGER) AS eta_min,
    CASE
        WHEN TRIM(eta_max) = '' OR eta_max IS NULL THEN 999
        ELSE CAST(TRIM(eta_max) AS INTEGER)
    END AS eta_max,
    sesso,
    comparto,
    inquadramento,
    CAST(numero AS BIGINT) AS numero,
    month
FROM raw_input
