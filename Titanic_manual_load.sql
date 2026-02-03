USE DATABASE demo_db;
USE SCHEMA demo_sc;

-- 1. Create a Specific Stage for this dataset
-- A dedicated stage helps keep your Titanic data isolated from other uploads.
CREATE OR REPLACE STAGE titanic_stage
  FILE_FORMAT = (TYPE = 'PARQUET');


-- 2. Create the Target Table
CREATE OR REPLACE TABLE titanic_raw (
    passenger_id INT,
    survived BOOLEAN,  -- Loading as Boolean for better logic later
    pclass INT,
    full_name STRING,
    sex STRING,
    age FLOAT,
    fare FLOAT
);

-- 3. Load Data using "$" (Transformation)
-- Here we access the Parquet data as a single variant object ($1)
-- and manually pick/cast the fields we want.
COPY INTO titanic_raw (passenger_id, survived, pclass, full_name, sex, age, fare)
FROM (
  SELECT 
    $1:PassengerId::INT,
    CASE WHEN $1:Survived::INT = 1 THEN TRUE ELSE FALSE END, -- Transforming logic during load
    $1:Pclass::INT,
    $1:Name::STRING,
    $1:Sex::STRING,
    $1:Age::FLOAT,
    $1:Fare::FLOAT
  FROM @titanic_stage/titanic.parquet
)
FILE_FORMAT = (TYPE = 'PARQUET')
ON_ERROR = 'CONTINUE';

-- 4. Verify the Load
SELECT * FROM titanic_raw LIMIT 10;

-- 5. Create a View
-- This view adds a logic layer on top of the raw table (e.g., categorizing Age).
CREATE OR REPLACE VIEW v_titanic_summary AS
SELECT 
    passenger_id,
    full_name,
    sex,
    age,
    -- Create a derived column for Age Group
    CASE 
        WHEN age < 18 THEN 'Child'
        WHEN age BETWEEN 18 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category,
    pclass,
    fare,
    survived
FROM titanic_raw;

-- 6. Test the View
SELECT * FROM v_titanic_summary 
WHERE age_category = 'Child' 
ORDER BY fare DESC;


SELECT $1 
FROM @demo_db.demo_sc.titanic_stage/titanic.parquet
(FILE_FORMAT => 'my_parquet_format');

List @demo_db.demo_sc.titanic_stage;