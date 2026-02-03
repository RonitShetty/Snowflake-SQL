SELECT * FROM "DEMO_DB"."DEMO_SC"."EMP" LIMIT 10;

SELECT COUNT(*) AS total_employees FROM "DEMO_DB"."DEMO_SC"."EMP";

 ---Printing full name----
SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    email,
    city
FROM "DEMO_DB"."DEMO_SC"."EMP"
ORDER BY last_name ASC;

