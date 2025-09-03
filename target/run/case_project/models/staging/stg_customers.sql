
  
  create view "warehouse"."main_staging"."stg_customers__dbt_tmp" as (
    -- models/staging/stg_customers.sql
with src as (select * from "warehouse"."main_raw"."raw_customers")
select
  cast(id as varchar) as customer_id,
  trim(name) as customer_name
from src
  );
