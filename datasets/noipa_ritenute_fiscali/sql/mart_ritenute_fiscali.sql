-- noipa_ritenute_fiscali: mart principale
-- Sintesi IRPEF per comune: imponibile totale, IRPEF totale, aliquota media.
-- Primary key: comune_della_sede, month
SELECT
    comune_della_sede,
    ROUND(SUM(imponibile_fiscale) / 1e6, 2) AS imponibile_mln_eur,
    ROUND(SUM(importo_IRPEF) / 1e6, 2) AS irpef_mln_eur,
    ROUND(
        CASE WHEN SUM(imponibile_fiscale) > 0
             THEN SUM(importo_IRPEF) * 100.0 / SUM(imponibile_fiscale)
             ELSE 0
        END, 1
    ) AS aliota_media_pct,
    SUM(numero_cedolini) AS totale_cedolini,
    ROUND(SUM(imponibile_fiscale) / NULLIF(SUM(numero_cedolini), 0), 0) AS imponibile_medio_cedolino,
    month
FROM clean_input
GROUP BY comune_della_sede, month
