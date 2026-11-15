-- Which buildings had class C violations in each of the last three full years?
-- 2026 is excluded because it is a partial year.

WITH yearly AS (
  SELECT housenumber, streetname,
    year(inspectiondate) AS yr,
    COUNT(*) AS c_violations
  FROM violations
  WHERE class = 'C'
    AND year(inspectiondate) BETWEEN 2023 AND 2025
  GROUP BY housenumber, streetname, yr
)
SELECT housenumber, streetname,
  COUNT(*) AS years_with_c,
  SUM(c_violations) AS total_c
FROM yearly
GROUP BY housenumber, streetname
HAVING COUNT(*) = 3
ORDER BY total_c DESC
LIMIT 20;