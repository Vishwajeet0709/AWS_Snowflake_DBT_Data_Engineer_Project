{% snapshot dim_bookings %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='booking_id',
      strategy='timestamp',
      updated_at='created_at',
      dbt_valid_to_current="to_date('2099-12-31', 'YYYY-MM-DD')"
    )
}}

select * from {{ ref('bookings') }}

{% endsnapshot %}
