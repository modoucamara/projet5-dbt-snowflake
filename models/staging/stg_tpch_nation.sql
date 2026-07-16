with source as (
    select * from {{ source('tpch', 'nation') }}
),

cleaned_and_renamed as (
    select
        cast(n_nationkey as integer) as nation_key,
        -- Standardisation du nom du pays en majuscules sans espaces superflus
        upper(trim(n_name)) as nation_name,
        cast(n_regionkey as integer) as region_key,
        coalesce(trim(n_comment), 'No comment') as comment
    from source
)

select * from cleaned_and_renamed