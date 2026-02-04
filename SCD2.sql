CREATE OR REPLACE TABLE demo_db.gold.dim_passenger_scd2 (
  passenger_sk        INTEGER AUTOINCREMENT,   -- Surrogate key
  passenger_id        INTEGER,                 -- Business key
  passenger_name      STRING,
  sex                 STRING,
  age                 NUMBER(4,1),
  passenger_class     INTEGER,
  sibsp               INTEGER,
  parch               INTEGER,
  fare                NUMBER(10,2),
  embarked            STRING,
  survived            BOOLEAN,
  effective_start_date DATE,
  effective_end_date   DATE,
  is_current           BOOLEAN,
  record_hash          STRING,
  load_ts              TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);