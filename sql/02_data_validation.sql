-- 1. Row count checks
SELECT
    COUNT(*) AS total_orders
FROM orders;

SELECT
    COUNT(*) AS total_order_items
FROM order_items;

SELECT
    COUNT(*) AS total_customers
FROM customers;


-- 2. Primary key uniqueness checks

-- orders: Primary key: order_id
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- order_items: Primary key: (order_id, order_item_id)
SELECT
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT CONCAT(order_id, "|", order_item_id)) as unique_order_items
FROM order_items;

-- customers: Primary key: customer_unique_id
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) as customer_ids,
    COUNT(DISTINCT customer_unique_id) as unique_customers
FROM customers;



-- 3. NULL checks on critical columns

-- Orders: key fields required for analysis
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_ids,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_ids,
    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS null_order_purchase_timestamps
FROM orders;

-- Order items: pricing fields
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_ids,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS null_order_item_ids,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_prices
FROM order_items;

-- Customers: customer identity
SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_ids,
    SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS null_customer_unique_ids
FROM customers;


-- 4. Check that the data makes sense

-- Check order_items's prices
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM order_items;

SELECT
    SUM(CASE WHEN price = 0 THEN 1 ELSE 0 END) AS free_orders,
    SUM(CASE WHEN price < 0 THEN 1 ELSE 0 END) AS negative_price_orders
FROM order_items


