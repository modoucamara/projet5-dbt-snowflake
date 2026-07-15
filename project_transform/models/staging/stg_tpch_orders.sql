with source as (
    select * from {{ source('tpch', 'orders') }}
),

cleaned_and_renamed as (
    select
        cast(o_orderkey as integer) as order_key,
        cast(o_custkey as integer) as customer_key,
        -- Nettoyage du texte et gestion des valeurs vides éventuelles
        coalesce(trim(o_orderstatus), 'UNKNOWN') as order_status,
        cast(o_totalprice as decimal(15, 2)) as total_price,
        cast(o_orderdate as date) as order_date,
        coalesce(trim(o_orderpriority), 'NOT SPECIFIED') as order_priority,
        coalesce(trim(o_clerk), 'UNKNOWN') as clerk,
        cast(o_shippriority as integer) as ship_priority,
        coalesce(trim(o_comment), 'No comment') as comment
    from source
)

select * from cleaned_and_renamed