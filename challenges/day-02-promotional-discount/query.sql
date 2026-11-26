-- ============================================================================
-- Day 02: Promotional Discount (-)
-- Campaign: #30DaysOfSQL
-- Author: Omosuyi Olawole
-- ============================================================================
--
-- Business Scenario:
-- Marketing is launching a seasonal clearance sale offering an immediate 
-- $3.00 instant discount on all items that cost more than $20.00.
--
-- Objective:
-- Generate a pricing report showing each eligible product's ID, name, original price, 
-- the savings amount, and the final discounted price. 
-- Sort results from highest discounted price to lowest.
--
-- First-Principle Technical Takeaways:
-- 1. SQL Order of Work (FROM -> WHERE -> SELECT -> ORDER BY):
--    The database does not read code top-to-bottom like a human.
--    - Why aliases fail in WHERE: The database runs WHERE before SELECT.
--      If you write `WHERE discounted_price > 17.00`, it fails because the
--      name `discounted_price` does not exist yet.
--    - Why aliases work in ORDER BY: Sorting runs at the very end, after
--      SELECT. By then, the database knows what `discounted_price` is.
--
-- 2. Throw Away Bad Rows Early (Work Smart):
--    `WHERE price > 20.00` drops cheap items immediately.
--    The database does not waste time calculating discounts on items that
--    do not qualify.
--
-- 3. Creating Columns from Thin Air (Literal Values):
--    `3.00 AS savings_amount` puts the fixed number 3.00 into every row.
--    You do not need a column to exist in the table to return useful facts.
--
-- 4. Math on the Fly (Zero Risk to Real Data):
--    `price - 3.00` only calculates in temporary memory for this report.
--    The real catalog prices in the database stay safe and untouched.
--
-- 5. Equal Math Keeps the Same Order:
--    Taking $3.00 off all qualifying items does not change which item is
--    more expensive. Sorting by `discounted_price DESC` gives the exact same
--    row order as sorting by original `price DESC`.
-- ============================================================================

SELECT 
	product_id,
	product_name,
	price,
	3.00 as savings_amount,
	price-3.00 AS discounted_price
FROM products
WHERE price>20.00
ORDER BY discounted_price DESC;
