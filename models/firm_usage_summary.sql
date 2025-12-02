-- models/firm_usage_summary.sql
{{ config(materialized='table') }}

SELECT
f.id as firm_id,
f.firm_size as firm_size,
f.arr_in_thousands as arr_in_thousands,
CAST(e.created AS DATE) as date,
COUNT(distinct e.user_id) as user_counts,
COUNT(*) as total_queries,
SUM(e.num_docs) as total_num_docs
FROM  {{ ref('events') }} e LEFT JOIN  {{ ref('firms') }} f ON e.firm_id = f.id
GROUP BY f.id,firm_size,arr_in_thousands,date
ORDER BY f.id, date
