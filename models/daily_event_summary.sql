-- models/daily_event_summary.sql
{{ config(materialized='table') }}

WITH CTE AS
(
SELECT
CAST(created AS DATE) as date,
event_type,
user_id
FROM {{ ref('events') }}
   
),

DAU AS 
(
SELECT 
date,
COUNT(distinct user_id) as daily_active_users
FROM CTE 
GROUP BY date
)

SELECT
c.date as date,
c.event_type as event_type,
DAU.daily_active_users as daily_active_users,
COUNT(*) as total_events_count,
COUNT(distinct c.user_id) as unique_users
FROM CTE c JOIN DAU ON DAU.date = c.date
GROUP BY c.date,c.event_type, DAU.daily_active_users
ORDER BY c.date, c.event_type
