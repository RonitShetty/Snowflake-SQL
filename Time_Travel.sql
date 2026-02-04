USE DATABASE demo_db_clone;
USE SCHEMA demo_sc;

-- 1. ANCHOR: Capture the current time BEFORE the mistake
SET safe_point = CURRENT_TIMESTAMP();
-- We save the exact time right now so we can travel back to it later.

-- 2. THE MISTAKE: "Accidentally" update all passengers to Survived = 0
UPDATE titanic 
SET Survived = 0;

-- 3. VERIFY THE DAMAGE
SELECT Survived, COUNT(*) 
FROM titanic 
GROUP BY Survived;
-- Result: You will see 891 rows with '0' (Deceased). The data is ruined.

-- 4. TIME TRAVEL: Query the table as it was at our 'safe_point'
SELECT Survived, COUNT(*) 
FROM titanic AT(TIMESTAMP => $safe_point)
GROUP BY Survived;
-- Result: You will see the original split (e.g., 342 Survived, 549 Deceased).

-- 5. THE FIX: Restore the table using the Time Travel data
CREATE OR REPLACE TABLE titanic 
AS
SELECT * FROM titanic AT(TIMESTAMP => $safe_point);
-- We completely overwrite the broken table with the data from the past.

SELECT COUNT(survived) FROM titanic
GROUP BY survived;