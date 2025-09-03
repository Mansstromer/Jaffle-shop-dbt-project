
  
    
    

    create  table
      "warehouse"."main_marts"."dm_sales_daily__dbt_tmp"
  
    as (
      -- models/marts/core/dm_sales_daily.sql


with o as (
  select order_date, order_id, customer_id, order_total
  from "warehouse"."main_marts"."fct_orders"
),
c as (
  select customer_id, cast(first_order_at as date) as first_order_date
  from "warehouse"."main_marts"."dim_customers"
),
j as (
  select
    o.*,
    case when o.order_date = c.first_order_date then 1 else 0 end as is_new_customer
  from o
  left join c using (customer_id)
)
select
  order_date,
  count(distinct order_id)                         as orders,
  sum(order_total)                                 as revenue,
  avg(order_total)                                 as aov,
  count(distinct customer_id)                      as unique_customers,
  sum(is_new_customer)                             as new_customers,
  (count(distinct customer_id) - sum(is_new_customer)) as returning_customers
from j
group by 1
    );
  
  