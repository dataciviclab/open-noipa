-- noipa_amministrati: mart principale
-- Sintesi per comune: totale, % donne ponderata, % under35, % over55.
-- Le percentuali sono ponderate per numero di amministrati (non media semplice).
SELECT
    comune_della_sede,
    SUM(numero) AS totale_amministrati,
    ROUND(SUM(CASE WHEN sesso = 'F' THEN numero ELSE 0 END) * 100.0 / SUM(numero), 1) AS pct_donne,
    ROUND(SUM(CASE WHEN eta_min < 35 THEN numero ELSE 0 END) * 100.0 / SUM(numero), 1) AS pct_under35,
    ROUND(SUM(CASE WHEN eta_min >= 55 THEN numero ELSE 0 END) * 100.0 / SUM(numero), 1) AS pct_over55,
    month
FROM clean_input
GROUP BY comune_della_sede, month
