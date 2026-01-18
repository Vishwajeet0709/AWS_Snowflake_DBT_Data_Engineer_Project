{{
    config(
        materialized = 'ephemeral',
    )
}}

with bookings as
(
select 
    booking_id,
    Booking_date, 
    Booking_status,
    created_at
from {{ ref('obt') }}
)    

select * from bookings