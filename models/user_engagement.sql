-- models/new_table_model.sql
{{
  config(
    materialized='table' 
  )
}}

DROP TABLE IF EXISTS new_table_model;

CREATE TABLE IF NOT EXISTS new_table_model AS 
(
SELECT
*
FROM {{ ref('users') }}
)

