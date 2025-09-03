
  
  create view "warehouse"."main_marts"."fct_order_items__dbt_tmp" as (
    --- models/marts/fct_order_items.sql
with items as (
  select i.order_id, i.product_id, coalesce(i.quantity, 1) as quantity
  from "warehouse"."main_staging"."stg_items" i
),
orders as (
  select order_id, customer_id,
         cast(ordered_at as date) as order_date,
         strftime(date_trunc('month', ordered_at), '%Y-%m-01') as order_month
  from "warehouse"."main_staging"."stg_orders"
),
products as (
  select
    p.product_id,
    p.product_name,
    p.price / 100.0 as unit_price_usd,
    case
      when p.product_id like 'BEV%' then 'drinks'
      when p.product_id like 'JAF%' then 'sandwiches'
      else 'other'
    end as product_category
  from "warehouse"."main_staging"."stg_products" p
)
select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.order_month,
  pr.product_id,
  pr.product_name,
  pr.product_category,
  it.quantity,
  pr.unit_price_usd,
  it.quantity * pr.unit_price_usd as line_revenue_usd
from items it
join orders  o  using (order_id)
join products pr using (product_id)
  );
