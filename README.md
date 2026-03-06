# E-Commerce Sales Analysis (SQL)

## Overview

This project performs **basic exploratory data analysis (EDA)** on an e-commerce sales dataset using SQL.
The goal is to understand **sales performance, customer behavior, and product demand** through SQL queries.

## Tools Used

* SQL
* MySQL Workbench
* Kaggle Dataset

## Dataset

The dataset contains transactional data with the following columns:

* InvoiceNo – Order ID
* StockCode – Product code
* Description – Product name
* Quantity – Units sold
* InvoiceDate – Order date and time
* UnitPrice – Price per unit
* CustomerID – Unique customer identifier
* Country – Customer location

## Data Exploration

Key statistics discovered during exploration:

* Total Rows: **32,795**
* Total Orders: **2,399**
* Total Customers: **1,283**
* Total Products: **2,640**
* Countries: **25**

## Data Cleaning

The `InvoiceDate` column contained **multiple date formats**, which caused errors during conversion.

Example formats:

* `01-04-2011 10:00`
* `12/23/2010 9:59`

To handle this, a **SQL VIEW (`sales_clean`)** was created to standardize date and time values without modifying the original table.

## Business Analysis

The project answers several business questions, including:

* Total revenue generated
* Revenue by country
* Best-selling products
* Top products by revenue
* Average order value
* Top customers by spending
* Orders per customer
* Average basket size

## Key Insight

* The dataset contains over **32k transactions**
* A small group of customers contributes significantly to total revenue
* Some products dominate sales volume
* Orders contain **multiple items on average**

## Challenges

* Mixed date formats in `InvoiceDate`
* MySQL safe update mode prevented direct updates

These issues were resolved using **conditional date parsing and SQL views**.

## Author

**Sakshi Dubey**
Final Year Student | Aspiring Data Analyst

Dataset Link : https://www.kaggle.com/code/ludovicocuoghi/uk-e-commerce-dataset-deep-eda
