{{ config(materialized='view') }}

WITH parsed_laps AS (
    SELECT
        Driver AS driver_abbreviation,
        DriverNumber,
        Team AS team_name,
        race_id,
        circuit,
        race_year,
        LapNumber AS lap_number,
        EXTRACT(EPOCH FROM LapTime::INTERVAL) AS lap_time_seconds,
        Compound AS tire_compound,
        TyreLife AS tire_life,
        Position AS race_position,
        TrackStatus,
        LapTime IS NOT NULL AS has_valid_time
    FROM {{ source('raw', 'raw_lap_times') }}
)

SELECT
    driver_abbreviation,
    DriverNumber,
    team_name,
    race_id,
    circuit,
    race_year,
    lap_number,
    lap_time_seconds,
    tire_compound,
    tire_life,
    race_position
FROM parsed_laps
WHERE has_valid_time = TRUE
  AND lap_time_seconds > 0  
  AND lap_time_seconds < 999
  AND lap_time_seconds IS NOT NULL