with src as (
  select * from "warehouse"."main_raw"."raw_items"
)
select
  cast(order_id as varchar) as order_id,  -- FK to orders
  cast(sku      as varchar) as product_id, 
  1                           as quantity  -- Assumption: one row = one item
from src