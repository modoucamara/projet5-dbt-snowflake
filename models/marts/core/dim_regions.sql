
select
    region_key,
    region_name
from {{ ref('stg_tpch_region') }}

