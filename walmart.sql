-- Creating the table
DROP TABLE if exists walmart;
Create table if not exists walmart (
	invoice_id VARCHAR NOT NULL PRIMARY KEY,
	branch VARCHAR(30) NOT NULL,
	city VARCHAR(30) NOT NULL,
	customer_type VARCHAR(30) NOT NULL,
	gender VARCHAR(30) NOT NULL,
	product_line VARCHAR(30) NOT NULL,
	unit_price float NOT NULL,
	quantity smallint NOT NULL,
	tax float NOT NULL,
	total float NOT NULL,
	date_ DATE NOT NULL,
	time time NOT NULL,
	payment VARCHAR(30) NOT NULL,
	cogs float NOT NULL,
	gross_margin float NOT NULL,
	gross_income float NOT Null,
	rating float NOT NULL
)

-- Checking the data import
-- Generic analysis
--Q1 Number of unique cities in the data set
SELECT COUNT(*)
FROM (
	SELECT DISTINCT city
	FROM walmart
	) t1

-- There are 3 unique cities overall-Yangon, Naypyitaw, Mandalay
-- Q2 No of unique products sold
SELECT COUNT(*)
FROM (
	SELECT DISTINCT product_line
	FROM walmart
	) t1

-- 6 Unique products were sold 
--Q3 Most common payment method
SELECT payment
	,COUNT(*)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC LIMIT 1

-- e wallet is the most common payment method
--Q4 Number of orders where the quantity was more than the average quantity 
SELECT COUNT(*)
FROM (
	SELECT *
	FROM walmart
	WHERE quantity > (
			SELECT AVG(quantity)
			FROM walmart
			)
	) t1

-- 496 orders had more than the average number of quantities ordered.
-- Time Analysis.
-- Genrate new columns to study hourly, daily and monthly data.
-- We want to analyze the sales as those happening in morning, afternoon, evening and night
-- We will first analyze the opening hours using min and max
SELECT MIN(TIME)
FROM walmart

SELECT MAX(TIME)
FROM walmart

-- Hence, store opens from 10 am to 9 pm
-- We will divide the time as morning (10-1), afternoon (1-4) and evening (4-9)
SELECT period
	,COUNT(*)
FROM (
	SELECT TIME
		,CASE 
			WHEN TIME BETWEEN '10:00:00'
					AND '11:59:59'
				THEN 'Morning'
			WHEN TIME BETWEEN '13:00:00'
					AND '15:59:59'
				THEN 'afternoon'
			ELSE 'Evening'
			END AS period
	FROM walmart
	) t1
GROUP BY 1

-- Evening is the busiest hour
-- We will create a new column to use it for further analysis
ALTER TABLE walmart

DROP COLUMN

IF EXISTS period_;
	ALTER TABLE walmart ADD COLUMN period_ VARCHAR(20);

UPDATE walmart
SET period_ = (
		CASE 
			WHEN TIME BETWEEN '10:00:00'
					AND '11:59:59'
				THEN 'Morning'
			WHEN TIME BETWEEN '13:00:00'
					AND '15:59:59'
				THEN 'Afternoon'
			ELSE 'Evening'
			END
		);

SELECT period_
	,count(*)
FROM walmart
GROUP BY 1

-- Hourly of the days
SELECT date_
	,to_char(TIME, 'hh24') AS hour_
FROM walmart

-- Creating a new column for the days
ALTER TABLE walmart ADD COLUMN hour_ VARCHAR(20);

UPDATE walmart
SET hour_ = (to_char(TIME, 'hh24'));

SELECT hour_
FROM walmart

-- Analysis of the days
SELECT date_
	,to_char(date_, 'Day') AS Day_
FROM walmart

-- Creating a new column for the days
ALTER TABLE walmart

DROP COLUMN

IF EXISTS day_;
	ALTER TABLE walmart ADD COLUMN day_ VARCHAR(20);

UPDATE walmart
SET day_ = (to_char(date_, 'Day'));

SELECT day_
FROM walmart

