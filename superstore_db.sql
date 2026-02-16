-- Task 3: SQL for Data Analysis
-- Dataset: Superstore
-- 1️. Create Database
CREATE DATABASE superstore_db;
USE superstore_db;
-- 2️. Create Main Table
CREATE TABLE superstore (
    ship_mode VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);
-- (After this, import CSV file using Import Wizard)

-- a) SELECT, WHERE, ORDER BY, GROUP BY

-- 1. SELECT: View 10 data
SELECT * FROM superstore LIMIT 10;
-- 2️. WHERE: Show only West region sales
SELECT * FROM superstore
WHERE region = 'West';
-- 3️. ORDER BY: Top 10 highest sales
SELECT * FROM superstore
ORDER BY sales DESC
LIMIT 10;
-- 4️. GROUP BY: Total sales by category
SELECT category, SUM(sales) AS total_sales
FROM superstore
GROUP BY category;

-- b) JOINS (Create another table first)

-- Create region manager table
CREATE TABLE region_manager (
    region VARCHAR(100),
    manager_name VARCHAR(100)
);

-- Insert sample data
INSERT INTO region_manager VALUES
('West', 'Rahul'),
('East', 'Anita'),
('Central', 'Suresh'),
('South', 'Priya');

-- 1️. INNER JOIN: Show region sales with manager name
SELECT s.region, r.manager_name, SUM(s.sales) AS total_sales
FROM superstore s
INNER JOIN region_manager r
ON s.region = r.region
GROUP BY s.region, r.manager_name;

-- 2️. LEFT JOIN: Show all sales records with manager
SELECT s.city, s.region, r.manager_name
FROM superstore s
LEFT JOIN region_manager r
ON s.region = r.region;

-- 3️. RIGHT JOIN 
SELECT s.city, s.region, r.manager_name
FROM superstore s
RIGHT JOIN region_manager r
ON s.region = r.region;

-- c) Subqueries

-- Find states where total sales is greater than average sales
SELECT state
FROM superstore
GROUP BY state
HAVING SUM(sales) >
    (SELECT AVG(sales) FROM superstore);
    
    
-- d) Aggregate Functions

-- 1️. Total Profit
SELECT SUM(profit) AS total_profit
FROM superstore;

-- 2️. Average Discount by Category
SELECT category, AVG(discount) AS avg_discount
FROM superstore
GROUP BY category;

-- 3️. Total Quantity Sold
SELECT SUM(quantity) AS total_quantity
FROM superstore;

-- e) Create View for Analysis

CREATE VIEW category_analysis AS
SELECT category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,
       AVG(discount) AS avg_discount
FROM superstore
GROUP BY category;

-- View data from created view
SELECT * FROM category_analysis;

-- f) Create Indexes for Optimization

-- Create index on region column
CREATE INDEX idx_region
ON superstore(region);

-- Create index on category column
CREATE INDEX idx_category
ON superstore(category);

-- Create index on state column
CREATE INDEX idx_state
ON superstore(state);