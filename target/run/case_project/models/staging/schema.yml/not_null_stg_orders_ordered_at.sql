
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ordered_at
from "warehouse"."main_staging"."stg_orders"
where ordered_at is null



  
  
      
    ) dbt_internal_test