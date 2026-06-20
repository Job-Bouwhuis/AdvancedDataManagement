{{ config(materialized='table') }}
SELECT DISTINCT
    driver_id,
    team_name
FROM {{ ref('int_race_driver_consistency') }}
ORDER BY driver_id