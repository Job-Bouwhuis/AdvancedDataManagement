SELECT
    driver_abbreviation,
    race_id,
    lap_number,
    COUNT(*) as cnt
FROM {{ ref('stg_lap_times') }}
GROUP BY driver_abbreviation, race_id, lap_number
HAVING COUNT(*) > 1