
-- Ventes totales par région
with fact_order_items as (
    select * from {{ ref('fact_order_items') }}
),

dim_customers as (
    select * from {{ ref('dim_customers') }}
)

select
    c.region_name,
    sum(f.net_amount) as total_sales,
    count(distinct f.order_key) as total_orders,
    count(distinct f.customer_key) as total_customers
from fact_order_items f
inner join dim_customers c
    on f.customer_key = c.customer_key
group by c.region_name
order by total_sales desc

