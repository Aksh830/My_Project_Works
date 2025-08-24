-- verified data with original data base
-- imported 149116 rows
SELECT * FROM Coffee_Shop.coffee_shop_staging;
-- renamed table 
RENAME TABLE `coffee shop sales` TO coffee_shop_sales;

--  Checking for duplicates (None found)
with dup_row as(SELECT *, row_number() over(partition by transaction_id, transaction_date, transaction_time, transaction_qty, store_id, store_location, product_id, unit_price, product_category, product_type, product_detail) as dup_num from coffee_shop_sales)
select * from dup_row
where dup_num >1;

-- checking for null values ( None found)
select * from Coffee_Shop.coffee_shop_sales
where (transaction_id or transaction_date or transaction_time or transaction_qty or store_id or store_location or product_id or unit_price or product_category or product_type or product_detail) = null or '';

-- checking for inconsistencies
-- product categories ( 9 distinct products)
SELECT distinct product_category FROM Coffee_Shop.coffee_shop_sales;
-- store_id ( 3 found)
SELECT distinct store_id FROM Coffee_Shop.coffee_shop_sales;

-- changing into sql recognized date format
 update Coffee_Shop.coffee_shop_sales
 set transaction_date = str_to_date(transaction_date,'%d/%m/%Y');
 
 -- starting and ending date (01/01/2023 to 30/06/2023)
SELECT Max(transaction_date), Min(transaction_date) FROM Coffee_Shop.coffee_shop_sales;
 
 -- creating staging table
 create table coffee_shop_staging as (SELECT * FROM Coffee_Shop.coffee_shop_sales);
 
 -- rounding off exact time to nearest hour to help analyse trends by time
 update Coffee_Shop.coffee_shop_staging
 set transaction_time = substring(transaction_time,1,2);
 
 -- changing formats
alter table Coffee_Shop.coffee_shop_staging
modify transaction_date date;
-- changing into hrs time
alter table Coffee_Shop.coffee_shop_staging
modify transaction_time int;

-- relation between store_id and store_location & data normalization
create table store_info as (SELECT round(avg(store_id),0)as`store_id`,store_location FROM Coffee_Shop.coffee_shop_staging
group by store_location);

-- now we can drop store_location
alter table Coffee_Shop.coffee_shop_staging
drop column store_location;

-- Tried to normalise coffee products but have multiple prices for same product_id items;
SELECT * FROM Coffee_Shop.coffee_shop_staging_2;

alter table Coffee_Shop.coffee_shop_staging_2
drop column store_id;

create table Coffee_products as (
with dup_row as(SELECT *, row_number() over(partition by product_id, unit_price, product_category, product_type, product_detail) as dup_num from Coffee_Shop.coffee_shop_staging_2)
select * from dup_row);

drop table Coffee_Shop.coffee_shop_staging_2;

-- created view for daily, monthly and total revenue
create view total_sales as (
SELECT round(sum(transaction_qty*unit_price),2)as total_sales FROM Coffee_Shop.coffee_shop_staging);

create view monthly_sales as ( SELECT substring(transaction_date,6,2) as months,
	round(sum(transaction_qty*unit_price),2)as monthly_sale_val FROM Coffee_Shop.coffee_shop_staging group by months);

create view daily_sales as ( SELECT transaction_date,
	round(sum(transaction_qty*unit_price),2)as daily_sale_val FROM Coffee_Shop.coffee_shop_staging group by transaction_date);
    
-- Sales by time of day
create view hourly_trend as ( SELECT transaction_time,
	round(sum(transaction_qty*unit_price),2)as hourly_sale_val FROM Coffee_Shop.coffee_shop_staging group by transaction_time);
    
-- Sales by Store
create view store_sales as ( SELECT store_id,
	round(sum(transaction_qty*unit_price),2)as sales_by_store FROM Coffee_Shop.coffee_shop_staging group by store_id);
    
-- Sales by products
create view Product_sales as ( SELECT product_id, product_category,product_type, product_detail,
	round(sum(transaction_qty*unit_price),2)as sales_by_product FROM Coffee_Shop.coffee_shop_staging group by product_id,product_detail,product_type,product_category);
    
-- Average order values, minimum order value and maximum order value
create view Ind_order_values as (
SELECT round(avg(transaction_qty * unit_price),2) as avg_order_val,round(max(transaction_qty * unit_price),2) as max_order_val,round(min(transaction_qty * unit_price),2) as min_order_val FROM Coffee_Shop.coffee_shop_staging);
    
    