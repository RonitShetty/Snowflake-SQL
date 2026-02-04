CREATE OR REPLACE PROCEDURE demo_db.silver.sp_load_silver_titanic()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN

    -- Step 1: Load cleaned data
    INSERT INTO demo_db.silver.titanic_passengers_clean (
        passenger_id,
        passenger_name,
        sex,
        age,
        passenger_class,
        sibsp,
        parch,
        fare,
        embarked,
        survived,
        load_ts
    )
    SELECT
        PASSENGERID::INTEGER,
        NAME::STRING,
        SEX::STRING,
        AGE::NUMBER(4,1),
        PCLASS::INTEGER,
        SIBSP::INTEGER,
        PARCH::INTEGER,
        FARE::NUMBER(10,2),
        EMBARKED::STRING,
        SURVIVED::INTEGER = 1,
        CURRENT_TIMESTAMP()
    FROM demo_db.public.user_parsed_data_titanic
    WHERE PASSENGERID IS NOT NULL;

    -- Step 2: Deduplicate
    CREATE OR REPLACE TABLE demo_db.silver.titanic_passengers_dedup AS
    SELECT *
    FROM demo_db.silver.titanic_passengers_clean
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY passenger_id
        ORDER BY load_ts DESC
    ) = 1;

    RETURN 'Silver layer loaded successfully';

END;
$$;
