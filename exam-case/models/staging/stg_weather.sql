{{ config(materialized='view') }}
WITH weather_aggregated AS (
    SELECT
        race_id,
        circuit,
        race_year,
        
        AVG(AirTemp) AS avg_air_temp,
        AVG(TrackTemp) AS avg_track_temp,
        AVG(Humidity) AS avg_humidity,
        AVG(Pressure) AS avg_pressure,
        AVG(WindSpeed) AS avg_wind_speed,
        
        MAX(CASE 
            WHEN Rainfall = 'True' OR Rainfall = 'true' OR Rainfall = 'TRUE' THEN 1 
            ELSE 0 
        END) AS had_rain,
        
        MIN(TrackTemp) AS min_track_temp,
        MAX(TrackTemp) AS max_track_temp,
        
        MAX(TrackTemp) - MIN(TrackTemp) AS track_temp_variation,
        
        COUNT(*) AS reading_count,
        COUNT(CASE WHEN AirTemp IS NOT NULL THEN 1 END) AS air_temp_readings,
        COUNT(CASE WHEN TrackTemp IS NOT NULL THEN 1 END) AS track_temp_readings
    FROM {{ source('raw', 'raw_weather') }}
    WHERE race_id IS NOT NULL
      AND race_id != ''
    GROUP BY race_id, circuit, race_year
)

SELECT
    race_id,
    circuit,
    race_year,
    avg_air_temp,
    avg_track_temp,
    avg_humidity,
    avg_pressure,
    avg_wind_speed,
    had_rain AS is_wet,
    CASE 
        WHEN had_rain = 1 THEN 'Wet'
        ELSE 'Dry'
    END AS weather_condition,
    min_track_temp,
    max_track_temp,
    track_temp_variation,
    
    reading_count,
    air_temp_readings,
    track_temp_readings
FROM weather_aggregated
WHERE race_id IS NOT NULL
  AND avg_air_temp IS NOT NULL
  AND avg_track_temp IS NOT NULL
  AND avg_humidity IS NOT NULL
ORDER BY race_id