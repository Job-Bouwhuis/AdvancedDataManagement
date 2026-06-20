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
        LapTime IS NOT NULL AS has_valid_time,
        
        CASE 
            WHEN EXTRACT(EPOCH FROM LapTime::INTERVAL) <= 0 THEN 'Invalid time'
            WHEN EXTRACT(EPOCH FROM LapTime::INTERVAL) >= 1200 THEN 'Extremely long lap'
            ELSE 'Valid'
        END AS time_quality_flag
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
    race_position,
    
    time_quality_flag
FROM parsed_laps
WHERE has_valid_time = TRUE
  AND lap_time_seconds > 0  
  AND lap_time_seconds < 1200 
  AND lap_time_seconds IS NOT NULL
  AND driver_abbreviation IS NOT NULL
  AND race_id IS NOT NULL
  AND lap_number IS NOT NULL
ORDER BY race_id, driver_abbreviation, lap_number