-- models/marts/dim_products.sql


select
    p.product_id,
    p.product_name,
    p.price as current_list_price
from "warehouse"."main_staging"."stg_products" p