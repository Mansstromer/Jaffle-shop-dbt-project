-- models/marts/core/dm_product_performance.sql


with li as (
  select product_id, product_name, quantity, line_revenue
  from "warehouse"."main_marts"."fct_order_items"
)
select
  product_id,
  product_name,
  sum(quantity)                                    as units_sold,
  sum(line_revenue)                                as revenue,
  sum(line_revenue) * 1.0 / nullif(sum(quantity), 0) as realized_unit_price
from li
group by 1,2