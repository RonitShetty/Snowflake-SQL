-- 1. Simple Filtering (WHERE)
-- Get all employees who live in 'Miami' or have 'Miami' in their address
SELECT * FROM "DEMO_DB"."DEMO_SC"."EMP"
WHERE city = 'Miami' 
   OR streetaddress LIKE '%Miami%';

-- 2. Sorting Data (ORDER BY)
-- List employees alphabetically by their Last Name
SELECT first_name, last_name, start_date
FROM "DEMO_DB"."DEMO_SC"."EMP"
ORDER BY last_name ASC;

-- 3. Aggregation (GROUP BY)
-- Count how many employees you have in each City
SELECT city, COUNT(*) as employee_count
FROM "DEMO_DB"."DEMO_SC"."EMP"
GROUP BY city
ORDER BY employee_count DESC;

-- 4. Filtering Aggregates (HAVING)
-- Find cities that have MORE than 1 employee (Finding duplicates/hubs)
SELECT city, COUNT(*) as headcount
FROM "DEMO_DB"."DEMO_SC"."EMP"
GROUP BY city
HAVING COUNT(*) > 1;

-- 5. Date Range Filtering
-- Find everyone hired between Jan 1, 2017 and June 1, 2017
SELECT first_name, last_name, start_date
FROM "DEMO_DB"."DEMO_SC"."EMP"
WHERE start_date BETWEEN '2017-01-01' AND '2017-06-01'
ORDER BY start_date;