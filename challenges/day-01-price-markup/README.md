# Day 01: Product Price Markup (`+`)

> **Campaign**: `#30DaysOfSQL`  
> **Topic**: Arithmetic Addition & Dynamic Column Projections  
> **Target Table**: `products`  

---

## 📌 Business Scenario

Due to rising supply chain transport costs, the retail management team has instituted a flat **$4.50 logistics surcharge** across all products in the catalog.

Your task is to produce an audit report displaying each product's base price alongside the adjusted price including the surcharge (`price_with_surcharge`) for the first 10 products, sorted by product ID.

---

## 🎯 Target Output

Your query should return these exact columns and rows:

| product_id | product_name | price | price_with_surcharge |
| :--- | :--- | :--- | :--- |
| 1 | Chais | 18.00 | 22.50 |
| 2 | Chang | 19.00 | 23.50 |
| 3 | Aniseed Syrup | 10.00 | 14.50 |
| ... | ... | ... | ... |

*(10 rows total)*

---

## 💡 Solution & Technical Walkthrough

👉 **[`query.sql`](./query.sql)**
