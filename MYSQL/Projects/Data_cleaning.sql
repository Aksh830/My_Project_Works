-- 1. Data Cleaning Exchange_rates table
select * from Global_electronics_retail.exchange_rates;

-- Bringing Date into SQL recognised format
SELECT *, str_to_date(`Date`,'%m/%d/%Y') as new_date FROM Global_electronics_retail.exchange_rates;
update Global_electronics_retail.exchange_rates set `date` = str_to_date(`Date`,'%m/%d/%Y');

alter table Global_electronics_retail.exchange_rates modify `Date` date;

-- checking for duplicates (None Found)
SELECT `date`,`Exchange`,count(*) dup_col FROM Global_electronics_retail.exchange_rates
group by `date`, `Exchange` 
having dup_col >1;

-- checking for null values (None Found)
SELECT * FROM Global_electronics_retail.exchange_rates 
where date = null or '';

SELECT * FROM Global_electronics_retail.exchange_rates 
where currency = null or '';

SELECT * FROM Global_electronics_retail.exchange_rates
where `Exchange` = null or '';

-- 2. Data Cleaning Customers table
SELECT * FROM Global_electronics_retail.customers
order by CustomerKey;

-- Checking for Duplicate Values (CustomerKey is Primary Key, No Duplicates)
SELECT CustomerKey,count(*) as dup_cus FROM Global_electronics_retail.customers
group by CustomerKey
having dup_cus > 1;

-- Bringing Birthday into SQL recognised format 
update Global_electronics_retail.customers
set Birthday = str_to_date(Birthday,'%m/%d/%Y');

-- assigning data type
alter table Global_electronics_retail.customers
modify Birthday date;

-- 3. Data cleaning sales Table
SELECT * FROM Global_electronics_retail.sales;

-- Bringing Date into SQL recognised format
update Global_electronics_retail.sales
set `order date` = str_to_date(`order date`,'%m/%d/%Y');

-- Updating '' values to null to help change delivery dates into date format 
update Global_electronics_retail.sales
set `Delivery Date` = null
where `Delivery Date` = '';

update Global_electronics_retail.sales
set `Delivery Date` = str_to_date(`Delivery Date`,'%m/%d/%Y');

-- checking for duplicate values (8 duplicate values found/deleted)
SELECT `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code`, count(*) as dup_ord FROM Global_electronics_retail.sales
group by `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code`;
-- created a CTE to ensure that duplicates exist
WITH duplicates AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code` ) AS rn
    FROM Global_electronics_retail.sales
)
 select * from duplicates
 WHERE rn > 1;
 
-- created duplicate table to keep original data and have deletable table 
 create table sales_staging
 as (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY `Order Number`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity, `Currency Code` ) AS rn
    FROM Global_electronics_retail.sales
);
SELECT * FROM Global_electronics_retail.sales_staging;

-- deleting duplicates newly created table
delete from Global_electronics_retail.sales_staging
where rn >1;

-- dropped extra column
alter table Global_electronics_retail.sales_staging
drop column rn;

-- 4. data cleaning Stores table

SELECT * FROM Global_electronics_retail.stores;
-- removing extra row with all null values
delete FROM Global_electronics_retail.stores
where StoreKey = null;
-- Checking for duplicated (None Found)
select storeKey, count(*) as dup
from Global_electronics_retail.stores
group by storeKey
having dup >1;


-- 5. Data Cleaning Products table
SELECT * FROM Global_electronics_retail.products;
-- Checking for duplicates (None Found)
SELECT ProductKey,count(*) as dup FROM Global_electronics_retail.products
group by ProductKey
having dup >1;
-- checking for null values (None Found)
SELECT * FROM Global_electronics_retail.products
where ProductKey = '' or null;

