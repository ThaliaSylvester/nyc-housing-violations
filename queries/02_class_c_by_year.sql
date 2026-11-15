-- Are the most serious (class C) violations rising or falling?
-- Note: 2026 is a partial year. Data runs through 2026-11-11.

SELECT year(inspectiondate) AS yr, COUNT(*) AS violation_count
FROM violations
WHERE class = 'C'
  AND year(inspectiondate) >= 2021
GROUP BY yr
ORDER BY yr;