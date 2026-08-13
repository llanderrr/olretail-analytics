with source as (
    select * from {{ source('public', 'raw_olretail') }}
),

cleansed as (
    select
        cast(invoice as varchar) as invoice_no,
        cast(stockcode as varchar) as stock_code,
        
        case 
            when description like '%DOORMAT%' or description like '%DOOR MAT%' 
                then 'DOOR MAT / DOORMAT'
            else trim(regexp_replace(description, '\\s+', ' '))
        end as product_description,

        cast(quantity as integer) as quantity,
        cast(invoicedate as timestamp) as invoice_date,
        cast(price as decimal(18, 2)) as unit_price,
        cast(customer_id as varchar) as customer_id,
        cast(country as varchar) as country

    from source
    where invoice is not null
)

select * from cleansed