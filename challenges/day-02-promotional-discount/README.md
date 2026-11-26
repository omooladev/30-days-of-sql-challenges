# Day 02: Promotional Discount (`-`)

> **Campaign**: `#30DaysOfSQL`  
> **Topic**: Arithmetic Subtraction, Filtering (`WHERE`), & Column Projections  
> **Target Table**: `products`  

---

## 📌 Business Scenario

Marketing is launching a seasonal clearance sale offering an immediate **$3.00 instant discount** on all items that cost more than $20.00.

Generate a pricing report showing each eligible product's ID, name, original price, the savings amount, and the final discounted price. 

Sort results from highest discounted price to lowest.

---

## 🧠 First-Principle Technical Takeaways

When a database runs this query, it does not read it top-to-bottom. Here is what actually happens under the hood:

### 1. The Order of Work (`FROM` ➔ `WHERE` ➔ `SELECT` ➔ `ORDER BY`)
* **Why aliases fail in `WHERE`**: The database runs `WHERE` **before** `SELECT`. If you try to write `WHERE discounted_price > 17.00`, the database throws an error because the name `discounted_price` hasn't been created yet.
* **Why aliases work in `ORDER BY`**: Sorting happens at the very end, **after** `SELECT`. By then, the database knows what `discounted_price` is, so `ORDER BY discounted_price DESC` works perfectly.

### 2. Throw Away Bad Rows Early (Work Smart)
* `WHERE price > 20.00` filters out products first. 
* If a table has 100,000 items, the database throws away the cheap items immediately. It only spends CPU time calculating discounts on items that actually qualify.

### 3. Creating Columns from Thin Air
* `3.00 AS savings_amount` puts the number `3.00` into every single row.
* You do not need a column to exist in the database table to return useful facts in your report.

### 4. Math on the Fly (Zero Risk)
* `price - 3.00 AS discounted_price` calculates the discount in temporary memory.
* The real prices saved in the database table are completely safe and unchanged (no `UPDATE` performed).

### 5. Sorting Stays the Same
* Subtracting the same number ($3.00) from every item doesn't change which item is more expensive. Sorting by `discounted_price DESC` gives the exact same order as sorting by original `price DESC`.

---

## 💡 Solution & Query Code

👉 **[`query.sql`](./query.sql)**
