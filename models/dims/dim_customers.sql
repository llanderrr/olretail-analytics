with customers as (
    select distinct
        customer_id,
        country
    from {{ ref('stg_olretail') }}
    where customer_id is not null
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
    customer_id,
    country
from customers