
  
  create view "warehouse"."main_marts"."fct_orders__dbt_tmp" as (
    -- Revenue = subtotal (excl. tax); Gross = subtotal + tax
select
  o.order_id,
  o.customer_id,
  cast(o.ordered_at as date)                              as order_date,
  strftime(date_trunc('month', o.ordered_at), '%Y-%m-01') as order_month,

  -- cents -> USD
  o.subtotal    / 100.0 as revenue_usd,        -- <- use this everywhere for KPIs/charts
  o.tax_paid    / 100.0 as tax_usd,
  o.order_total / 100.0 as gross_sales_usd     -- (= revenue_usd + tax_usd)
from "warehouse"."main_staging"."stg_orders" as o
  );
