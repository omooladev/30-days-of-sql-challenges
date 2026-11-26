

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
-- Technical Takeaways:
-- 1. SQL Order of Work (FROM -> WHERE -> SELECT -> ORDER BY):
--    The database runs WHERE before SELECT. That means WHERE cannot use new 
--    names like `discounted_price` (it doesn't know them yet). 
--    ORDER BY runs after SELECT, so it CAN sort by `discounted_price`.
-- 2. Filter First, Do Math Later:
--    `WHERE price > 20.00` drops unqualified items early. The database only 
--    spends time calculating discounts on items that actually get them.
-- 3. Making New Columns from Fixed Numbers:
--    `3.00 AS savings_amount` puts a fixed number into every row. You don't 
--    need a column in the table to display useful facts in your report.
-- 4. Math Without Changing Real Data:
--    `price - 3.00` only changes what shows on the screen. The real price 
--    inside the database stays untouched and safe.
-- ============================================================================ 

SELECT 
	product_id,
	product_name,
	price,
	3.00 as savings_amount,
	price-3.00 AS discounted_price
FROM products
WHERE price>20.00
ORDER BY discounted_price DESC