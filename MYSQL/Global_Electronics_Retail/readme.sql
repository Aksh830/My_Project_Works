#                This is a Data Cleaning Project
-- 1. Data Cleaning Exchange_rates table
SELECT * FROM Global_electronics_retail.exchange_rates;

-- Bringing Date into SQL recognised format
SELECT *, str_to_date(`Date`,'%m/%d/%Y') as new_date 
FROM Global_electronics_retail.exchange_rates;

UPDATE Global_electronics_retail.exchange_rates 
SET `Date` = str_to_date(`Date`,'%m/%d/%Y');

ALTER TABLE Global_electronics_retail.exchange_rates 
MODIFY `Date` DATE;

-- Checking for duplicates (None Found)
SELECT `Date`, `Exchange`, COUNT(*) dup_col 
FROM Global_electronics_retail.exchange_rates
GROUP BY `Date`, `Exchange` 
HAVING dup_col > 1;

-- Checking for null values (None Found)
SELECT * FROM Global_electronics_retail.exchange_rates 
WHERE `Date` IS NULL OR `Date` = '';

SELECT * FROM Global_electronics_retail.exchange_rates 
WHERE `Currency` IS NULL OR `Currency` = '';

SELECT * FROM Global_electronics_retail.exchange_rates
WHERE `Exchange` IS NULL OR `Exchange` = '';

-- 2. Data Cleaning Customers table
SELECT * FROM Global_electronics_retail.customers
ORDER BY CustomerKey;

-- Checking for duplicate values (CustomerKey is Primary Key, No Duplicates)
SELECT CustomerKey, COUNT(*) as dup_cus 
FROM Global_electronics_retail.customers
GROUP BY CustomerKey
HAVING dup_cus > 1;

-- Bringing Birthday into SQL recognised format 
UPDATE Global_electronics_retail.customers
SET Birthday = STR_TO_DATE(Birthday,'%m/%d/%Y');

-- Assigning data type
ALTER TABLE Global_electronics_retail.customers
MODIFY Birthday DATE;

-- 3. Data Cleaning Sales table
SELECT * FROM Global_electronics_retail.sales;

-- Bringing Date into SQL recognised format
UPDATE Global_electronics_retail.sales
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

-- Updating '' values to null to help change delivery dates into date format 
UPDATE Global_electronics_retail.sales
SET `Delivery Date` = NULL
WHERE `Delivery Date` = '';

UPDATE Global_electronics_retail.sales
SET `Delivery Date` = STR_TO_DATE(`Delivery Date`, '%m/%d/%Y');

-- Checking for duplicate values (8 duplicate values found/deleted)
SELECT `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code`, COUNT(*) AS dup_ord 
FROM Global_electronics_retail.sales
GROUP BY `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code`;

-- Created a CTE to ensure that duplicates exist
WITH duplicates AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code` ) AS rn
    FROM Global_electronics_retail.sales
)
SELECT * FROM duplicates
WHERE rn > 1;

-- Created duplicate table to keep original data and have deletable table 
CREATE TABLE sales_staging AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code` ) AS rn
    FROM Global_electronics_retail.sales
);

SELECT * FROM Global_electronics_retail.sales_staging;

-- Deleting duplicates from newly created table
DELETE FROM Global_electronics_retail.sales_staging
WHERE rn > 1;

-- Dropped extra column
ALTER TABLE Global_electronics_retail.sales_staging
DROP COLUMN rn;

-- 4. Data Cleaning Stores table
SELECT * FROM Global_electronics_retail.stores;

-- Removing extra row with all null values
DELETE FROM Global_electronics_retail.stores
WHERE StoreKey IS NULL;

-- Checking for duplicates (None Found)
SELECT StoreKey, COUNT(*) AS dup
FROM Global_electronics_retail.stores
GROUP BY StoreKey
HAVING dup > 1;

-- 5. Data Cleaning Products table
SELECT * FROM Global_electronics_retail.products;

-- Checking for duplicates (None Found)
SELECT ProductKey, COUNT(*) AS dup 
FROM Global_electronics_retail.products
GROUP BY ProductKey
HAVING dup > 1;

-- Checking for null values (None Found)
SELECT * FROM Global_electronics_retail.products
WHERE ProductKey IS NULL OR ProductKey = '';
