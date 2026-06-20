SELECT *
FROM {{ ref('stg_lap_times') }}
WHERE lap_time_seconds <= 0 OR lap_time_seconds >= 1200