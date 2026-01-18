{{
    config(
        materialized='table',
        schema='gold'
    )
}}
{% set models_list = [
    {
        "table" : ref('obt'),
        "columns" : "GOLD_OBT.booking_id, GOLD_OBT.listing_id, GOLD_OBT.host_id, GOLD_OBT.TOTAL_AMOUNT, GOLD_OBT.SERVICE_FEE, GOLD_OBT.CLEANING_FEE, GOLD_OBT.ACCOMMODATES, GOLD_OBT.BATHROOMS, GOLD_OBT.BEDROOMS, GOLD_OBT.PRICE_PER_NIGHT, GOLD_OBT.RESPONSE_RATE",
        "alias" : "GOLD_OBT"
    },
    {
        "table" : ref('silver_listings'),
        "columns" : "",
        "alias" : "dim_listings",
        "join_condition" : "GOLD_OBT.listing_id = dim_listings.listing_id"
    },
    {
        "table" : ref('silver_hosts'),
        "columns" : "",
        "alias" : "dim_hosts",
        "join_condition" : "GOLD_OBT.host_id = dim_hosts.host_id"
    }
]%}


select
   
        {{ models_list[0]['columns']}} 

FROM 
    {% for item in models_list %}
    {% if loop.first %}
        {{ item['table'] }} as {{ item['alias']}}
    {% else %}
        left join {{ item['table'] }} as {{ item['alias']}} on {{ item['join_condition'] }}
    {% endif %}
    {% endfor %}
