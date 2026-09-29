-- noipa_contratti: clean layer
-- Solo typing/cast. Niente aggregazioni.
-- 2019 usa 'qualifica_contrattuale', 2020+ usa 'inquadramento' → lo script normalizza.
SELECT
    normalize_string(provincia_della_sede) AS provincia_della_sede,
    normalize_string(amministrazione) AS amministrazione,
    cast_int(eta_min) AS eta_min,
    COALESCE(cast_int(eta_max), 999) AS eta_max,
    normalize_string(sesso) AS sesso,
    normalize_string(comparto) AS comparto,
    normalize_string(inquadramento) AS inquadramento,
    cast_bigint(numero) AS numero,
    month
FROM raw_input
