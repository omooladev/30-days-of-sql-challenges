-- ============================================================================
-- Day 03: Order Line Item Subtotals
-- Campaign: #30DaysOfSQL
-- Author: Omosuyi Olawole
-- ============================================================================
--
-- Business Scenario:
-- The billing department needs to review a detailed line-item breakdown for Order ID 10248.
--
-- Objective:
-- For each product in that order, produce a report showing the 
-- order ID, product name, unit price, quantity ordered, 
-- and the extended line total (quantity × unit price). 
-- Sort results from the highest line total to the lowest.
--
-- First-Principle Technical Takeaways:
-- 1. How Joins Connect Related Data:
--    Learned how to properly connect two independent but related tables
--    (`order_details` and `products`) using their common relational key (`product_id`).
--
-- 2. `JOIN` Defaults to `INNER JOIN`:
--    Writing the `JOIN` keyword by itself defaults to an `INNER JOIN`.
--    An inner join strictly returns rows that have matching keys in BOTH tables.
--    Meaning: only order detail line items with a `product_id` that actually
--    exists in the `products` table are returned. Unmatched records on either side
--    are excluded.
--
-- 3. Table Aliases Clarify Column Ownership:
--    Assigning short table aliases (`FROM order_details AS od` and
--    `JOIN products AS p`) makes queries clean and eliminates ambiguity,
--    explicitly designating which table owns each column (e.g. `od.product_id` vs `p.product_id`).
--
-- 4. Filtering Down to the Specific Order:
--    `WHERE od.order_id = 10248` discards all other orders immediately,
--    ensuring the report isolates only the line items belonging to Order 10248.
--
-- 5. On-the-Fly Subtotal Calculation & Sorting:
--    - The line item subtotal is computed directly in temporary memory via
--      `od.quantity * p.price AS line_total`, keeping the underlying data safe.
--    - `ORDER BY line_total DESC` sorts the computed subtotals from highest
--      to lowest, which works because sorting executes after `SELECT`.
-- ============================================================================

SELECT 
	od.order_id,
	p.product_name,
	p.price AS unit_price,
	od.quantity,
	od.quantity*p.price AS line_total
FROM order_details AS od
JOIN products AS p ON 
	od.product_id=p.product_id
WHERE od.order_id=10248
ORDER BY line_total DESC;