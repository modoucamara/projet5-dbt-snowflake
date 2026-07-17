
with customer_geography as (
    select * from {{ ref('int_customer_geography') }}
)

select
    customer_key,
    customer_name,
    address,
    phone_number,
    account_balance,
    market_segment,
    nation_key,
    nation_name,
    region_key,
    region_name
from customer_geography

