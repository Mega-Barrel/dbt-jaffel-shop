USE ROLE ACCOUNTADMIN;


-- Create the `transform` role
CREATE ROLE IF NOT EXISTS transform;
GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN;


-- Create the default warehouse if necessary
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;


CREATE USER IF NOT EXISTS dbt_jaffel_shop
  PASSWORD='your password'
  LOGIN_NAME='login name'
  MUST_CHANGE_PASSWORD=FALSE
  DEFAULT_WAREHOUSE='COMPUTE_WH'
  DEFAULT_ROLE='transform'
  DEFAULT_NAMESPACE='jaffel_shop.RAW'
  COMMENT='DBT_jaffel_shop user for data transformation'
;


GRANT ROLE transform to USER dbt_jaffel_shop;


-- Create our database and schemas
CREATE DATABASE IF NOT EXISTS jaffel_shop;
CREATE SCHEMA IF NOT EXISTS jaffel_shop.RAW;


-- Set up permissions to role `transform`
GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE transform; 
GRANT ALL ON DATABASE jaffel_shop to ROLE transform;
GRANT ALL ON ALL SCHEMAS IN DATABASE jaffel_shop to ROLE transform;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE jaffel_shop to ROLE transform;
GRANT ALL ON ALL TABLES IN SCHEMA jaffel_shop.RAW to ROLE transform;
GRANT ALL ON FUTURE TABLES IN SCHEMA jaffel_shop.RAW to ROLE transform;