# Walmart Sales Data Analysis Project

This project involves analyzing Walmart sales data using SQL to extract meaningful insights about sales trends, customer behavior, and product performance. The dataset contains information about transactions made at different Walmart branches.

## Project Goals

The main goals of this project are to:

* Analyze sales data to identify trends and patterns.
* Understand customer behavior and preferences.
* Evaluate product performance and profitability.
* Gain insights into revenue and profit trends.

## Dataset Schema

The dataset consists of the following columns:

* **invoice_id:** Unique identifier for each transaction.
* **branch:** Branch location where the transaction occurred.
* **city:** City where the branch is located.
* **customer_type:** Type of customer (Member or Normal).
* **gender:** Gender of the customer.
* **product_line:** Category of the product sold.
* **unit_price:** Price of a single unit of the product.
* **quantity:** Number of units sold.
* **tax:** Tax amount   
 on the transaction.
* **total:** Total amount of the transaction.
* **date_:** Date of the transaction.
* **time:** Time of the transaction.
* **payment:** Payment method used.
* **cogs:** Cost of goods sold.
* **gross_margin:** Gross margin on the transaction.
* **gross_income:** Gross income from the transaction.
* **rating:** Customer rating.

## SQL Queries

The project includes a series of SQL queries that address various aspects of the data. These queries are organized into the following categories:

### Generic Analysis

* **Query 1:** Counts the number of unique cities in the dataset.
* **Query 2:** Counts the number of unique products sold.
* **Query 3:** Identifies the most common payment method.
* **Query 4:** Counts the number of orders with quantity greater than the average.

### Time Analysis

* **Query 5:** Determines the opening hours of the store.
* **Query 6:** Analyzes sales by time periods (Morning, Afternoon, Evening).
* **Query 7:** Analyzes hourly sales.
* **Query 8:** Analyzes daily sales.
* **Query 9:** Analyzes monthly sales.
* **Query 10:** Calculates average hourly and daily traffic.
* **Query 11:** Identifies the hour with the most customer ratings.
* **Query 12:** Calculates the average rating for each hour of the day.

### Product and Demographic Analysis

* **Query 13:** Identifies the most profitable product line for members and non-members.
* **Query 14:** Identifies the most sellable product line.
* **Query 15:** Analyzes gender distribution per branch.

### Financial Analysis

* **Query 16:** Calculates the average daily revenue.
* **Query 17:** Calculates the average hourly revenue.
* **Query 18:** Calculates the average daily change in sales.
* **Query 19:** Calculates the total profit for each product line.

## Key Findings

Some of the key findings from the analysis include:

* There are 3 unique cities in the dataset.
* 6 unique products were sold.
* E-wallet is the most common payment method.
* 496 orders had a quantity greater than the average.
* The store is open from 10 AM to 9 PM.
* Evening is the busiest period.
* Saturday is the busiest day, while Monday is the slowest.
* The dataset covers 3 months with similar sales figures.
* The average hourly traffic is 1.6 customers.
* 7-8 PM has the highest number of customer ratings.

## Conclusion

This project demonstrates the use of SQL to analyze Walmart sales data and extract valuable insights. The findings can be used to make informed decisions about inventory management, marketing strategies, customer segmentation, and sales optimization.
   
