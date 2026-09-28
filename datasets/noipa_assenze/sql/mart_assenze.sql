-- noipa_assenze: mart principale
-- Sintesi per causale e granularità: totale assenze, n_comuni, n_amministrazioni.
-- Le ore (HH) e i giorni (GG) restano separati — non si sommano.
SELECT
    motivazione_assenza,
    granularita_assenza,
    SUM(numero) AS totale,
    COUNT(DISTINCT comune_della_sede) AS n_comuni,
    COUNT(DISTINCT amministrazione) AS n_amministrazioni,
    month
FROM clean_input
GROUP BY motivazione_assenza, granularita_assenza, month
