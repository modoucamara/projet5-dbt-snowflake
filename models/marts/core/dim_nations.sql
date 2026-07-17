-- Dimension table joining nations with their regions
-- Co-authored with CoCo
with nations as (
    select * from {{ ref('stg_tpch_nation') }}
),

regions as (
    select * from {{ ref('stg_tpch_region') }}
)

select
    n.nation_key,
    n.nation_name,
    r.region_key,
    r.region_name
from nations n
inner join regions r
    on n.region_key = r.region_key

