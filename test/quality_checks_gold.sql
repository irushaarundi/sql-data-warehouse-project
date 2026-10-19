/*
====================================================================================
Quality Checks
====================================================================================
Script Purpose:
    This script performs checks to validate the integrity, consistency,
    and accurecy of the Gold Layer. These check ensure:
    - Uniqueness of the surrogate key in dimention tables.
    - Referential integrity between fact and dimention tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Run these checks after data loding Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
=====================================================================================
*/

-- ==================================================================================
-- Checking 'gold.dim_customers'
-- ==================================================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results
SELECT customer_key, COUNT(*) FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ==================================================================================
-- Checking 'gold.dim_products'
-- ==================================================================================
-- Check for Uniqueness of Product Key in gold.dim_product
-- Expectation: No results
SELECT product_key, COUNT(*) FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT *
FROM gold.fact_sales fs
LEFT JOIN gold.dim_customers c
ON c.customer_key = fs.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = fs.product_key
WHER p.product_key IS NULL OR c.customer_key IS NULL
