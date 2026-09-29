-- noipa_pendolarismo: clean layer
-- Solo typing/cast. Niente aggregazioni.
-- Le colonne distance possono essere ' ' → cast_double restituisce NULL, poi COALESCE a 0.
SELECT
    normalize_string(provincia_della_sede) AS provincia_della_sede,
    normalize_string(comune_della_sede) AS comune_della_sede,
    normalize_string(stesso_comune) AS stesso_comune,
    normalize_string(ente) AS ente,
    COALESCE(cast_double(distance_min_KM), 0) AS distance_min_KM,
    COALESCE(cast_double(distance_max_KM), 0) AS distance_max_KM,
    cast_bigint(numero_amministrati) AS numero_amministrati,
    month
FROM raw_input
