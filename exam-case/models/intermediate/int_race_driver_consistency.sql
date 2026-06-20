{{ config(materialized='table') }}
WITH finished_drivers AS (
    SELECT 
        DriverNumber,
        race_id,
        driver_id
    FROM {{ ref('stg_session_results') }}
    WHERE is_finished = TRUE
),

driver_laps AS (
    SELECT
        l.DriverNumber,
        l.driver_abbreviation,
        l.team_name,
        l.race_id,
        l.circuit,
        l.race_year,
        l.lap_number,
        l.lap_time_seconds,
        l.tire_compound,
        l.tire_life,
        f.driver_id AS driver_id,
        w.is_wet,
        w.weather_condition,
        w.avg_track_temp,
        w.track_temp_variation
    FROM {{ ref('stg_lap_times') }} l
    INNER JOIN finished_drivers f 
        ON l.DriverNumber = f.DriverNumber 
        AND l.race_id = f.race_id
    LEFT JOIN {{ ref('stg_weather') }} w 
        ON l.race_id = w.race_id
)

SELECT
    driver_id,
    driver_abbreviation,
    team_name,
    race_id,
    circuit,
    race_year,
    COUNT(lap_number) AS total_laps,
    AVG(lap_time_seconds) AS avg_lap_time,
    STDDEV(lap_time_seconds) AS lap_time_stddev,
    MIN(lap_time_seconds) AS min_lap_time,
    MAX(lap_time_seconds) AS max_lap_time,
    MAX(lap_time_seconds) - MIN(lap_time_seconds) AS lap_time_range,
    CASE 
        WHEN AVG(lap_time_seconds) > 0 
        THEN (STDDEV(lap_time_seconds) / AVG(lap_time_seconds)) * 100
        ELSE NULL
    END AS lap_time_cv,
    is_wet,
    weather_condition,
    avg_track_temp,
    track_temp_variation
FROM driver_laps
GROUP BY 
    driver_id,
    driver_abbreviation,
    team_name,
    race_id,
    circuit,
    race_year,
    is_wet,
    weather_condition,
    avg_track_temp,
    track_temp_variation