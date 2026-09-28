-- noipa_pendolarismo: clean layer
-- Dati già puliti dal portale NoiPA. Cast minimi.
-- Le colonne distance possono essere ' ' per chi non si sposta.
-- Alcune righe duplicate → aggregazione con SUM.
WITH base AS (
    SELECT
        provincia_della_sede,
        comune_della_sede,
        stesso_comune,
        CASE WHEN TRIM(distance_min_KM) = '' OR distance_min_KM IS NULL THEN 0
             ELSE CAST(TRIM(distance_min_KM) AS DOUBLE) END AS distance_min_KM,
        CASE WHEN TRIM(distance_max_KM) = '' OR distance_max_KM IS NULL THEN 0
             ELSE CAST(TRIM(distance_max_KM) AS DOUBLE) END AS distance_max_KM,
        CAST(numero_amministrati AS BIGINT) AS numero_amministrati,
        month
    FROM raw_input
)
SELECT
    provincia_della_sede,
    comune_della_sede,
    stesso_comune,
    distance_min_KM,
    distance_max_KM,
    SUM(numero_amministrati) AS numero_amministrati,
    month
FROM base
GROUP BY provincia_della_sede, comune_della_sede, stesso_comune, distance_min_KM, distance_max_KM, month
