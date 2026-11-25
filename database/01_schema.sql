-- ============================================================================
-- Database Schema: Retail E-Commerce Database (PostgreSQL)
-- Source: Adapted from W3Schools Northwind Dataset
-- Reference: https://www.w3schools.com/sql/trysql.asp?filename=trysql_customers
--
-- Purpose:
--   Handcrafted PostgreSQL DDL to practice creating tables, defining primary
--   and foreign keys, setting appropriate data types, and adding CHECK constraints.
--
-- Execution Order:
--   1. Drop existing tables in reverse foreign-key dependency order
--   2. Independent Entities: categories, customers, employees, shippers, suppliers
--   3. Dependent Entities:   products, orders
--   4. Junction/Line Items:  order_details
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. Reset / Drop Existing Tables
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS order_details CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS shippers CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- ----------------------------------------------------------------------------
-- Table: Categories (8 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description   TEXT,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_categories_category_name_non_empty
        CHECK (LENGTH(TRIM(category_name)) > 0)
);

-- ----------------------------------------------------------------------------
-- Table: Customers (91 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id   SERIAL PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    contact_name  VARCHAR(150) NOT NULL,
    address       VARCHAR(255) NOT NULL,
    city          VARCHAR(100) NOT NULL,
    postal_code   VARCHAR(20),
    country       VARCHAR(100) NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_customers_customer_name_non_empty
        CHECK (LENGTH(TRIM(customer_name)) BETWEEN 1 AND 150),
    CONSTRAINT chk_customers_contact_name_non_empty
        CHECK (LENGTH(TRIM(contact_name)) BETWEEN 1 AND 150),
    CONSTRAINT chk_customers_address_non_empty
        CHECK (LENGTH(TRIM(address)) BETWEEN 1 AND 255),
    CONSTRAINT chk_customers_city_non_empty
        CHECK (LENGTH(TRIM(city)) BETWEEN 1 AND 100),
    CONSTRAINT chk_customers_postal_code_valid
        CHECK (postal_code IS NULL OR LENGTH(TRIM(postal_code)) BETWEEN 1 AND 20),
    CONSTRAINT chk_customers_country_non_empty
        CHECK (LENGTH(TRIM(country)) BETWEEN 1 AND 100)
);

-- ----------------------------------------------------------------------------
-- Table: Employees (10 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS employees (
    employee_id SERIAL PRIMARY KEY,
    last_name   VARCHAR(100) NOT NULL,
    first_name  VARCHAR(100) NOT NULL,
    birth_date  DATE NOT NULL,
    photo       VARCHAR(100),
    notes       TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_employees_last_name_non_empty
        CHECK (LENGTH(TRIM(last_name)) BETWEEN 1 AND 100),
    CONSTRAINT chk_employees_first_name_non_empty
        CHECK (LENGTH(TRIM(first_name)) BETWEEN 1 AND 100)
);

-- ----------------------------------------------------------------------------
-- Table: Shippers (3 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS shippers (
    shipper_id   SERIAL PRIMARY KEY,
    shipper_name VARCHAR(100) NOT NULL,
    phone        VARCHAR(30),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_shippers_shipper_name_non_empty
        CHECK (LENGTH(TRIM(shipper_name)) > 0)
);

-- ----------------------------------------------------------------------------
-- Table: Suppliers (29 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id   SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_name  VARCHAR(150) NOT NULL,
    address       VARCHAR(255) NOT NULL,
    city          VARCHAR(100) NOT NULL,
    postal_code   VARCHAR(20) NOT NULL,
    country       VARCHAR(100) NOT NULL,
    phone         VARCHAR(32) NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_suppliers_supplier_name_non_empty
        CHECK (LENGTH(TRIM(supplier_name)) > 0),
    CONSTRAINT chk_suppliers_contact_name_non_empty
        CHECK (LENGTH(TRIM(contact_name)) > 0),
    CONSTRAINT chk_suppliers_address_non_empty
        CHECK (LENGTH(TRIM(address)) > 0),
    CONSTRAINT chk_suppliers_city_non_empty
        CHECK (LENGTH(TRIM(city)) > 0),
    CONSTRAINT chk_suppliers_postal_code_non_empty
        CHECK (LENGTH(TRIM(postal_code)) > 0),
    CONSTRAINT chk_suppliers_country_non_empty
        CHECK (LENGTH(TRIM(country)) > 0),
    CONSTRAINT chk_suppliers_phone_non_empty
        CHECK (LENGTH(TRIM(phone)) > 0)
);

-- ----------------------------------------------------------------------------
-- Table: Products (77 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    supplier_id  INTEGER NOT NULL,
    category_id  INTEGER NOT NULL,
    unit         VARCHAR(100) NOT NULL,
    price        NUMERIC(10, 2) NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraints
    CONSTRAINT fk_products_supplier_id
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id),

    CONSTRAINT fk_products_category_id
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    -- Data integrity constraints
    CONSTRAINT chk_products_product_name_non_empty
        CHECK (LENGTH(TRIM(product_name)) > 0),

    CONSTRAINT chk_products_unit_non_empty
        CHECK (LENGTH(TRIM(unit)) > 0),

    CONSTRAINT chk_products_price_non_negative
        CHECK (price >= 0)
);

-- ----------------------------------------------------------------------------
-- Table: Orders (196 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    order_date  DATE NOT NULL,
    shipper_id  INTEGER NOT NULL,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraints
    CONSTRAINT fk_orders_customer_id
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_orders_employee_id
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    CONSTRAINT fk_orders_shipper_id
        FOREIGN KEY (shipper_id)
        REFERENCES shippers(shipper_id)
);

-- ----------------------------------------------------------------------------
-- Table: Order Details (518 records)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    quantity        INTEGER NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraints
    CONSTRAINT fk_order_details_order_id
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_details_product_id
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    -- Data integrity constraints
    CONSTRAINT chk_order_details_quantity_positive
        CHECK (quantity > 0),

    -- Prevent duplicate products in the same order
    CONSTRAINT uq_order_details_order_product
        UNIQUE (order_id, product_id)
);
