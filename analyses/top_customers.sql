
-- Top 10 clients par chiffre d'affaires
with fact_orders as (
    select * from {{ ref('fact_orders') }}
),

dim_customers as (
    select * from {{ ref('dim_customers') }}
)

select
    c.customer_name,
    c.nation_name,
    c.region_name,
    sum(f.total_net_amount) as lifetime_value,
    count(distinct f.order_key) as total_orders
from fact_orders f
inner join dim_customers c
    on f.customer_key = c.customer_key
group by
    c.customer_name,
    c.nation_name,
    c.region_name
order by lifetime_value desc
limit 10

