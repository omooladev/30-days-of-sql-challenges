# Easy Guide: Using the `psql` Terminal

> **App**: SQL Shell (`psql`) on Windows  
> **Database Name**: `retail_db`  
> **Project**: `30-days-of-sql-challenges`  

---

## 1. How to Log In

When you open **SQL Shell (`psql`)**, it asks you 5 questions.

You will see answers inside square brackets like `[localhost]`. That is the **default choice**. If you agree, just press **Enter**.

| Prompt | What it asks | What to do |
| :--- | :--- | :--- |
| `Server [localhost]:` | Where is PostgreSQL? | Press **Enter** |
| `Database [postgres]:` | Which database to start with? | Press **Enter** |
| `Port [5432]:` | Which port number? | Press **Enter** |
| `Username [postgres]:` | What is your username? | Press **Enter** |
| `Password for user postgres:` | What is your password? | **Type your password** and press **Enter** |

---

### ⚠️ Why does nothing show when typing your password?

When you type your password, **nothing will appear on the screen**. No letters, no dots, no stars (`****`). The cursor will not move.

**Do not worry—this is completely normal!**

- **Why does it do this?**  
  It keeps your password safe. If someone stands behind you, they cannot read your password or count how many letters it has.
- **Is it working?**  
  **Yes.** The computer is secretly saving every key you press.
- **What should you do?**  
  Just type your password normally and press **Enter**.
- **What if you make a mistake?**  
  Press **Backspace 15 times** to delete everything, then type it again and press **Enter** (or press `Ctrl + C` to restart).

When you log in successfully, your terminal shows:
```text
postgres=#
```
*(The `=#` means you are logged in and ready.)*

---

## 2. Create Your Database

It is best to make a new database for your project instead of using the default one.

### Step 2.1: Make the database
Type this command and press **Enter** (make sure to include the semicolon `;` at the end!):

```sql
CREATE DATABASE retail_db;
```

You will see:
```text
CREATE DATABASE
```

### Step 2.2: Switch into your new database
Type this command and press **Enter**:

```text
\c retail_db
```

You will see:
```text
You are now connected to database "retail_db" as user "postgres".
retail_db=#
```
*(Notice your prompt changed from `postgres=#` to `retail_db=#`)*

---

## 3. Run Your SQL Files (Tables & Data)

In `psql`, the command **`\i`** means: *"read and run a file from my computer"*.

### ⚠️ Two Important Rules for File Paths:
1. **Always use forward slashes (`/`)**:  
   Do not use Windows backslashes (`\`). Backslashes break the path and turn your numbers into strange symbols like hearts (`♥`) and smileys (`☺`).
2. **Put single quotes `'...'` around the path**:  
   This protects folder names that have spaces (for example: `'C:/my projects/...'`).

---

### Step 3.1: Create the 8 Tables (`01_schema.sql`)
Type or paste your path to `01_schema.sql` and press **Enter**:

```text
\i 'C:/projects/30-days-of-sql-challenges/database/01_schema.sql'
```
*(Replace `C:/projects/...` with the actual path to your repository on your computer)*

PostgreSQL will create all 8 tables for you.

---

### Step 3.2: Add the Data (`02_seed.sql`)
Now run the seed file to add the sample rows:

```text
\i 'C:/projects/30-days-of-sql-challenges/database/02_seed.sql'
```

When it finishes, it will print this table to show everything was added successfully:

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

*(Total: 932 rows added across all tables!)*

---

## 4. Check Your Work

Now you can test if your database works:

### See all tables
```text
\dt
```

### Look inside a table's design
```text
\d products
```
---

## 5. Quick Command Cheat Sheet

| To do this... | Type this command |
| :--- | :--- |
| **See all databases** | `\l` |
| **Switch database** | `\c retail_db` |
| **See all tables** | `\dt` |
| **See table details** | `\d products` |
| **Run a file** | `\i 'path/to/file.sql'` |
| **Close / Exit psql** | `\q` |

---

## 💡 Two Golden Rules to Remember

1. **SQL commands need a semicolon (`;`)**  
   Commands like `SELECT`, `CREATE`, and `INSERT` must end with `;`.  
   If you forget it, the prompt shows `-#` and waits for you. Just type `;` and hit Enter.

2. **Slash commands do NOT need a semicolon**  
   Commands starting with `\` (like `\c`, `\dt`, `\i`, `\q`) run as soon as you press Enter. Do not add `;` to them.
