-- models/new_table_model.sql
{{
  config(
    materialized='table' 
  )
}}

CREATE TABLE IF NOT EXISTS new_table_model AS 
(
SELECT
*
FROM {{ ref('users') }}
)

