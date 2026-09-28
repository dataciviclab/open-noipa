-- noipa_contratti: mart principale
-- Sintesi per comparto: totale personale, top amministrazioni.
-- Primary key: comparto, month
SELECT
    comparto,
    SUM(numero) AS totale_personale,
    ROUND(SUM(CASE WHEN sesso = 'F' THEN numero ELSE 0 END) * 100.0 / SUM(numero), 1) AS pct_donne,
    COUNT(DISTINCT amministrazione) AS n_amministrazioni,
    month
FROM clean_input
GROUP BY comparto, month
