{{
    config(
        materialized='table',
        schema='gold'
    )
}}
{% set models_list = [
    {
        "table" : ref('silver_bookings'),
        "columns" : "SILVER_bookings.*",
        "alias" : "SILVER_bookings"
    },
    {
        "table" : ref('silver_listings'),
        "columns" : "SILVER_listings.host_id, SILVER_listings.property_type, SILVER_listings.room_type, SILVER_listings.city, SILVER_listings.country, SILVER_listings.accommodates, SILVER_listings.bedrooms, SILVER_listings.bathrooms, SILVER_listings.price_per_night, silver_listings.price_per_night_tag as PRICE_PER_NIGHT_TAG, SILVER_listings.CREATED_AT as LISTING_CREATED_AT",
        "alias" : "SILVER_listings",
        "join_condition" : "SILVER_bookings.listing_id = SILVER_listings.listing_id"
    },
    {
        "table" : ref('silver_hosts'),
        "columns" : "SILVER_hosts.host_name, SILVER_hosts.host_since, SILVER_hosts.is_superhost, SILVER_hosts.response_rate, SILVER_hosts.response_rate_quality, SILVER_hosts.CREATED_AT as HOST_CREATED_AT",
        "alias" : "SILVER_hosts",
        "join_condition" : "SILVER_listings.host_id = SILVER_hosts.host_id"
    }
]%}


select
    {% for item in models_list %}
        {{ item['columns']}} {% if not loop.last %}, {% endif %}
    {% endfor %}
FROM 
    {% for item in models_list %}
    {% if loop.first %}
        {{ item['table'] }} as {{ item['alias']}}
    {% else %}
        left join {{ item['table'] }} as {{ item['alias']}} on {{ item['join_condition'] }}
    {% endif %}
    {% endfor %}
