{{
    config(materialized='incremental', unique_key='listing_id')
}}

select 
    listing_id,
    host_id,
    property_type,
    room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    price_per_night,
    {{ tag('price_per_night')}} AS PRICE_PER_NIGHT_TAG,
    created_at
from
    {{ ref('bronze_listings') }}