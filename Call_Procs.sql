USE DATABASE DEMO_DB;

CALL demo_db.silver.sp_load_silver_titanic();
CALL demo_db.gold.sp_load_dim_passenger_scd2();

SELECT * FROM DEMO_DB.GOLD.DIM_PASSENGER_SCD2;