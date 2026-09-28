-- noipa_pendolarismo: mart principale
-- Aggregazione: sintesi per comune con % stesso comune e distanza media.
-- La distanza media è stimata come punto medio della fascia (min+max)/2.
SELECT
    provincia_della_sede,
    comune_della_sede,
    stesso_comune,
    SUM(numero_amministrati) AS n_dipendenti,
    ROUND(
        SUM(CASE WHEN stesso_comune = 'SI' THEN numero_amministrati ELSE 0 END) * 100.0
        / SUM(numero_amministrati), 1
    ) AS pct_stesso_comune,
    ROUND(AVG((distance_min_KM + distance_max_KM) / 2.0), 1) AS distanza_media_stimata,
    month
FROM clean_input
GROUP BY provincia_della_sede, comune_della_sede, stesso_comune, month
