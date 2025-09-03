with src as (
  select * from {{ source('raw','items') }}
)
select
  cast(order_id as varchar) as order_id,  -- FK to orders
  cast(sku      as varchar) as product_id, 
  1                           as quantity  -- Assumption: one row = one item
from src
