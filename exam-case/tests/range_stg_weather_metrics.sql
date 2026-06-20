SELECT *
FROM {{ ref('stg_weather') }}
WHERE avg_air_temp < -50 OR avg_air_temp > 50
   OR avg_track_temp < -50 OR avg_track_temp > 50
   OR avg_humidity < 0 OR avg_humidity > 100
   OR avg_pressure < 800 OR avg_pressure > 1200
   OR avg_wind_speed < 0 OR avg_wind_speed > 100