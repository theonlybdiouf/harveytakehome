-- models/new_table_model.sql
{{
  config(
    materialized='table' 
  )
}}

SELECT
COUNT(*) AS total_users
FROM {{ ref('users') }}