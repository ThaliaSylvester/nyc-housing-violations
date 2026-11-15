-- Which buildings have the most open hazardous (class B and C) violations?
-- Only violations inspected since 2024, so old unclosed records are excluded.
-- apartments_cited is a rough stand-in for building size.

SELECT housenumber, streetname,
  COUNT(*) AS open_violations,
  COUNT(DISTINCT apartment) AS apartments_cited,
  MAX(inspectiondate) AS latest_inspection,
  ROUND(COUNT(*) * 1.0 / COUNT(DISTINCT apartment), 1) AS per_apartment
FROM violations
WHERE violationstatus = 'Open'
  AND class IN ('B', 'C')
  AND inspectiondate >= '2024-01-01'
GROUP BY housenumber, streetname
ORDER BY open_violations DESC
LIMIT 20;