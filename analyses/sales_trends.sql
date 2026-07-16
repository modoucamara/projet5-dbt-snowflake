
-- Tendances des ventes par mois
with fact_order_items as (
    select * from {{ ref('fact_order_items') }}
),

dim_dates as (
    select * from {{ ref('dim_dates') }}
)

select
    d.year,
    d.month,
    d.month_name,
    sum(f.net_amount) as monthly_sales,
    count(distinct f.order_key) as monthly_orders
from fact_order_items f
inner join dim_dates d
    on f.order_date_key = d.date_key
group by
    d.year,
    d.month,
    d.month_name
order by
    d.year,
    d.month

