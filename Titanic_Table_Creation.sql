DEMO_DB.DEMO_SC.MY_INTERNAL_STAGEUSE DATABASE demo_db;
USE SCHEMA demo_sc;

-- 1. Create a specific File Format for Parquet
-- Parquet is binary, so we don't need to skip headers or set delimiters.
CREATE OR REPLACE FILE FORMAT my_parquet_format
  TYPE = 'PARQUET'
  COMPRESSION = 'AUTO';

-- 2. Create the Table
CREATE OR REPLACE TABLE titanic (
    PassengerId INT,
    Survived INT,
    Pclass INT,
    Name STRING,
    Sex STRING,
    Age FLOAT,
    SibSp INT,
    Parch INT,
    Ticket STRING,
    Fare FLOAT,
    Cabin STRING,
    Embarked STRING
);

-- 3. Verify
SELECT * FROM titanic LIMIT 10;
