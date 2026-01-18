{% snapshot dim_listings %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='listing_id',
      strategy='timestamp',
      updated_at='LISTING_CREATED_AT',
      dbt_valid_to_current="to_date('2099-12-31', 'YYYY-MM-DD')"
    )
}}

select * from {{ ref('listings') }}

{% endsnapshot %}
