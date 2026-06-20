SELECT *
FROM {{ ref('stg_lap_times') }}
WHERE lap_number IS NULL