
WITH customers_data AS (
    SELECT
        *
    FROM
        {{ ref('src_customers') }}
),

orders_data AS (
    SELECT
        *
    FROM
        {{ ref('src_orders') }}
),

payments_data AS (
    SELECT
        *
    FROM
        {{ ref('src_payments') }}
),

customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order,
        MAX(order_date) AS most_recent_order,
        COUNT(order_id) AS total_orders
    FROM
        orders_data
    GROUP BY
        customer_id
),

customer_payments AS (
    SELECT
        o.customer_id,
        SUM(p.amount) AS total_amount
    FROM
        payments_data p
    LEFT JOIN
        orders_data o
    ON
        p.order_id = o.order_id
    GROUP BY
        o.customer_id
)


SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    co.first_order,
    co.most_recent_order,
    co.total_orders,
    cp.total_amount AS customer_lifetime_value
FROM
    customers_data c
LEFT JOIN
    customer_orders co
ON
    c.customer_id = co.customer_id
LEFT JOIN
    customer_payments cp
ON
    c.customer_id = cp.customer_id
