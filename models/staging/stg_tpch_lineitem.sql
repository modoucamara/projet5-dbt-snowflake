with source as (
    select * from {{ source('tpch', 'lineitem') }}
),

cleaned_and_renamed as (
    select
        -- Création d'une clé primaire unique robuste
        cast(l_orderkey as varchar) || '-' || cast(l_linenumber as varchar) as order_item_key,
        cast(l_orderkey as integer) as order_key,
        cast(l_partkey as integer) as part_key,
        cast(l_suppkey as integer) as supplier_key,
        cast(l_linenumber as integer) as line_number,
        cast(l_quantity as decimal(15, 2)) as quantity,
        cast(l_extendedprice as decimal(15, 2)) as extended_price,
        -- Si aucun rabais, on force la valeur à 0.0
        coalesce(l_discount, 0.0) as discount_percentage,
        coalesce(l_tax, 0.0) as tax_rate,
        coalesce(trim(l_returnflag), 'NONE') as return_flag,
        coalesce(trim(l_linestatus), 'UNKNOWN') as line_status,
        cast(l_shipdate as date) as ship_date,
        cast(l_commitdate as date) as commit_date,
        cast(l_receiptdate as date) as receipt_date,
        coalesce(trim(l_shipinstruct), 'NONE') as ship_instructions,
        coalesce(trim(l_shipmode), 'UNKNOWN') as ship_mode,
        coalesce(trim(l_comment), 'No comment') as comment
    from source
)

-- Filtre de sécurité pour écarter d'éventuelles transactions de test aberrantes
select * from cleaned_and_renamed
where quantity >= 0