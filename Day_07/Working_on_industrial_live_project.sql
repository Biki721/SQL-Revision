-- 1. Create a database named "ecommerce_sales_data"

CREATE DATABASE IF NOT EXISTS ecommerce_sales_data;
SHOW DATABASES;
 
 -- Command to generate SQL File: csvsql --dialect mysql --snifflimit 10000 Sales_Dataset.csv > Result.sql
 
 
CREATE TABLE `Sales_Dataset` (
	order_id VARCHAR(15) NOT NULL, 
	order_date DATE NOT NULL, 
	ship_date DATE NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);
USE ecommerce_sales_data;

SHOW TABLES;
DESC sales_dataset;
-- 3. Load the data available in Sales_Dataset.csv file to the Sales_Dataset table
-- Famous error: MySQL is running at secure-file-private error
-- secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads"

LOAD DATA INFILE 'C:\Sales_Dataset.csv'
INTO TABLE Sales_Dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Identify the top 3 states with the highest shipping costs
-- state	highest_sum_shipping_cost
SELECT state, SUM(shipping_cost) AS sum_shipping_cost
FROM Sales_Dataset
GROUP BY state
ORDER BY sum_shipping_cost DESC
LIMIT 3;


-- Common Table Expressions - Complexity of any given query + Resuability of the query
WITH states as (
	SELECT state, SUM(shipping_cost) AS sum_shipping_cost
	FROM Sales_Dataset
	GROUP BY state
	ORDER BY sum_shipping_cost DESC
	LIMIT 3
)SELECT * FROM states;

-- Usually, whenver you feel a lot of subqueries or joins are there in your sql queries, go for CTE

-- Find the total sales for each year
-- year		total_sales
select year, sum(sales) as total_sales
from sales_dataset
group by year;

SHOW VARIABLES LIKE "secure_file_priv";

SELECT * FROM Sales_dataset;

-- 1. List the top 5 products by sales amount.

SELECT product_name, SUM(sales) AS Totalsales
FROM Sales_dataset
GROUP BY product_name
ORDER BY Totalsales DESC
LIMIT 5;	

-- 2. Calculate the average profit margin per category.

SELECT category, (SUM(profit)/SUM(sales)) AS avgProfitMargin
FROM Sales_dataset
GROUP BY category;


SELECT category, AVG(profit_margin) AS average_profit_margin
FROM (
    SELECT category, (SUM(profit) / SUM(sales)) AS profit_margin
    FROM Sales_dataset
    GROUP BY category
) AS category_margins
GROUP BY category;

-- 3. Find the number of orders placed per segment for the year 2012.

SELECT segment, COUNT(*) AS OrderNumbers
FROM Sales_dataset
WHERE YEAR(order_date)= 2012
GROUP BY segment;

-- Identify the top 3 states with the highest shipping costs
SELECT * FROM sales_dataset;

SELECT state, shipping_cost
FROM sales_dataset
ORDER BY shipping_cost DESC
LIMIT 3;

-- 5. Calculate the total sales and profit for each market in the year 2012.

SELECT market, SUM(sales) AS totalSales, SUM(profit) AS totalProfit
FROM sales_dataset
WHERE YEAR(order_date)=2012
GROUP BY market;


-- 6. Determine the percentage of orders that had a discount applied.

SELECT (COUNT(CASE WHEN discount > 0 THEN 1 END)*100)/COUNT(*) AS percentage_discounted
FROM sales_dataset;

-- 7. Find the average shipping cost per order priority

SELECT order_priority, AVG(shipping_cost) AS avgShippingCost
FROM sales_dataset
GROUP BY order_priority;

-- 8. List the products with a profit margin greater than 20%.

SELECT product_name, (SUM(profit)/SUM(sales))*100 AS profitMarginPercent
FROM sales_dataset
GROUP BY product_name
HAVING profitMarginPercent > 20;


-- 9. Calculate the total quantity sold for each sub-category.

SELECT sub_category, SUM(quantity) AS totalQuantity
FROM sales_dataset
GROUP BY sub_category;


-- 10. Calculate the total sales and profit for each year, using a CTE.
WITH temp AS (
	SELECT 'year', SUM(sales) AS totalSales, SUM(profit) AS totalProfit
	FROM sales_dataset
	GROUP BY 'year'
) SELECT * FROM temp;
    
-- List the products with a profit margin greater than 20%, using a CTE

WITH CTE AS(
	SELECT product_name, (SUM(profit)/SUM(sales))*100 AS profitMargin 
	FROM sales_dataset
	GROUP BY product_name
	HAVING profitMargin > 20
) SELECT * FROM CTE;
    
    
    
    
    