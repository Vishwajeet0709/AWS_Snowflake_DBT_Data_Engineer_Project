{{
    config(materialized='incremental', unique_key='host_id')
}}

select 
    host_id,
    replace(host_name, ' ', '') as host_name,
    host_since,
    IS_SUPERHOST as is_superhost,
    RESPONSE_RATE AS RESPONSE_RATE,
    case
    when RESPONSE_RATE > 95 then 'VERY GOOD'
    when RESPONSE_RATE > 80 then 'GOOD'
    when RESPONSE_RATE > 60 then 'FAIR'
    else 'POOR'
    end as RESPONSE_RATE_QUALITY,
    created_at
from
    {{ ref('bronze_hosts') }}