{% snapshot dim_hosts %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='host_id',
      strategy='timestamp',
      updated_at='HOST_CREATED_AT',
      dbt_valid_to_current="to_date('2099-12-31', 'YYYY-MM-DD')"
    )
}}

select * from {{ ref('hosts') }}

{% endsnapshot %}
