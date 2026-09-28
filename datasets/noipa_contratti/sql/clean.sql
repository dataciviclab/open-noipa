-- noipa_contratti: clean layer
-- Dati già puliti dal portale NoiPA. Cast minimi.
-- eta_max può essere ' ' per la fascia 65+ → convertito in 999.
-- Lo script normalizza qualifica_contrattuale → inquadramento.
-- Alcune righe duplicate → aggregazione con SUM(numero).
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
FROM (
    SELECT
        provincia_della_sede,
        amministrazione,
        CAST(eta_min AS INTEGER) AS eta_min,
        CASE
            WHEN TRIM(eta_max) = '' OR eta_max IS NULL THEN 999
            ELSE CAST(TRIM(eta_max) AS INTEGER)
        END AS eta_max,
        sesso,
        comparto,
        inquadramento,
        CAST(numero AS BIGINT) AS numero,
        month
    FROM raw_input
) sub
GROUP BY sub.provincia_della_sede, sub.amministrazione, sub.eta_min, sub.eta_max, sub.sesso, sub.comparto, sub.inquadramento, sub.month
