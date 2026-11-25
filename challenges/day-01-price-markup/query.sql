-- ============================================================================
-- Day 01: Product Price Markup (+)
-- Campaign: #30DaysOfSQL
-- Author: Omosuyi Olawole
-- ============================================================================
--
-- Business Scenario:
-- Due to rising supply chain transport costs, the retail management team has 
-- instituted a flat $4.50 logistics surcharge across all products in the catalog.
--
-- Objective:
-- Generate an audit report displaying each product's base price alongside 
-- the adjusted price including surcharge (price_with_surcharge) for the first 
-- 10 products, ordered by product ID.
--
-- Technical Takeaways:
-- 1. Dynamic Projection vs Mutation: Arithmetic operators (+) evaluate expressions 
--    dynamically in memory per row. Zero base table modification needed (no UPDATE).
-- 2. Explicit Column Aliasing: Using `AS price_with_surcharge` ensures predictable,
--    strongly-typed column keys for downstream API consumers and reporting services.
-- ============================================================================

SELECT 
    product_id,
    product_name,
    price,
    price + 4.50 AS price_with_surcharge
FROM products
ORDER BY product_id ASC
LIMIT 10;
