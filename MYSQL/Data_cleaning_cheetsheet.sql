-- This is file for Data Cleaning queries
-- 1. Identifying and removing Duplicates
-- 2. Identifying and dealing with null values ( replace with 0, replace with average value, removing non-useful data)
-- 3. Standardizing Data (Trim,round,capitalize,Replacing,Split columns) and assigning data type
-- 4. removing unnecessary rows/columns/removing outliers

-- 1. Duplicates
with tab as (SELECT *,row_number()over(PARTITION BY CUSTOMER_ID) AS DUP
FROM Electonics_transactions.customer_dim)
select * from tab 
where dup >1;

create table staging_customer_dim as (SELECT *,row_number()over(PARTITION BY CUSTOMER_ID) AS DUP
FROM Electonics_transactions.customer_dim);

delete from staging_customer_dim 
where dup >1;

-- 2. Null values
-- many times will encounter values not null but one space '', then you need to convert this values into null first
update customer_dim
set gender = coalesce(gender,'F');
-- To Replace Null value with Average values
UPDATE Parks_and_Recreation.employee_salary
JOIN (
    SELECT AVG(salary) AS avg_salary
    FROM Parks_and_Recreation.employee_salary
) AS t
SET Parks_and_Recreation.employee_salary.salary = ROUND(
    COALESCE(Parks_and_Recreation.employee_salary.salary, t.avg_salary), 2
);

-- 3 Standardizing

-- Converting irregular values to Proper value (first letter caps and others small)
-- upper or lower can be separately used to change all text in either format
SELECT *,Concat(Upper(substring(first_name,1,1)),lower(substring(first_name,2))) as New_name FROM Electonics_transactions.customer_dim;

-- Change data type (example: ensure sale_amount is DECIMAL)
ALTER TABLE sales_data
MODIFY sale_amount DECIMAL(10,2);

-- changing date 
select *, str_to_date('column','%Y/%m/%d') from table_1;

-- Spliting columns by number of character
SELECT 
    *,
    SUBSTRING(column_1, 1, 3) AS first_name
FROM your_table;


-- Spliting columns with separater
SELECT 
    *,
    SUBSTRING_INDEX(column_1, ',', 1) AS first_name,
  SUBSTRING_INDEX(column_1, ',', -1) AS second_name
FROM your_table;

-- adding prefix or suffix
UPDATE customers
SET customer_id = CONCAT('CUST-', customer_id, '-2025');

-- Replacing values 
SELECT REPLACE(column_1, '123', 'XYZ') from table_1;
-- OR
update table_1
    set column_1 = 'value'
    where column_1 like 'value%';
-- OR
update table_1
    set column_1 = 'value'
    where column_1 in ('value_1','value_2','value_3');
    
-- Replacing when pattern is given (advance)
SELECT REGEXP_REPLACE(column_1, '[0-9]+', 'XYZ')from table_1;
-- Result: abcXYZdefXYZ

-- 4. removing unnecessary rows/columns/removing outliers
-- for columns
ALTER TABLE sales_data
DROP COLUMN old_note;
-- for rows
DELETE FROM sales_data 
WHERE
    region = 'TestRegion';
-- rename columns
alter table staging_customer_dim
rename column age_group to age_range;
