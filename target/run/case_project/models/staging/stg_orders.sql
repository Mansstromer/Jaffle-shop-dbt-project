
  
  create view "warehouse"."main_staging"."stg_orders__dbt_tmp" as (
    with src as (
  select * from "warehouse"."main_raw"."raw_orders"
)
select
  cast(id as varchar)                 as order_id,
  cast(customer as varchar)           as customer_id,
  cast(store_id as varchar)           as store_id,
  cast(ordered_at as timestamp)       as ordered_at,
  cast(subtotal as decimal(10,2))            as subtotal,
  cast(tax_paid as decimal(10,2))            as tax_paid,
  cast(order_total as decimal(10,2))         as order_total
from src
  );
