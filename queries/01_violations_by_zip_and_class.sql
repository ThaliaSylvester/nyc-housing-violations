-- How many violations are in each zip code, by hazard class?
-- Class A = non-hazardous, B = hazardous, C = immediately hazardous, I = orders

SELECT housenumber, streetname,
  COUNT(*) AS open_violations,
  COUNT(DISTINCT apartment) AS apartments_cited,
  MAX(inspectiondate) AS latest_inspection
aFROM violations
GROUP BY zip, class
ORDER BY zip, class;