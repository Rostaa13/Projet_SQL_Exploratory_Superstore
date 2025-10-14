-- Vérifier les valeurs manquantes
SELECT 
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS missing_customer,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS missing_profit,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS missing_order_date
FROM superstore_sales;

-- supprimer les valeurs manquantes si le cas présent
delete from superstore_sales
where order_id is null
or sales is null
or order_date is null;


-- Détecter les doublons
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM superstore_sales 
GROUP BY Order_ID
HAVING COUNT(*) > 1;

--supprimer les doublons 
DELETE FROM superstore_sales
WHERE Order_ID IN (
    SELECT Order_ID
    FROM superstore_sales
    GROUP BY Order_ID
    HAVING COUNT(*) > 1
);

-- vérifier les ventes ou profits négatifs
SELECT *
FROM superstore_sales
WHERE Sales < 0 OR Profit < 0;

-- supprimer les valeurs negatifs
DELETE FROM superstore_sales
WHERE Sales < 0 OR Profit < 0;

--vérifier les promotions(discounts)
SELECT *
FROM superstore_sales
WHERE Discount < 0 OR Discount > 1;

UPDATE superstore_sales
SET Discount = Discount / 100
WHERE Discount > 1 AND Discount <= 100;

--vérification des dates
SELECT *
FROM superstore_sales
WHERE Ship_Date < Order_Date;

DELETE FROM superstore_sales
WHERE Ship_Date < Order_Date;


DELETE FROM superstore_sales
WHERE Sales IS NULL AND Profit IS NULL AND Customer_ID IS NULL;

-- creation d'une nouvelle table apres le processus de data cleaning
CREATE TABLE sales_clean AS
SELECT *
FROM superstore_sales;

SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    DATA_LENGTH,
    DATA_PRECISION,
    DATA_SCALE,
    NULLABLE
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'SALES_CLEAN'
  AND OWNER = USER
ORDER BY COLUMN_ID;

SELECT 
    COUNT(*) AS total_rows,
    MIN(Order_Date) AS first_order,
    MAX(Order_Date) AS last_order,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_clean;


