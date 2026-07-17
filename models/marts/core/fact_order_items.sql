
{{
    config(
        materialized='table'
    )
}}

with orders_lineitems as (
    select * from {{ ref('int_orders_lineitems') }}
)

select
    order_item_key,
    order_key,
    customer_key,
    part_key,
    supplier_key,
    line_number,
    order_date as order_date_key,
    ship_date as ship_date_key,
    order_status,
    order_priority,
    ship_mode,
    return_flag,
    line_status,
    quantity,
    extended_price,
    discount_percentage,
    tax_rate,
    net_amount,
    total_amount
from orders_lineitems

