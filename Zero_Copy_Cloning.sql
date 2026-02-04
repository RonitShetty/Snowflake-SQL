CREATE OR REPLACE DATABASE demo_db_clone CLONE demo_db;
-- Creates an isolated clone of DEMO_DB instantly using zero-copy cloning.

USE DATABASE demo_db_clone;
-- Switches the current session context to the new clone database.

USE SCHEMA demo_sc;
-- Switches the schema context to demo_sc within the clone.

SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();
-- Verifies that the session is now operating within the clone environment.

SELECT COUNT(*) AS count_before_delete FROM emp;
-- Checks the initial row count of the 'emp' table in the clone.

DELETE FROM emp WHERE city = 'Miami';
-- Deletes rows from the clone to simulate a destructive change.

SELECT COUNT(*) AS count_after_delete FROM emp;
-- Verifies the row count has decreased in the clone.

SELECT COUNT(*) AS original_db_count FROM demo_db.demo_sc.emp;
-- Verifies the original database remains unchanged (should match the initial count).
DROP TABLE titanic;
-- Simulates a disaster by dropping the 'titanic' table in the clone.

UNDROP TABLE titanic;
