
{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_tpch_orders') }}
),

order_items as (
    select * from {{ ref('fact_order_items') }}
)

select
    o.order_key,
    o.customer_key,
    o.order_date as order_date_key,
    o.order_status,
    o.total_price,
    o.order_priority,
    o.clerk,
    o.ship_priority,
    -- Agrégats par commande
    count(distinct oi.order_item_key) as total_items,
    sum(oi.quantity) as total_quantity,
    sum(oi.net_amount) as total_net_amount,
    sum(oi.total_amount) as total_gross_amount
from orders o
left join order_items oi
    on o.order_key = oi.order_key
group by
    o.order_key,
    o.customer_key,
    o.order_date,
    o.order_status,
    o.total_price,
    o.order_priority,
    o.clerk,
    o.ship_priority

<<<<<<< HEAD

=======
>>>>>>> b38adda (Ajout modèles intermediate et marts - Rôle 3)
