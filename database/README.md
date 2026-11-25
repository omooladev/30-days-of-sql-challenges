# Database Setup Scripts

This directory contains the PostgreSQL schema definitions and seed data for the 30 Days of SQL Challenge.

## Files

1. **[`01_schema.sql`](./01_schema.sql)**:
   - Drops existing tables in reverse dependency order (`CASCADE`).
   - Creates all 8 tables (`categories`, `customers`, `employees`, `shippers`, `suppliers`, `products`, `orders`, `order_details`).
   - Sets primary keys, foreign keys, data types (`SERIAL`, `VARCHAR`, `NUMERIC`, `TIMESTAMPTZ`), and `CHECK` constraints.

2. **[`02_seed.sql`](./02_seed.sql)**:
   - Populates 932 sample records in strict foreign-key dependency order inside a single transaction block (`BEGIN; ... COMMIT;`).
   - Synchronizes all auto-increment `SERIAL` sequences (`setval`) to match `MAX(id)`.
   - Runs an audit query to verify row counts across all 8 tables.

## Execution

### In pgAdmin 4:
1. Connect to your database (e.g., `retail_db`).
2. Open the **Query Tool**.
3. Open and execute `01_schema.sql` (press **F5**).
4. Open and execute `02_seed.sql` (press **F5**).

### In SQL Shell (`psql`):
For complete beginner walkthrough on handling `Server [localhost]:` prompts and running files:  
👉 **[psql Terminal Setup & Execution Guide](../docs/psql-terminal-guide.md)**

```text
-- Inside psql:
CREATE DATABASE retail_db;
\c retail_db
\i 'C:/projects/30-days-of-sql-challenges/database/01_schema.sql'
\i 'C:/projects/30-days-of-sql-challenges/database/02_seed.sql'
-- (Replace C:/projects/... with the actual path to your repository)
```

---

## 3. Expected Verification & Sanity Output

Upon executing `02_seed.sql`, the script synchronizes sequences and executes an automated audit query verifying record counts:

```text
  table_name   | row_count | max_id 
---------------+-----------+--------
 categories    |         8 |      8
 customers     |        91 |     91
 employees     |        10 |     10
 order_details |       518 |    518
 orders        |       196 |  10443
 products      |        77 |     77
 shippers      |         3 |      3
 suppliers     |        29 |     29
(8 rows)
```

- **Total records**: 932
- **Integrity**: Primary and foreign key constraints verified.
- **Sequences**: `setval` synchronized so next insertions continue cleanly from `max_id + 1`.
