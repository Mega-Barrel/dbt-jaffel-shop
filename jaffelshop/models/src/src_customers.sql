

WITH raw_customers AS (
    SELECT
        *
    FROM
        {{ source('jaffel_shop', 'customer') }}
)

SELECT
    id AS customer_id,
    first_name,
    last_name
FROM
    raw_customers