-- Task 9: Star Schema Data Modeling
-- Created by: Mira
-- Database: Oracle SQL
-- Description: Built fact and dimension tables for sales analysis

/* ================================
   TASK 9 : STAR SCHEMA SQL
   ================================ */

/* ---------- 1. RAW SALES TABLE ---------- */
CREATE TABLE raw_sales (
    order_id NUMBER,
    order_date DATE,
    customer_name VARCHAR2(100),
    segment VARCHAR2(50),
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    sub_category VARCHAR2(50),
    region VARCHAR2(50),
    country VARCHAR2(50),
    sales NUMBER,
    quantity NUMBER,
    profit NUMBER
);

/* ---------- 2. DIMENSION TABLES ---------- */

CREATE TABLE dim_customer (
    customer_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name VARCHAR2(100),
    segment VARCHAR2(50)
);

CREATE TABLE dim_product (
    product_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    sub_category VARCHAR2(50)
);

CREATE TABLE dim_region (
    region_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    region VARCHAR2(50),
    country VARCHAR2(50)
);

CREATE TABLE dim_date (
    date_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_date DATE,
    year NUMBER,
    month NUMBER,
    day NUMBER
);

/* ---------- 3. FACT TABLE ---------- */

CREATE TABLE fact_sales (
    sales_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id NUMBER,
    product_id NUMBER,
    region_id NUMBER,
    date_id NUMBER,
    sales NUMBER,
    quantity NUMBER,
    profit NUMBER,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES dim_customer(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES dim_product(product_id),
    CONSTRAINT fk_region FOREIGN KEY (region_id)
        REFERENCES dim_region(region_id),
    CONSTRAINT fk_date FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);

/* ---------- 4. LOAD DATA INTO DIMENSIONS ---------- */

INSERT INTO dim_customer (customer_name, segment)
SELECT DISTINCT customer_name, segment
FROM raw_sales;

INSERT INTO dim_product (product_name, category, sub_category)
SELECT DISTINCT product_name, category, sub_category
FROM raw_sales;

INSERT INTO dim_region (region, country)
SELECT DISTINCT region, country
FROM raw_sales;

INSERT INTO dim_date (order_date, year, month, day)
SELECT DISTINCT
    order_date,
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    EXTRACT(DAY FROM order_date)
FROM raw_sales;

/* ---------- 5. LOAD DATA INTO FACT TABLE ---------- */

INSERT INTO fact_sales (
    customer_id,
    product_id,
    region_id,
    date_id,
    sales,
    quantity,
    profit
)
SELECT
    c.customer_id,
    p.product_id,
    r.region_id,
    d.date_id,
    rs.sales,
    rs.quantity,
    rs.profit
FROM raw_sales rs
JOIN dim_customer c
    ON rs.customer_name = c.customer_name
JOIN dim_product p
    ON rs.product_name = p.product_name
JOIN dim_region r
    ON rs.region = r.region
JOIN dim_date d
    ON rs.order_date = d.order_date;

 ---------- 6. INDEXES ---------- 

CREATE INDEX idx_fact_customer ON fact_sales(customer_id);
CREATE INDEX idx_fact_product  ON fact_sales(product_id);
CREATE INDEX idx_fact_region   ON fact_sales(region_id);
CREATE INDEX idx_fact_date     ON fact_sales(date_id);

---------- 7. ANALYTICS QUERY ---------- 

SELECT
    d.month,
    SUM(f.sales) AS monthly_sales
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.month
ORDER BY d.month;