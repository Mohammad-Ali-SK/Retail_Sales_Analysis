ALTER TABLE retail_sales
RENAME COLUMN "ï»¿transactions_id" TO transaction_id;

select * from retail_sales;

--Data Cleaning

SELECT * FROM retail_sales
WHERE
	"transaction_id" IS NULL
	OR
	"sale_date" IS NULL
	OR
	"sale_time" IS NULL
	OR
	"customer_id" IS NULL
	OR
	"gender" IS NULL
	OR
	"category" IS NULL
	OR
	"quantiy" IS NULL
	OR
	"price_per_unit" IS NULL
	OR
	"cogs" IS NULL
	OR
	"total_sale" IS NULL

--
DELETE FROM retail_sales
WHERE
	"transaction_id" IS NULL
	OR
	"sale_date" IS NULL
	OR
	"sale_time" IS NULL
	OR
	"customer_id" IS NULL
	OR
	"gender" IS NULL
	OR
	"category" IS NULL
	OR
	"quantiy" IS NULL
	OR
	"price_per_unit" IS NULL
	OR
	"cogs" IS NULL
	OR
	"total_sale" IS NULL



-- Data Exploration

-- How many sales we have ?

SELECT COUNT(*) FROM retail_sales;


-- How many customer we have ?

SELECT
	COUNT( DISTINCT "customer_id") AS Total_Customer
	FROM retail_sales;

-- How many category we have ?

SELECT
	COUNT(DISTINCT "category") AS Total_Category
	FROM retail_sales;

-- Data Analysis or Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
WHERE
	"sale_date" = '05-11-2022'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 
-- more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE
	"category" = 'Clothing'
	AND
	"quantiy" >= 4
	AND
	"sale_date" BETWEEN '01-11-2022' AND '30-11-2022'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT "category" AS category,
		SUM("total_sale") AS Total_Sale
FROM retail_sales
GROUP BY
	category
ORDER BY Total_Sale DESC;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG("age")) AS avg_age_beautyCategory FROM retail_sales
WHERE "category" = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE
	"total_sale" >= 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT "category" AS Category,
		"gender" AS Gender,
		COUNT(*) AS No_of_transaction
FROM retail_sales
GROUP BY
	Category,Gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

-- SELECT 
--   EXTRACT(MONTH FROM TO_DATE(sale_date, 'DD-MMM-YYYY')) AS sale_month,
--   ROUND(AVG(total_sale)) AS avg_monthly_sale
-- FROM 
--   retail_sales
-- GROUP BY 
--   sale_month
-- ORDER BY 
--   sale_month;

SELECT 
  TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'Month') AS month_name,
  ROUND(AVG(total_sale)) AS avg_sale
FROM 
  retail_sales
GROUP BY 
  TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'Month'),
  EXTRACT(MONTH FROM TO_DATE(sale_date, 'DD-MM-YYYY'))
ORDER BY 
  EXTRACT(MONTH FROM TO_DATE(sale_date, 'DD-MM-YYYY'));
---
WITH monthly_sales AS (
  SELECT 
    EXTRACT(YEAR FROM TO_DATE(sale_date, 'DD-MM-YYYY')) AS year,
    TO_CHAR(TO_DATE(sale_date, 'DD-MM-YYYY'), 'Month') AS month_name,
    EXTRACT(MONTH FROM TO_DATE(sale_date, 'DD-MM-YYYY')) AS month_num,
    SUM(total_sale) AS total_sales
  FROM 
    retail_sales
  GROUP BY 
    year, month_name, month_num
)
SELECT DISTINCT ON (year)
  year,
  month_name,
  ROUND(total_sales) AS total_sales
FROM 
  monthly_sales
ORDER BY 
  year,
  total_sales DESC;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT "customer_id" AS Customer,SUM("total_sale") AS Total_Sale FROM retail_sales
GROUP BY
	Customer
ORDER BY
	Total_Sale DESC LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	"category" AS Category,
	COUNT(DISTINCT "customer_id") AS NO_OF_Customer
FROM retail_sales
GROUP BY
	Category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
---
SELECT time_of_day, COUNT(*) AS number_of_orders FROM
(SELECT 
  sale_time,
  CASE 
    WHEN EXTRACT(HOUR FROM "sale_time"::TIME) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM "sale_time"::TIME) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM 
  retail_sales) AS shifts
 GROUP BY
 	time_of_day

-- End of Project

















































































































































	












	
	