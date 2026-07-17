
with customers as (
    select * from {{ ref('stg_tpch_customer') }}
),

nations as (
    select * from {{ ref('stg_tpch_nation') }}
),

regions as (
    select * from {{ ref('stg_tpch_region') }}
)

select
    c.customer_key,
    c.customer_name,
    c.address,
    c.phone_number,
    c.account_balance,
    c.market_segment,
    n.nation_key,
    n.nation_name,
    r.region_key,
    r.region_name
from customers c
inner join nations n
    on c.nation_key = n.nation_key
inner join regions r
    on n.region_key = r.region_key

