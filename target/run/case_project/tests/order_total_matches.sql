
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- Allow small rounding differences (e.g., 0.01)
with src as (
  select
    order_id,
    subtotal,
    tax_paid,
    order_total,
    abs(order_total - (coalesce(subtotal,0) + coalesce(tax_paid,0))) as delta
  from "warehouse"."main_marts"."fct_orders"
)
select *
from src
where delta > 0.01
  
  
      
    ) dbt_internal_test