SELECT day_
	,COUNT(*)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC

-- Saturday is the busiest while Monday is the slowest
-- Analysis of months
SELECT date_
	,to_char(date_, 'Month') AS month_
FROM walmart

-- Creating a new column for the months
ALTER TABLE walmart

DROP COLUMN

IF EXISTS month_;
	ALTER TABLE walmart ADD COLUMN month_ VARCHAR(20);

UPDATE walmart
SET month_ = (to_char(date_, 'Month'));

SELECT month_
	,count(*)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC

-- Data set consists of 3 months and they largely have the same number of sales.
-- Average hourly and daily traffic
SELECT AVG(count_)
FROM (
	SELECT date_, hour_
		,COUNT(*) AS count_
	FROM walmart
	GROUP BY 1,2
	order by 1,2
	) t1

-- On Average 1.6 customers buy every hour. But we know that most sales happen in evening. 
-- So lets calculate the average hourly sales in periods
SELECT period_
	,AVG(count_)
FROM (
	SELECT date_,hour_
		,period_
		,COUNT(*) AS count_
	FROM walmart
	GROUP BY 1,2,3
	Order By 1,2,3 
	) t1
GROUP BY 1

-- Average hourly traffic is the lowest for evening even when we have most sales in this time frame. 
-- This is becasue evening has 5 hours of sales, afternoon has 3 while morning has only 2 hours of sale.
-- WHich hour of the day has the most number of ratings.

SELECT hour_
	,count(*)
FROM (
	SELECT rating
		,to_char(TIME, 'hh24') AS hour_
	FROM walmart
	) t1
GROUP BY 1
ORDER BY 2 DESC

-- 7-8 pm has the highest number of reviewers
-- Average rating each hour of the day
SELECT hour_
	,AVG(rating)
FROM (
	SELECT date_,hour_,rating
	FROM walmart
	) t1
GROUP BY 1
ORDER BY 1

-- PRODUCT ANALYSIS and demographics
-- Most profitable product line for member and a non member
SELECT product_line
	,customer_type
FROM (
	SELECT product_line
		,customer_type
		,sum(gross_income) sum_gross_income
		,rank() OVER (
			PARTITION BY product_line ORDER BY sum(gross_income) DESC
			)
	FROM walmart
	GROUP BY 1
		,2
	ORDER BY 1
	) t1
WHERE rank = 1

--customer type normal earns the most gross income for product lines 'Electronic accessories' and 'Fashion and beverages' while its members who dominate gross income for rest of the product_line
-- Most sellable product line
SELECT product_line
	,count(*)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC

-- What is the gender distribution per branch?
SELECT branch
	,gender
	,count(*)
FROM walmart
GROUP BY 1
	,2
ORDER BY 1
	,3 DESC

-- Financial Analysis
-- Revenue over dates
SELECT round(avg(sales))
FROM (
	SELECT date_
		,SUM(total) sales
	FROM walmart
	GROUP BY 1
	ORDER BY 1
	) t3
-- Average daily sale is $3629

--Average Hourly sale
SELECT round(avg(sales))
FROM (
	SELECT date_,hour_
		,SUM(total) sales
	FROM walmart
	GROUP BY 1,2
	ORDER BY 1
	) t3
-- Average hourly sale is $524

-- Calculating average change in sales per day.
WITH cte AS (
		SELECT date_
			,SUM(total) AS sales
			,row_number() OVER (
				ORDER BY date_
				) AS rn
		FROM walmart
		GROUP BY 1
		ORDER BY 1
		)

SELECT avg(per_change)
FROM (
	SELECT t1.date_
		,t1.sales
		,((t1.sales - t2.sales) / t2.sales) * 100 AS per_change
	FROM cte t1
	LEFT JOIN cte t2 ON t1.rn = t2.rn + 1
	) t3

-- On average sales grew by 21% daily
-- Total Profits for each product line
SELECT product_line
	,SUM(gross_income)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC
	-- Gross income is distributed uniformly across product line



