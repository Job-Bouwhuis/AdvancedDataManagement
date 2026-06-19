{{ config(materialized='table') }}

SELECT

    {{ dbt_utils.generate_surrogate_key(['driver_id', 'race_id']) }} AS consistency_key,
    
    driver_id,
    race_id,
    
    lap_time_stddev AS consistency_stddev,
    lap_time_cv AS consistency_cv,
    lap_time_range AS consistency_range,
    avg_lap_time,
    total_laps,
    
    is_wet,
    weather_condition,
    avg_track_temp,
    
    CURRENT_TIMESTAMP AS loaded_at
FROM {{ ref('int_race_driver_consistency') }}