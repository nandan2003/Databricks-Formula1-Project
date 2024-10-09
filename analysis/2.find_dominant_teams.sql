-- Databricks notebook source
-- Select team name, total races, total points, and average points
SELECT team_name,
       COUNT(1) AS total_races, -- Count of races per team
       SUM(calculated_points) AS total_points, -- Sum of points per team
       AVG(calculated_points) AS avg_points -- Average points per team
  FROM f1_presentation.calculated_race_results
GROUP BY team_name -- Group by team name
HAVING COUNT(1) >= 100 -- Filter teams with at least 100 races
ORDER BY avg_points DESC -- Order by average points in descending order

-- COMMAND ----------

-- Select team name, total races, total points, and average points for races between 2011 and 2020
SELECT team_name,
       COUNT(1) AS total_races, -- Count of races per team
       SUM(calculated_points) AS total_points, -- Sum of points per team
       AVG(calculated_points) AS avg_points -- Average points per team
  FROM f1_presentation.calculated_race_results
 WHERE race_year BETWEEN 2011 AND 2020 -- Filter races between 2011 and 2020
GROUP BY team_name -- Group by team name
HAVING COUNT(1) >= 100 -- Filter teams with at least 100 races
ORDER BY avg_points DESC -- Order by average points in descending order

-- COMMAND ----------

-- Select team name, total races, total points, and average points for races between 2001 and 2011
SELECT team_name,
       COUNT(1) AS total_races, -- Count of races per team
       SUM(calculated_points) AS total_points, -- Sum of points per team
       AVG(calculated_points) AS avg_points -- Average points per team
  FROM f1_presentation.calculated_race_results
 WHERE race_year BETWEEN 2001 AND 2011 -- Filter races between 2001 and 2011
GROUP BY team_name -- Group by team name
HAVING COUNT(1) >= 100 -- Filter teams with at least 100 races
ORDER BY avg_points DESC -- Order by average points in descending order