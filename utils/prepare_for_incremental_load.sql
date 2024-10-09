-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##### Drop all the tables

-- COMMAND ----------

-- Drop the f1_processed database if it exists, including all its objects
DROP DATABASE IF EXISTS f1_processed CASCADE;

-- COMMAND ----------

-- Create the f1_processed database if it does not exist, specifying its location
CREATE DATABASE IF NOT EXISTS f1_processed
LOCATION "/mnt/sgformula1dl/processed";

-- COMMAND ----------

-- Drop the f1_presentation database if it exists, including all its objects
DROP DATABASE IF EXISTS f1_presentation CASCADE;

-- COMMAND ----------

-- Create the f1_presentation database if it does not exist, specifying its location
CREATE DATABASE IF NOT EXISTS f1_presentation 
LOCATION "/mnt/sgformula1dl/presentation";