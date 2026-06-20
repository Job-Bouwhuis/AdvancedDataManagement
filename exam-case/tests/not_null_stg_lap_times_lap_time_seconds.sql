SELECT *
FROM {{ ref('stg_lap_times') }}
WHERE lap_time_seconds IS NULL