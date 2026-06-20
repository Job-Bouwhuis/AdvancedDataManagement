{{ config(materialized='table') }}
SELECT
    {{ dbt_utils.generate_surrogate_key(['driver_id', 'race_year']) }} AS season_consistency_key,
    driver_id,
    race_year,
    
    AVG(lap_time_stddev) AS avg_consistency_stddev,
    AVG(lap_time_cv) AS avg_consistency_cv,
    AVG(avg_lap_time) AS avg_lap_time_season,
    COUNT(DISTINCT race_id) AS races_completed,
    
    AVG(CASE WHEN is_wet = TRUE THEN lap_time_stddev ELSE NULL END) AS avg_consistency_wet,
    AVG(CASE WHEN is_wet = FALSE THEN lap_time_stddev ELSE NULL END) AS avg_consistency_dry,
    
    CORR(avg_track_temp, lap_time_stddev) AS temp_consistency_correlation,
    CURRENT_TIMESTAMP AS loaded_at
FROM {{ ref('int_race_driver_consistency') }}
GROUP BY
    driver_id,
    race_year