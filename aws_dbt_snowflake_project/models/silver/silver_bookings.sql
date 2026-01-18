{{
    config(materialized='incremental',
         unique_key='booking_id')
}}

select 
    booking_id,
    listing_id,
    Booking_date,
    {{ multiply('Nights_booked', 'Booking_amount', 2)}} as total_amount,
    Cleaning_fee,
    service_fee, 
    Booking_status,
    created_at
From
    {{ ref('bronze_bookings') }}