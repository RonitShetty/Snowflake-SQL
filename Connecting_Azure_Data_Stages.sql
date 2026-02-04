USE DATABASE demo_db;
CREATE SCHEMA raw;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

USE SCHEMA silver;

create or replace storage integration azure_int
type = external_stage
storage_provider = azure
enabled = true
azure_tenant_id = '42d74fda-bcb1-41e8-8d81-049031eb498a'
storage_allowed_locations = ('azure://snowflakebucket.blob.core.windows.net/employee','azure://snowflakebucket.blob.core.windows.net/parquetdata');

desc integration azure_int;

CREATE FILE FORMAT "DEMO_DB"."PUBLIC".MY_PARQUET_STAGE TYPE = 'PARQUET' COMPRESSION = 'AUTO' BINARY_AS_TEXT = TRUE;

create or replace stage demo_db.public.my_azure_parquet_stage_titanic storage_integration = azure_int url = 'azure://snowflakebucket.blob.core.windows.net/parquetdata/titanic.parquet';

CREATE or REPLACE transient table demo_db.public.userdata_parquet_titanic(raw_data variant);

copy into demo_db.public.userdata_parquet_titanic from @demo_db.public.my_azure_parquet_stage_titanic file_format = demo_db.public.my_parquet_stage;

SELECT * FROM userdata_parquet_titanic;

create or replace table demo_db.public.user_parsed_data_titanic as
select
$1:Age Age,
$1:Embarked Embarked,
$1:Fare Fare,
$1:Name Name,
$1:Parch Parch,
$1:PassengerId PassengerId,
$1:Pclass Pclass,
$1:Sex Sex,
$1:SibSp SibSp,
$1:Survived Survived
from demo_db.public.userdata_parquet_titanic;

CREATE OR REPLACE TABLE demo_db.silver.titanic_passengers_clean (
passenger_id INTEGER,
passenger_name STRING,
sex STRING,
age NUMBER(4, 1),
passenger_class INTEGER,
sibsp INTEGER,
parch INTEGER,
fare NUMBER(10, 2),
embarked STRING,
survived BOOLEAN,
load_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP() );

INSERT INTO DEMO_DB.SILVER.TITANIC_PASSENGERS_CLEAN SELECT 
    PASSENGERID::INTEGER AS PASSENGER_ID,
    NAME::STRING AS PASSENGER_NAME,
    SEX::STRING AS SEX,
    AGE::NUMBER(4,1) AS AGE,
    PCLASS::INTEGER AS PASSENGER_CLASS,
    SIBSP::INTEGER AS SIBSP,
    PARCH::INTEGER AS PARCH,
    FARE::NUMBER(10,2) AS FARE,
    EMBARKED::STRING AS EMBARKED,
    SURVIVED::INTEGER = 1 AS SURVIVED,
    CURRENT_TIMESTAMP()
FROM 
    DEMO_DB.PUBLIC.USER_PARSED_DATA_TITANIC
WHERE PASSENGERID IS NOT NULL;

SELECT * FROM DEMO_DB.SILVER.TITANIC_PASSENGERS_CLEAN limit 10;

CREATE OR REPLACE TABLE demo_db.silver.titanic_passengers_dedup AS
SELECT * FROM DEMO_DB.silver.titanic_passengers_clean QUALIFY ROW_NUMBER() OVER (
PARTITION BY passenger_id
ORDER BY load_ts DESC
) = 1;



