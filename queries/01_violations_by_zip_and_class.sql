-- How many violations are in each zip code, by hazard class?
-- Class A = non-hazardous, B = hazardous, C = immediately hazardous, I = orders

-- Summarize violation counts by ZIP code and hazard class
-- to compare housing conditions and severity across neighborhoods.

SELECT zip, class, COUNT(*) AS violation_count
FROM violations
GROUP BY zip, class
ORDER BY zip, class;
