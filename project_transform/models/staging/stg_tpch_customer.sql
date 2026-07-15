with source as (
    select * from {{ source('tpch', 'customer') }}
),

cleaned_and_renamed as (
    select
        cast(c_custkey as integer) as customer_key,
        coalesce(trim(c_name), 'UNKNOWN') as customer_name,
        coalesce(trim(c_address), 'UNKNOWN') as address,
        cast(c_nationkey as integer) as nation_key,
        coalesce(trim(c_phone), 'UNKNOWN') as phone_number,
        cast(c_acctbal as decimal(15, 2)) as account_balance,
        coalesce(trim(c_mktsegment), 'UNKNOWN') as market_segment,
        coalesce(trim(c_comment), 'No comment') as comment
    from source
)

select * from cleaned_and_renamed