
  
  create view "warehouse"."main_marts"."orders_fact__dbt_tmp" as (
    with orders as (
  select
    order_id,
    customer_id,
    order_date,
    order_month,
    revenue_usd as order_revenue_usd  -- <- net of tax
  from "warehouse"."main_marts"."fct_orders"
),
first_order as (
  select customer_id, min(order_date) as first_order_date
  from orders
  group by 1
)
select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.order_month,
  o.order_revenue_usd,
  case when o.order_date = f.first_order_date then true else false end as is_first_order,
  case when o.order_date = f.first_order_date then 'new' else 'repeat' end as customer_cohort
from orders o
join first_order f using (customer_id)
  );
