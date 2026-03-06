/*
==============================================================
E-Commerce Sales Analysis (SQL Project)
==============================================================

Author: Sakshi Dubey
Project Type: SQL Data Analysis
Dataset Source: Kaggle (E-commerce Retail Dataset)

Project Objective:
This project performs exploratory data analysis (EDA) on an
e-commerce transactional dataset using MySQL. The goal is to
understand sales performance, customer behavior, and product
performance using SQL queries.

Steps Performed:
1. Basic dataset exploration
2. Data cleaning and formatting
3. Creating a SQL view for standardized date & time
4. Business analysis queries
5. Customer and revenue insights

Tools Used:
- MySQL
- MySQL Workbench
- SQL

==============================================================
*/

SELECT COUNT(*) AS total_rows FROM sales; -- 93866
SELECT * FROM Sales;

-- Some basic understanding and EDA .
SELECT count(*) AS total_rows FROM Sales; -- 32795
SELECT COUNT(*) AS total_column FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'Sales'; -- 8
-- Dataset Time range
-- Dataset time range
SELECT
    MIN(InvoiceDate) AS start_date,
    MAX(InvoiceDate) AS end_date
FROM sales; -- 01-04-2011 10:00	 to 12/23/2010 9:59

-- UNIQUE DATA
SELECT COUNT(DISTINCT  InvoiceNo ) AS total_orders FROM Sales ;  -- 2399
SELECT COUNT(DISTINCT CustomerID) AS total_customer FROM Sales ;   -- 1283
SELECT COUNT(DISTINCT StockCode) AS  total_product FROM Sales;  -- 2640
SELECT COUNT(DISTINCT Country) AS total_countries FROM Sales; -- 25
SELECT DISTINCT Country FROM Sales;

-- Separating date and time
CREATE VIEW sales_clean AS
SELECT
    *,
    CASE
        WHEN InvoiceDate LIKE '%-%'
            THEN DATE(STR_TO_DATE(InvoiceDate,'%d-%m-%Y %H:%i'))
        WHEN InvoiceDate LIKE '%/%'
            THEN DATE(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'))
    END AS invoice_date_clean,
    CASE
        WHEN InvoiceDate LIKE '%-%'
            THEN TIME(STR_TO_DATE(InvoiceDate,'%d-%m-%Y %H:%i'))
        WHEN InvoiceDate LIKE '%/%'
            THEN TIME(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'))
    END AS invoice_time_clean
FROM sales;

-- Business EDA & Analysis

-- Total revenue
SELECT
    SUM(Quantity * UnitPrice) AS total_revenue
FROM sales;

-- Revenue by country
SELECT Country ,
     SUM(Quantity * UnitPrice) AS total_revenue
     FROM Sales
GROUP BY Country
ORDER BY  total_revenue DESC
LIMIT 10;

-- Top 10 best-selling products
SELECT
    Description, SUM(Quantity) AS total_sold
FROM
    Sales
GROUP BY Description
ORDER BY total_sold DESC
LIMIT 10;

-- Top 10 products by revenue
-- Top products by revenue
SELECT Description,
       SUM(Quantity * UnitPrice) AS revenue
FROM sales
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

-- Average order value -- 464.48096615252865
SELECT AVG(order_total) AS avg_order_value
FROM (
	SELECT InvoiceNo,
		   SUM(Quantity * UnitPrice) AS order_total
    FROM sales
    GROUP BY InvoiceNo
    ) t;

-- Top 5 customers by spending 	--14646	 79328.4199999999
-- 12346	77183.6
-- 18102	45279.409999999996
-- 12415	37842.740000000005
-- 14156	35496.87000000003
SELECT CustomerID,
       SUM(Quantity * UnitPrice) AS total_spent
FROM sales
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 5;

-- Orders per customer --12748	56
-- 14911	38
-- 17850	34
-- 14606	34
-- 15311	31

SELECT CustomerID,
       COUNT(DISTINCT InvoiceNO) AS order_count
FROM Sales
GROUP BY CustomerID
ORDER BY order_count DESC
LIMIT 5;

-- Average basket size (products per order) --20.1084
-- Avg products per order
SELECT AVG(product_count) AS avg_product_per_order
FROM (
	 SELECT InvoiceNo,
			COUNT(StockCode)  AS product_count
	  FROM sales
      GROUP BY InvoiceNo
      ) t;