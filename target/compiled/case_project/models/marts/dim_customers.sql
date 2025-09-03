with orders as (
  select
    customer_id,
    cast(ordered_at as date) as order_date,
    subtotal / 100.0         as revenue_usd   -- net of tax for LTV
  from "warehouse"."main_staging"."stg_orders"
)
select
  c.customer_id,
  c.customer_name,
  min(o.order_date)              as first_order_date,
  max(o.order_date)              as last_order_date,
  count(*)                       as order_count,
  sum(o.revenue_usd)             as lifetime_value_usd
from "warehouse"."main_staging"."stg_customers" c
left join orders o using (customer_id)
group by 1,2