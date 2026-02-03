SELECT 
    MONTHNAME(start_date) as hiring_month, 
    COUNT(*) as hires
FROM "DEMO_DB"."DEMO_SC"."EMP"
WHERE YEAR(start_date) = 2017
GROUP BY hiring_month
ORDER BY hires DESC;



