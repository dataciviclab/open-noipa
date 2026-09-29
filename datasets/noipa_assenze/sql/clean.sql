-- noipa_assenze: clean layer
-- Solo typing/cast. Niente aggregazioni.
SELECT
    normalize_string(comune_della_sede) AS comune_della_sede,
    normalize_string(amministrazione) AS amministrazione,
    cast_int(eta_min) AS eta_min,
    COALESCE(cast_int(eta_max), 999) AS eta_max,
    normalize_string(sesso) AS sesso,
    normalize_string(motivazione_assenza) AS motivazione_assenza,
    normalize_string(granularita_assenza) AS granularita_assenza,
    cast_double(numero) AS numero,
    month
FROM raw_input
