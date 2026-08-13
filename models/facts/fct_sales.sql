{{
    config(
        materialized='view'
    )
}}

with stg as (
    select * from {{ ref('stg_olretail') }}
),

customers as (
    select * from {{ ref('dim_customers') }}
),

products as (
    select * from {{ ref('dim_products') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['invoice_no', 'stock_code', 'invoice_date']) }} as sales_item_key,
    stg.invoice_no,
    stg.stock_code,
    customers.customer_key,
    stg.invoice_date,
    stg.quantity,
    stg.unit_price,
    (stg.quantity * stg.unit_price) as total_amount,
    stg.country
from stg
left join customers
    on stg.customer_id = customers.customer_id
left join products
    on stg.stock_code = products.product_code