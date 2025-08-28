
/*
=================================================================
Quality Checks
=================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency,
    and accuracy of the Gold layer. The checks ensures:
    - Uniqueness of surrogate keys in dimension table.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Run these checks after loading Silver layer.
    - Investigate and resolve any discrepancies found during the checks.
=================================================================
*/

-- ==============================================================
--Checking 'gold.dim_customers'
-- ===============================================================
-- Check for uniqueness of customer key in gold.dim_customers
--Expectation: No results
SELECT 
	customer_key
	COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ===============================================================
-- Checking 'gold.dim_products'
-- ===============================================================
--Checking the uniqueness of products key in gold.dim_products
-- Expectation: Np results
SELECT
	product_key,
	COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- Foreign key integrity (Dimensions)
-- ===============================================================
-- Checking 'gold.fact_sales'
-- ===============================================================
-- Check the data model connectivity between fact and dimensions

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE c.customer_key IS NULL OR c.customer_key IS NULL
