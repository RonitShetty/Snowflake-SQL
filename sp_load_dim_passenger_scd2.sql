CREATE OR REPLACE PROCEDURE demo_db.gold.sp_load_dim_passenger_scd2()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN

    -- Step 1: Expire changed records
    UPDATE demo_db.gold.dim_passenger_scd2 tgt
    SET
        effective_end_date = CURRENT_DATE() - 1,
        is_current = FALSE
    FROM (
        SELECT
            passenger_id,
            HASH(
                passenger_name,
                sex,
                age,
                passenger_class,
                sibsp,
                parch,
                fare,
                embarked,
                survived
            ) AS new_hash
        FROM silver.titanic_passengers_dedup
    ) src
    WHERE tgt.passenger_id = src.passenger_id
      AND tgt.is_current = TRUE
      AND tgt.record_hash <> src.new_hash;

    -- Step 2: Insert new & changed records
    INSERT INTO demo_db.gold.dim_passenger_scd2 (
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
        effective_start_date,
        effective_end_date,
        is_current,
        record_hash
    )
    SELECT
        s.passenger_id,
        s.passenger_name,
        s.sex,
        s.age,
        s.passenger_class,
        s.sibsp,
        s.parch,
        s.fare,
        s.embarked,
        s.survived,
        CURRENT_DATE(),
        '9999-12-31',
        TRUE,
        HASH(
            s.passenger_name,
            s.sex,
            s.age,
            s.passenger_class,
            s.sibsp,
            s.parch,
            s.fare,
            s.embarked,
            s.survived
        )
    FROM silver.titanic_passengers_dedup s
    LEFT JOIN demo_db.gold.dim_passenger_scd2 t
      ON s.passenger_id = t.passenger_id
     AND t.is_current = TRUE
    WHERE t.passenger_id IS NULL
       OR t.record_hash <> HASH(
            s.passenger_name,
            s.sex,
            s.age,
            s.passenger_class,
            s.sibsp,
            s.parch,
            s.fare,
            s.embarked,
            s.survived
       );

  

	INSERT INTO demo_db.gold.survival_by_class_gender
	SELECT
		passenger_class,
		sex,
		COUNT(*)                                   AS total_passengers,
		SUM(CASE WHEN survived THEN 1 ELSE 0 END) AS survivors,
		ROUND(
			SUM(CASE WHEN survived THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
			2
		) AS survival_rate_pct
	FROM demo_db.silver.titanic_passengers_dedup
	GROUP BY passenger_class, sex;



--Gold Table: Survival by Age Group

	INSERT INTO demo_db.gold.survival_by_age_group
	SELECT
		CASE
			WHEN age < 12 THEN 'Child'
			WHEN age BETWEEN 12 AND 18 THEN 'Teen'
			WHEN age BETWEEN 19 AND 60 THEN 'Adult'
			ELSE 'Senior'
		END AS age_group,
		COUNT(*) AS total_passengers,
		SUM(CASE WHEN survived THEN 1 ELSE 0 END) AS survivors,
		ROUND(
			SUM(CASE WHEN survived THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
			2
		) AS survival_rate_pct
	FROM demo_db.silver.titanic_passengers_dedup
	WHERE age IS NOT NULL
	GROUP BY age_group;



  
END;
$$;
