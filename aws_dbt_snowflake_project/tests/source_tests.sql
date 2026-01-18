{{ config(
    severity = 'warn'
) }}

select
    1
from 
    {{ source('staging', 'bookings') }}
where 
    Booking_amount < 200