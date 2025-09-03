-- models/marts/core/dm_customer_performance.sql


select
  customer_id,
  customer_name,
  order_count,
  lifetime_value,
  case when order_count >= 2 then 1 else 0 end               as is_repeat_customer,
  lifetime_value * 1.0 / nullif(order_count, 0)              as avg_order_value,
  cast(first_order_at as date)                                as first_order_date,
  cast(most_recent_order_at as date)                          as last_order_date,
  date_diff('day', cast(most_recent_order_at as date), current_date) as recency_days
from "warehouse"."main_marts"."dim_customers"