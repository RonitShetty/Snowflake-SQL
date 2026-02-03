USE DATABASE demo_db;
USE SCHEMA demo_sc;

-- Create a temporary table with calculated columns for easier analysis including email domains and days employed
CREATE OR REPLACE TEMPORARY TABLE emp_analysis_temp AS SELECT first_name, last_name, email, city, streetaddress, start_date, SPLIT_PART(email, '@', 2) as email_domain, DATEDIFF('day', start_date, CURRENT_DATE()) as days_employed FROM emp;

-- Group employees by their email domain to see the distribution of email providers
SELECT email_domain, COUNT(*) as domain_count FROM emp_analysis_temp GROUP BY email_domain ORDER BY domain_count DESC;

-- Find all employees hired in the fourth quarter (October, November, December) of any year
SELECT first_name, last_name, start_date FROM emp_analysis_temp WHERE MONTH(start_date) IN (10, 11, 12) ORDER BY start_date;

-- Use conditional logic to label employees as 'Veteran' or 'Newcomer' based on days employed
SELECT first_name, days_employed, CASE WHEN days_employed > 3000 THEN 'Veteran' ELSE 'Newcomer' END as status FROM emp_analysis_temp;

-- Calculate the average employment duration (in days) for each city
SELECT city, AVG(days_employed) as avg_tenure_days FROM emp_analysis_temp GROUP BY city ORDER BY avg_tenure_days DESC;

-- Identify cities that are "hubs" by filtering for those with more than one employee
SELECT city, COUNT(*) as staff_count FROM emp_analysis_temp GROUP BY city HAVING COUNT(*) > 1;

-- Filter specifically for employees living in apartments or suites using wildcard matching
SELECT * FROM emp_analysis_temp WHERE streetaddress LIKE '%Apt%' OR streetaddress LIKE '%Suite%';

-- Find the employee with the longest last name using string length calculation
SELECT first_name, last_name, LENGTH(last_name) as name_length FROM emp_analysis_temp ORDER BY name_length DESC LIMIT 1;

-- Aggregate hiring trends to see how many people joined in each year
SELECT YEAR(start_date) as hire_year, COUNT(*) as total_hires FROM emp_analysis_temp GROUP BY hire_year;

-- Filter for employees living in cities that start with the letters S or M
SELECT * FROM emp_analysis_temp WHERE SUBSTR(city, 1, 1) IN ('S', 'M');