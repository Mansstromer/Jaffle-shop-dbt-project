with base as (
  select
    order_id,
    customer_id,
    order_date,
    order_month,
    order_revenue_usd
  from "warehouse"."main_marts"."orders_fact"
),
labeled as (
  select
    b.*,
    case when order_date = min(order_date) over (partition by customer_id)
         then 1 else 0 end as is_new_order
  from base b
)
select
  order_month,
  sum(order_revenue_usd)                                   as monthly_revenue_usd,   -- KPI: Revenue
  count(distinct order_id)                                 as monthly_orders,
  count(distinct customer_id)                              as active_customers,
  sum(order_revenue_usd) / nullif(count(distinct order_id),0) as aov_usd,
  sum(is_new_order)                                        as new_customers,
  (count(distinct customer_id) - sum(is_new_order))        as repeat_customers,
  (count(distinct customer_id) - sum(is_new_order)) * 1.0
    / nullif(count(distinct customer_id),0)                as repeat_purchase_rate
from labeled
group by 1
order by 1