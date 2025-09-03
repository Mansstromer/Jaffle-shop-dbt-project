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