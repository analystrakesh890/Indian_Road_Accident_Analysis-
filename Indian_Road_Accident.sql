USE roads_db;

SELECT COUNT(*) AS total_rows FROM accidents;

SELECT accident_severity,
       COUNT(*) AS accidents,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM accidents), 1) AS percent
FROM accidents
GROUP BY accident_severity
ORDER BY accidents DESC; 

#fatal rate by cause
SELECT cause,
       COUNT(*) AS accidents,
       SUM(CASE WHEN accident_severity = 'Fatal' THEN 1 ELSE 0 END) AS fatal,
       ROUND(100.0 * SUM(CASE WHEN accident_severity = 'Fatal' THEN 1 ELSE 0 END) / COUNT(*), 1) AS fatal_rate
FROM accidents
GROUP BY cause
ORDER BY fatal_rate DESC, cause;


SELECT COUNT(*) AS fatal_highway_fog
FROM accidents
WHERE accident_severity = 'Fatal'
  AND road_type = 'Highway'
  AND weather = 'Fog';
  
  SELECT city,
       COUNT(*) AS accidents,
       ROUND(100 * AVG(accident_severity = 'Fatal'), 1) AS fatal_rate
FROM accidents
GROUP BY city
HAVING fatal_rate > 15
ORDER BY fatal_rate DESC, city


USE roads_db;

CREATE TABLE city_info (
    city   VARCHAR(50) PRIMARY KEY,
    region VARCHAR(20)
);

INSERT INTO city_info (city, region) VALUES
  ('Delhi', 'North'),
  ('Chandigarh', 'North'),
  ('Jaipur', 'North'),
  ('Mumbai', 'West'),
  ('Pune', 'West'),
  ('Bangalore', 'South'),
  ('Chennai', 'South'),
  ('Hyderabad', 'South'),
  ('Kolkata', 'East');

SELECT * FROM city_info;

SELECT c.region,
       COUNT(*) AS accidents,
       ROUND(100 * AVG(a.accident_severity = 'Fatal'), 1) AS fatal_rate
FROM accidents a
JOIN city_info c ON a.city = c.city
GROUP BY c.region
ORDER BY accidents DESC;

SELECT c.city
FROM city_info c
LEFT JOIN accidents a ON a.city = c.city
WHERE a.accident_id IS NULL;


USE roads_db;

WITH yearly AS (
    SELECT YEAR(date) AS yr, COUNT(*) AS accidents
    FROM accidents
    GROUP BY YEAR(date)
)
SELECT yr,
       accidents,
       LAG(accidents) OVER (ORDER BY yr) AS prev_year,
       accidents - LAG(accidents) OVER (ORDER BY yr) AS yoy_change
FROM yearly
ORDER BY yr;
/*For each severity level, show the number of accidents, total casualties, 
and the percentage of all casualties it accounts for*/
SELECT accident_severity,
       COUNT(*) AS accidents,
       SUM(casualties) AS casualties,
       ROUND(100 * SUM(casualties) / (SELECT SUM(casualties) FROM accidents), 1) AS casualty_share
FROM accidents
GROUP BY accident_severity
ORDER BY casualties DESC;

/*: List every city in city_info with its number of accidents, including cities that have no accidents.*/
SELECT c.city,
       c.region,
       COUNT(a.accident_id) AS accidents
FROM city_info c
LEFT JOIN accidents a ON a.city = c.city
GROUP BY c.city, c.region
ORDER BY accidents DESC;

/*For each city, find the cause with the most fatal accidents.*/
WITH city_cause AS (
    SELECT city, cause,
           SUM(accident_severity = 'Fatal') AS fatal
    FROM accidents
    GROUP BY city, cause
),
ranked AS (
    SELECT city, cause, fatal,
           RANK() OVER (PARTITION BY city ORDER BY fatal DESC) AS rnk
    FROM city_cause
)
SELECT city, cause, fatal
FROM ranked
WHERE rnk = 1
ORDER BY city;

/*Show the number of accidents per month in 2024 along with the cumulative total up to that month.*/
WITH monthly AS (
    SELECT MONTH(date) AS m, COUNT(*) AS accidents
    FROM accidents
    WHERE YEAR(date) = 2024
    GROUP BY MONTH(date)
)
SELECT m AS month_no,
       accidents,
       SUM(accidents) OVER (ORDER BY m) AS running_total
FROM monthly
ORDER BY m;

/*In a single query, compare festival days and normal days by number 
of accidents, fatal rate, and average casualties.*/
SELECT CASE WHEN is_festival = 1 THEN 'Festival' ELSE 'Normal' END AS day_type,
       COUNT(*) AS accidents,
       ROUND(100 * AVG(accident_severity = 'Fatal'), 1) AS fatal_rate,
       ROUND(AVG(casualties), 2) AS avg_casualties
FROM accidents
GROUP BY CASE WHEN is_festival = 1 THEN 'Festival' ELSE 'Normal' END
ORDER BY accidents DESC;







