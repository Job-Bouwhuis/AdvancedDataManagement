{{ config(materialized='table') }}
SELECT DISTINCT
    race_id,
    circuit,
    race_year,
    is_wet,
    weather_condition,
    avg_track_temp,
    track_temp_variation
FROM {{ ref('int_race_driver_consistency') }}
ORDER BY race_id