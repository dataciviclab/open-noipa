-- noipa_amministrati: clean layer
-- Solo typing/cast. Niente aggregazioni.
-- Macro standard: cast_int, cast_bigint, normalize_string.
SELECT
    normalize_string(comune_della_sede) AS comune_della_sede,
    cast_int(eta_min) AS eta_min,
    COALESCE(cast_int(eta_max), 999) AS eta_max,
    normalize_string(sesso) AS sesso,
    cast_bigint(numero) AS numero,
    month
FROM raw_input
