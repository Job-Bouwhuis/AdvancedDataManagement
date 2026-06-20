SELECT *
FROM {{ ref('stg_lap_times') }}
WHERE driver_abbreviation IS NULL