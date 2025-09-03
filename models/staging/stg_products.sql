-- models/staging/stg_products.sql
with src as (select * from {{ source('raw','products') }})
select
  cast(sku as varchar)      as product_id,
  trim(name)                as product_name, 
  cast(price as decimal(10,2))    as price
from src
