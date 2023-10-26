
WITH raw_orders AS (
    SELECT
        *
    FROM
        {{ source('jaffel_shop', 'order') }}
)


SELECT
    id AS order_id,
    user_id AS customer_id,
    order_date,
    status
FROM
    raw_orders
