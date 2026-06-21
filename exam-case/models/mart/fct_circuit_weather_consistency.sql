{{ config(materialized='table') }}
SELECT
    {{ dbt_utils.generate_surrogate_key(['circuit', 'is_wet', 'race_year']) }} AS circuit_weather_key,
    circuit,
    is_wet,
    weather_condition,
    race_year,
    
    AVG(lap_time_stddev) AS avg_consistency_stddev,
    AVG(lap_time_cv) AS avg_consistency_cv,
    AVG(avg_lap_time_seconds) AS avg_lap_time_circuit,
    AVG(avg_lap_time_minutes) AS avg_lap_time_minutes_circuit,
    AVG(total_laps) AS avg_laps_completed,
    COUNT(DISTINCT driver_id) AS drivers_analyzed,
    COUNT(DISTINCT race_id) AS races_analyzed,

    AVG(avg_track_temp) AS avg_track_temp,
    AVG(track_temp_variation) AS avg_temp_variation,
    CURRENT_TIMESTAMP AS loaded_at
FROM {{ ref('int_race_driver_consistency') }}
GROUP BY
    circuit,
    is_wet,
    weather_condition,
    race_year