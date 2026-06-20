SELECT *
FROM {{ ref('stg_weather') }}
WHERE race_id IS NULL