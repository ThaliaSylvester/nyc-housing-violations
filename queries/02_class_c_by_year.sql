-- Are the most serious (class C) violations rising or falling?
-- Note: 2026 is a partial year. Data runs through 2026-11-11.

-- Track annual Class C violation counts starting in 2015
-- to identify trends in immediately hazardous housing conditions.

SELECT year(inspectiondate) AS yr, COUNT(*) AS violation_count
FROM violations
WHERE class = 'C'
  AND year(inspectiondate) >= 2015
GROUP BY yr
ORDER BY yr;
