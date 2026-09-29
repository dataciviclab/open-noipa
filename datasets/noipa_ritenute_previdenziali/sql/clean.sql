-- noipa_ritenute_previdenziali: clean layer
-- Solo typing/cast. Niente aggregazioni.
SELECT
    normalize_string(comune_della_sede) AS comune_della_sede,
    normalize_string(amministrazione) AS amministrazione,
    cast_int(eta_min) AS eta_min,
    COALESCE(cast_int(eta_max), 999) AS eta_max,
    normalize_string(sesso) AS sesso,
    normalize_string(ritenuta_previdenziale) AS ritenuta_previdenziale,
    cast_double(importo_lavoratore) AS importo_lavoratore,
    cast_double(importo_datore) AS importo_datore,
    cast_bigint(numero_cedolini) AS numero_cedolini,
    month
FROM raw_input
