-- Databricks notebook source
-- Create the f1_raw database if it does not already exist
CREATE DATABASE IF NOT EXISTS f1_raw;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Create tables for CSV files

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create circuits table

-- COMMAND ----------

-- Drop the circuits table if it exists
DROP TABLE IF EXISTS f1_raw.circuits;

-- Create the circuits table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.circuits(
  circuitId INT,
  circuitRef STRING,
  name STRING,
  location STRING,
  country STRING,
  lat DOUBLE,
  lng DOUBLE,
  alt INT,
  url STRING
)
USING csv
OPTIONS (path "/mnt/sgformula1dl/raw/circuits.csv", header true);

-- COMMAND ----------

-- Select all columns from the circuits table in the f1_raw database
SELECT * FROM f1_raw.circuits;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create races table

-- COMMAND ----------

-- Drop the races table if it exists
DROP TABLE IF EXISTS f1_raw.races;

-- Create the races table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.races(
  raceId INT,
  year INT,
  round INT,
  circuitId INT,
  name STRING,
  date DATE,
  time STRING,
  url STRING
)
USING csv
OPTIONS (path "/mnt/sgformula1dl/raw/races.csv", header true);

-- COMMAND ----------

-- Select all columns from the races table in the f1_raw database
SELECT * FROM f1_raw.races;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Create tables for JSON files

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create constructors table
-- MAGIC * Single Line JSON
-- MAGIC * Simple structure

-- COMMAND ----------

-- Drop the constructors table if it exists
DROP TABLE IF EXISTS f1_raw.constructors;

-- Create the constructors table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.constructors(
  constructorId INT,
  constructorRef STRING,
  name STRING,
  nationality STRING,
  url STRING
)
USING json
OPTIONS (path "/mnt/sgformula1dl/raw/constructors.json");

-- COMMAND ----------

-- Select all columns from the constructors table in the f1_raw database
SELECT * FROM f1_raw.constructors;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create drivers table
-- MAGIC * Single Line JSON
-- MAGIC * Complex structure

-- COMMAND ----------

-- Drop the drivers table if it exists
DROP TABLE IF EXISTS f1_raw.drivers;

-- Create the drivers table with specified schema and load data from JSON file
CREATE TABLE IF NOT EXISTS f1_raw.drivers(
  driverId INT,
  driverRef STRING,
  number INT,
  code STRING,
  name STRUCT<forename: STRING, surname: STRING>,
  dob DATE,
  nationality STRING,
  url STRING
)
USING json
OPTIONS (path "/mnt/sgformula1dl/raw/drivers.json");

-- COMMAND ----------

-- MAGIC %md ##### Create results table
-- MAGIC * Single Line JSON
-- MAGIC * Simple structure

-- COMMAND ----------

-- Drop the results table if it exists
DROP TABLE IF EXISTS f1_raw.results;

-- Create the results table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.results(
  resultId INT,
  raceId INT,
  driverId INT,
  constructorId INT,
  number INT,
  grid INT,
  position INT,
  positionText STRING,
  positionOrder INT,
  points INT,
  laps INT,
  time STRING,
  milliseconds INT,
  fastestLap INT,
  rank INT,
  fastestLapTime STRING,
  fastestLapSpeed FLOAT,
  statusId STRING
)
USING json
OPTIONS(path "/mnt/sgformula1dl/raw/results.json");

-- COMMAND ----------

-- Select all columns from the results table
SELECT * FROM f1_raw.results;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create pit stops table
-- MAGIC * Multi Line JSON
-- MAGIC * Simple structure

-- COMMAND ----------

-- Drop the pit_stops table if it exists
DROP TABLE IF EXISTS f1_raw.pit_stops;

-- Create the pit_stops table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.pit_stops(
  driverId INT,
  duration STRING,
  lap INT,
  milliseconds INT,
  raceId INT,
  stop INT,
  time STRING
)
USING json
OPTIONS(path "/mnt/sgformula1dl/raw/pit_stops.json", multiLine true);

-- COMMAND ----------

-- Select all columns from the pit_stops table
SELECT * FROM f1_raw.pit_stops;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Create tables for list of files

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create Lap Times Table
-- MAGIC * CSV file
-- MAGIC * Multiple files

-- COMMAND ----------

-- Drop the lap_times table if it exists
DROP TABLE IF EXISTS f1_raw.lap_times;

-- Create the lap_times table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.lap_times(
  raceId INT,
  driverId INT,
  lap INT,
  position INT,
  time STRING,
  milliseconds INT
)
USING csv
OPTIONS (path "/mnt/sgformula1dl/raw/lap_times");

-- COMMAND ----------

-- Select all columns from the lap_times table
SELECT * FROM f1_raw.lap_times;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##### Create Qualifying Table
-- MAGIC * JSON file
-- MAGIC * MultiLine JSON
-- MAGIC * Multiple files

-- COMMAND ----------

-- Drop the qualifying table if it exists
DROP TABLE IF EXISTS f1_raw.qualifying;

-- Create the qualifying table if it does not already exist
CREATE TABLE IF NOT EXISTS f1_raw.qualifying(
  constructorId INT,
  driverId INT,
  number INT,
  position INT,
  q1 STRING,
  q2 STRING,
  q3 STRING,
  qualifyId INT,
  raceId INT
)
USING json
OPTIONS (path "/mnt/sgformula1dl/raw/qualifying", multiLine true);

-- COMMAND ----------

-- Select all columns from the qualifying table
SELECT * FROM f1_raw.qualifying;

-- COMMAND ----------

-- Describe the structure and metadata of the qualifying table
DESC EXTENDED f1_raw.qualifying;
