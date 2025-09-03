-- models/staging/stg_customers.sql
with src as (select * from {{ source('raw','customers') }})
select
  cast(id as varchar) as customer_id,
  trim(name) as customer_name
from src
