SELECT *
FROM {{ ref('stg_lap_times') }}
WHERE race_id IS NULL