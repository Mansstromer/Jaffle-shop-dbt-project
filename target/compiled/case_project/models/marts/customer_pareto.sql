with ltv as (
  select
    customer_id,
    sum(revenue_usd) as lifetime_value_usd  -- net of tax
  from "warehouse"."main_marts"."fct_orders"
  group by 1
),
ranked as (
  select
    customer_id,
    lifetime_value_usd,
    rank()  over (order by lifetime_value_usd desc) as rnk,
    count(*) over ()                                 as total_customers,
    sum(lifetime_value_usd) over ()                  as total_revenue_usd,
    sum(lifetime_value_usd) over (
      order by lifetime_value_usd desc
      rows between unbounded preceding and current row
    )                                               as cum_revenue_usd
  from ltv
)
select
  customer_id,
  lifetime_value_usd,
  rnk,
  cast(rnk as double) / total_customers                  as customer_pct,
  cum_revenue_usd / nullif(total_revenue_usd, 0)         as revenue_cum_pct
from ranked
order by rnk