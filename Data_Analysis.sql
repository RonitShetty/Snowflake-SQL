USE DATABASE demo_db;
USE SCHEMA GOLD;

CREATE OR REPLACE TABLE DEMO_DB.GOLD.SURVIVAL_BY_AGE_GROUP AS 
SELECT
    CASE
        WHEN age<12 THEN 'Child'
        WHEN age BETWEEN 12 AND 18 THEN 'Teen'
        WHEN age BETWEEN 19 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS total_passengers,
    SUM(
    CASE 
        WHEN survived THEN 1
        ELSE 0
    END
) AS survivors,
ROUND(
     SUM(
     CASE
        WHEN survived THEN 1
        ELSE 0
    END
) * 100.0/COUNT(*),2
) AS survival_rate_pct
FROM demo_db.silver.titanic_passengers_dedup
WHERE age IS NOT NULL
GROUP BY
age_group;

SELECT * FROM DEMO_DB.GOLD.SURVIVAL_BY_AGE_GROUP;

CREATE OR REPLACE TABLE DEMO_DB.GOLD.SURVIVAL_BY_CLASS_GENDER AS
SELECT passenger_class, sex, COUNT(*) AS total_passengers,
SUM( CASE WHEN survived THEN 1 ELSE 0 END) AS survivors,
ROUND( SUM( CASE WHEN survived THEN 1 ELSE 0 END) * 100.0/ COUNT(*), 2) AS survival_rate_pct
FROM DEMO_DB.SILVER.TITANIC_PASSENGERS_DEDUP GROUP BY passenger_class, sex;

SELECT * FROM DEMO_DB.GOLD.SURVIVAL_BY_CLASS_GENDER;