-- noipa_contratti: mart principale
-- Aggregazione: somma duplicati per comparto × amministrazione × fascia età.
SELECT
    provincia_della_sede,
    amministrazione,
    eta_min,
    eta_max,
    sesso,
    comparto,
    inquadramento,
    SUM(numero) AS numero,
    month
FROM clean_input
GROUP BY provincia_della_sede, amministrazione, eta_min, eta_max, sesso, comparto, inquadramento, month
