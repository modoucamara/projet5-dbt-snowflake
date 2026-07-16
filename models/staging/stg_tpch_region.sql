with source as (
    select * from {{ source('tpch', 'region') }}
),

cleaned_and_renamed as (
    select
        cast(r_regionkey as integer) as region_key,
        -- Standardisation du nom de la région en majuscules
        upper(trim(r_name)) as region_name,
        coalesce(trim(r_comment), 'No comment') as comment
    from source
)

select * from cleaned_and_renamed