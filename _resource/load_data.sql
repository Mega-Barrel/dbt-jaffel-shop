USE WAREHOUSE COMPUTE_WH;
USE DATABASE jaffel_shop;
USE SCHEMA RAW;

-- Customers table
CREATE TABLE IF NOT EXISTS customers ( 
    id integer,
    first_name varchar,
    last_name varchar
);

COPY INTO customers (
    id, 
    first_name, 
    last_name
)

FROM 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);


-- Orders table
CREATE TABLE IF NOT EXISTS orders ( 
    id integer,
    user_id integer,
    order_date date,
    status varchar,
    _etl_loaded_at timestamp default current_timestamp
);

COPY INTO orders (
    id, 
    user_id, 
    order_date, 
    status
)
FROM 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);

-- Payments table
CREATE TABLE payment (
    id integer,
    orderid integer,
    paymentmethod varchar,
    status varchar,
    amount integer,
    created date,
    _batched_at timestamp default current_timestamp
);

COPY into payment (
    id, 
    orderid, 
    paymentmethod, 
    status, 
    amount, 
    created
)
FROM 's3://dbt-tutorial-public/stripe_payments.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
);