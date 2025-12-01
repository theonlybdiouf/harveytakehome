-- models/new_table_model.sql
{{
  config(
    materialized='table' 
  )
}}

SELECT
title,
COUNT(*)
FROM {{ ref('users') }}
GROUP BY 1