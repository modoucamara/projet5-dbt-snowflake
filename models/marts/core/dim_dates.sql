-- Dimension table for dates generated via Snowflake native SQL
-- Co-authored with CoCo
{{
    config(
        materialized='table'
    )
}}

with date_spine as (
    select
        dateadd(day, seq4(), '1992-01-01'::date) as date_day
    from table(generator(rowcount => 2557))
)

select
    date_day as date_key,
    date_day,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(quarter from date_day) as quarter,
    dayofweek(date_day) as day_of_week,
    dayname(date_day) as day_name,
    monthname(date_day) as month_name
from date_spine

