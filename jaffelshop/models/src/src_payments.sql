
WITH raw_payments as (
    SELECT
        *
    FROM
        {{ source('jaffel_shop', 'payment') }}
)

SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    amount / 100 AS amount 
FROM
    raw_payments
