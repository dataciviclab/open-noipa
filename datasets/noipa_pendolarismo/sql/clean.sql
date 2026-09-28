-- noipa_pendolarismo: clean layer
-- Solo typing/cast. Niente aggregazioni (vanno nel mart).
-- Le colonne distance possono essere ' ' per chi non si sposta.
SELECT
    provincia_della_sede,
    comune_della_sede,
    stesso_comune,
    ente,
    CASE WHEN TRIM(distance_min_KM) = '' OR distance_min_KM IS NULL THEN 0
         ELSE CAST(TRIM(distance_min_KM) AS DOUBLE) END AS distance_min_KM,
    CASE WHEN TRIM(distance_max_KM) = '' OR distance_max_KM IS NULL THEN 0
         ELSE CAST(TRIM(distance_max_KM) AS DOUBLE) END AS distance_max_KM,
    CAST(numero_amministrati AS BIGINT) AS numero_amministrati,
    month
FROM raw_input
