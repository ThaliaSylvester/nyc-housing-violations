# Vetting Apartment Buildings with NYC Housing Violation Data

## The question

As most New Yorkers know, the housing hunt is insane. After countless
Reddit threads and Google reviews, I decided the best way to figure out
which buildings were worth my time was to do what analysts do best: go
find the answer in the data. This project explores housing code
violations in Crown Heights and the surrounding area, to answer one
question: which buildings should a renter look into before signing a
lease?

## Data

- **Source:** NYC Open Data, Housing Maintenance Code Violations (HPD)
  https://data.cityofnewyork.us/d/wvxf-dwi5
- **Scope:** zip codes 11213, 11216, and 11225 (Crown Heights and parts of
  Bedford-Stuyvesant and Prospect Lefferts Gardens)
- **Size:** 604,929 violations, inspected through November 11, 2026
- **Tool:** DuckDB

## Findings

**1. About 23% of violations on record are still open.**
139,318 of 604,929. In zip code 11216 it is nearly a third.
This matters because it hints at how invested a property manager is.
Long-standing open violations can mean long waits for maintenance
requests. An open violation may also be one that was fixed but never
certified, so this is a signal, not proof.

**2. The most serious violations roughly doubled in 2019 and stayed high.**
Class C violations went from about 5,500 in 2018 to about 9,600 in 2019,
and have run between 11,000 and 13,300 a year since 2021.
Did buildings suddenly get twice as bad? Probably not. Pest violations
show up in a newer code format, so my guess is that the city changed
what gets written up as class C around then. I have not tested that yet.
The data also cannot tell me whether conditions got worse or inspectors
got busier.

**3. Lead paint and pests are the most common serious problems.**

| Problem | Class C violations |
|---|---|
| Lead paint | 16,406 |
| Roaches | 11,742 |
| Mice | 11,208 |
| No hot water | 10,116 |
| Broken plaster | 6,707 |
| No heat | 4,482 |

Is any of this surprising? No. But it is still startling to see as a
New York renter. If you are touring apartments in the area:

- Look for signs of mice and roaches: droppings, traps, and gaps around
  pipes.
- Run the taps. Check the water pressure and how long hot water takes.
- Look high and low for cracked or bulging plaster and water stains.
- Check for peeling or chipping paint, especially on window sills and
  door frames, and ask for the lead paint disclosure before you sign.

**4. Which buildings look worst depends on how you measure.**
My first ranking simply counted open hazardous violations per building,
and it was misleading in two ways. One building in the top 20 had 268
open violations, and every one of them dated from 2005 or earlier.
Another ranked third with 538, but they were spread across 129
apartments, about 4 each. Once I limited the list to violations since 2024 and divided by
apartments cited, the order changed: a building that had been seventh
on my first list had the highest rate per apartment in the top 20.
Four addresses stayed near the top however I measured, and those are the
ones I would research hardest before a tour.

## What I learned about the data

- Keywords lie. Searching for "heat" returned 14,182 violations, but
  only 4,482 were tenants without heat. Most of the rest were about
  locked boiler rooms.
- The current year is not finished. 2026 looked like an improvement
  until I checked that the data stops on November 11.
- "Open" does not mean recent. Some open violations are over 20 years
  old.
- Big buildings always look bad on raw counts. Adjusting for size
  changes the story.

## Limitations

- "Apartments cited" counts apartments with a violation, not total units.
- 57% of class C violations are uncategorized ("Other").
- Zip codes do not match neighborhood boundaries.
- More violations may reflect more inspections, not worse conditions.

## Queries

| File | Question |
|---|---|
| `01_violations_by_zip_and_class.sql` | How many violations, by zip and hazard class? |
| `02_class_c_by_year.sql` | Are serious violations rising or falling? |
| `03_class_c_by_problem.sql` | What are the most common serious problems? |
| `04_worst_buildings.sql` | Which buildings have the most open hazardous violations? |
| `05_repeat_offenders.sql` | Which buildings had serious violations three years running? |

## How to reproduce

In DuckDB:

    CREATE TABLE violations AS
    SELECT * FROM read_csv_auto([
      'https://data.cityofnewyork.us/resource/wvxf-dwi5.csv?zip=11213&$limit=1000000',
      'https://data.cityofnewyork.us/resource/wvxf-dwi5.csv?zip=11216&$limit=1000000',
      'https://data.cityofnewyork.us/resource/wvxf-dwi5.csv?zip=11225&$limit=1000000'
    ]);

## Next steps

- Test the 2019 theory by counting pest violations by year.
- Join the city's building data to get true unit counts.
- Add 311 heat and hot water complaints to see what tenants report
  versus what inspectors confirm.
- Sort the remaining "Other" violations into categories.
- Build a Power BI dashboard so a renter can look up any address.
