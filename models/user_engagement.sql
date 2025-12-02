-- models/user_engagement.sql
{{ config(materialized='table') }}

WITH CTE AS 
(
   SELECT
       user_id,
       num_docs,
       feedback_score,
       CAST(created AS DATE) as created_date,
       event_type
       from {{ ref('events') }}
   
)


SELECT
   user_id,
   EXTRACT(MONTH FROM created_date) AS month,
   EXTRACT(YEAR  FROM created_date) AS year,
   COUNT(*) AS query_counts,
   MAX(created_date) AS last_active_date,
   ARRAY_AGG(DISTINCT event_type ORDER BY event_type) AS query_types,
   SUM(num_docs) as num_docs_total,
   ROUND(AVG(feedback_score),1) AS avg_feedback_score,
   CASE  WHEN COUNT(*) >= 40 OR SUM(num_docs) >= 100 THEN 'High'
         WHEN COUNT(*) BETWEEN 10 AND 39 OR SUM(num_docs) BETWEEN 10 and 15 THEN 'Avg' ELSE 'Low' END AS engagement_level


FROM CTE
GROUP BY
   user_id, month, year 
ORDER BY
   user_id, year, month
