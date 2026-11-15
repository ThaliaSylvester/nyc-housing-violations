-- What are the most common serious (class C) problems?
-- Categories are matched on phrases in the violation description.

SELECT
  CASE
    WHEN novdescription ILIKE '%provide hot water%'
      OR novdescription ILIKE '%supply of hot water%' THEN 'No hot water'
    WHEN novdescription ILIKE '%supply of heat%' THEN 'No heat'
    WHEN novdescription ILIKE '%roach%' THEN 'Roaches'
    WHEN novdescription ILIKE '%mice%' THEN 'Mice'
    WHEN novdescription ILIKE '%lead-based paint%' THEN 'Lead paint'
    WHEN novdescription ILIKE '%plaster%' THEN 'Broken plaster'
    ELSE 'Other'
  END AS problem,
  COUNT(*) AS n
FROM violations
WHERE class = 'C'
GROUP BY problem
ORDER BY n DESC;