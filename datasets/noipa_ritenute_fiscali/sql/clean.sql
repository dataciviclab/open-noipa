-- noipa_ritenute_fiscali: clean layer
-- Solo typing/cast. Niente aggregazioni.
SELECT
    normalize_string(comune_della_sede) AS comune_della_sede,
    normalize_string(amministrazione) AS amministrazione,
    cast_int(eta_min) AS eta_min,
    COALESCE(cast_int(eta_max), 999) AS eta_max,
    normalize_string(sesso) AS sesso,
    cast_double(imponibile_fiscale) AS imponibile_fiscale,
    cast_double(importo_IRPEF) AS importo_IRPEF,
    cast_bigint(numero_cedolini) AS numero_cedolini,
    month
FROM raw_input
