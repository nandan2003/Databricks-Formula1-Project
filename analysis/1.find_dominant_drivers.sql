-- Databricks notebook source
-- Select driver name, total races, total points, and average points
SELECT driver_name,
       COUNT(1) AS total_races, -- Count of races per driver
       SUM(calculated_points) AS total_points, -- Sum of points per driver
       AVG(calculated_points) AS avg_points -- Average points per driver
  FROM f1_presentation.calculated_race_results
GROUP BY driver_name -- Group by driver name
HAVING COUNT(1) >= 50 -- Only include drivers with at least 50 races
ORDER BY avg_points DESC -- Order by average points in descending order

-- COMMAND ----------

-- Select driver name, total races, total points, and average points for races between 2011 and 2020
SELECT driver_name,
       COUNT(1) AS total_races, -- Count of races per driver
       SUM(calculated_points) AS total_points, -- Sum of points per driver
       AVG(calculated_points) AS avg_points -- Average points per driver
  FROM f1_presentation.calculated_race_results
 WHERE race_year BETWEEN 2011 AND 2020 -- Filter races between 2011 and 2020
GROUP BY driver_name -- Group by driver name
HAVING COUNT(1) >= 50 -- Only include drivers with at least 50 races
ORDER BY avg_points DESC -- Order by average points in descending order

-- COMMAND ----------

-- Select driver name, total races, total points, and average points for races between 2001 and 2010
SELECT driver_name,
       COUNT(1) AS total_races, -- Count of races per driver
       SUM(calculated_points) AS total_points, -- Sum of points per driver
       AVG(calculated_points) AS avg_points -- Average points per driver
  FROM f1_presentation.calculated_race_results
 WHERE race_year BETWEEN 2001 AND 2010 -- Filter races between 2001 and 2010
GROUP BY driver_name -- Group by driver name
HAVING COUNT(1) >= 50 -- Only include drivers with at least 50 races
ORDER BY avg_points DESC -- Order by average points in descending order