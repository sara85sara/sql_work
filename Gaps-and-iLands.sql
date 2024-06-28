--Gaps on Numbers

WITH C AS
(
    SELECT col1 AS cur, LEAD(col1) OVER(ORDER BY col1) AS nxt
    FROM dbo.T1
)
SELECT cur + 1 AS rangestart, nxt - 1 AS rangeend
FROM C
WHERE nxt - cur > 1;

--Gaps on Dates

WITH C AS
(
    SELECT col1 AS cur, LEAD(col1) OVER(ORDER BY col1) AS nxt
    FROM dbo.T2
)
SELECT DATEADD(day, 1, cur) AS rangestart, DATEADD(day, -1,nxt) rangeend
FROM C
WHERE DATEDIFF(day, cur, nxt) > 1;


--iLands on numbers

WITH C AS
(
    SELECT col1, col1 - DENSE_RANK() OVER(ORDER BY col1) AS grp
    FROM dbo.T1
)
SELECT MIN(col1) AS start_range, MAX(col1) AS end_range
FROM C
GROUP BY grp



--iLand on dates column
with c AS
(
    select datecolmn, DATEADD(dd, -1 * DENSE_RANK() OVER(ORDER by datecolmn), datecolmn) as grp
)

select min (datecolmn) as start_range, max(col1) as end_range
from C
GROUP by grp