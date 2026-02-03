use database demo_db;
use schema demo_sc;
-- 1. Basic Inspection: View the first 10 rows
SELECT COUNT(*) FROM demo_db.demo_sc.titanic;

-- 2. Survival Count: How many survived (1) vs Died (0)?
SELECT Survived, COUNT(*) as passenger_count 
FROM titanic 
GROUP BY Survived;

-- 3. The "Women and Children First" Check
-- Calculate survival rate by Gender
SELECT 
    Sex, 
    COUNT(*) as total_people,
    SUM(Survived) as survivors,
    ROUND((SUM(Survived) / COUNT(*)) * 100, 2) as survival_rate_percent
FROM titanic 
GROUP BY Sex;

-- 4. Class Privilege: Did 1st Class passengers survive more?
SELECT 
    Pclass, 
    COUNT(*) as total_passengers,
    SUM(Survived) as survivors,
    ROUND((SUM(Survived) / COUNT(*)) * 100, 2) as survival_rate_percent
FROM titanic 
GROUP BY Pclass 
ORDER BY Pclass;

-- 5. Age Analytics: Average age of Survivors vs Victims
SELECT 
    CASE WHEN Survived = 1 THEN 'Survived' ELSE 'Perished' END as status,
    ROUND(AVG(Age), 1) as avg_age,
    MIN(Age) as youngest,
    MAX(Age) as oldest
FROM titanic 
GROUP BY Survived;

-- 6. Ticket Prices: Who paid the most?
-- Find the top 5 most expensive tickets
SELECT Name, Fare, Pclass 
FROM titanic 
ORDER BY Fare DESC 
LIMIT 5;

-- 7. Family Size Analysis
-- Combine Siblings/Spouse (SibSp) and Parents/Children (Parch) to find family size
SELECT 
    Name, 
    (SibSp + Parch) as family_size 
FROM titanic 
ORDER BY family_size DESC 
LIMIT 10;

-- 8. Embarkation: Where did most people get on?
-- C = Cherbourg, Q = Queenstown, S = Southampton
SELECT Embarked, COUNT(*) as count 
FROM titanic 
GROUP BY Embarked 
ORDER BY count DESC;