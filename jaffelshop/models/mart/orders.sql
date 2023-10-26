
{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

WITH orders AS (
    SELECT
        *
    FROM
        {{ ref('src_orders') }}
),

payments AS (
    SELECT
        *
    FROM
        {{ ref('src_payments') }}
),

order_payments AS (
    SELECT
        order_id,
        {% for payment_method in payment_methods %}
          SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN amount ELSE 0 END) AS {{ payment_method }}_amount,
        {% endfor %}
        SUM(amount) AS total_amount
    FROM
        payments
    GROUP BY
        order_id
)

SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    {% for payment_method in payment_methods %}
      op.{{ payment_method }}_amount,
    {% endfor %}
    op.total_amount AS amount
FROM
    orders o
LEFT JOIN
    order_payments op
ON
    o.order_id = op.order_id
