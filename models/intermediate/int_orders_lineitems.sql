
with orders as (
    select * from {{ ref('stg_tpch_orders') }}
),

lineitems as (
    select * from {{ ref('stg_tpch_lineitem') }}
)

select
    l.order_item_key,
    l.order_key,
    o.customer_key,
    l.part_key,
    l.supplier_key,
    l.line_number,
    o.order_date,
    o.order_status,
    o.order_priority,
    l.ship_date,
    l.ship_mode,
    l.return_flag,
    l.line_status,
    l.quantity,
    l.extended_price,
    l.discount_percentage,
    l.tax_rate,
    -- Calcul des indicateurs financiers
    l.extended_price * (1 - l.discount_percentage) as net_amount,
    l.extended_price * (1 - l.discount_percentage) * (1 + l.tax_rate) as total_amount
from orders o
inner join lineitems l
    on o.order_key = l.order_key

