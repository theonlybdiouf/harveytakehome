-- models/new_table_model.sql
{{
  config(
    materialized='table'
  )
}}

select
  title,
  count(*) as total_users
from {{ ref('users') }}
group by 1
