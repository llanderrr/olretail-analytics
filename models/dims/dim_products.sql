select distinct
    stock_code as product_code,
    product_description as description
from {{ ref('stg_olretail') }}
where stock_code is not null
  and product_description is not null
  and product_description = upper(product_description)
  and length(product_description) > 2
  and product_description not regexp '^[0-9]+$'