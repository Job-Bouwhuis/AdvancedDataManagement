{{ config(materialized='table') }}
SELECT 
    team_name,
    race_year,
    SUM(points) AS total_team_points,
    COUNT(DISTINCT race_id) AS races_participated
FROM {{ ref('stg_session_results') }}
WHERE points IS NOT NULL
GROUP BY team_name, race_year