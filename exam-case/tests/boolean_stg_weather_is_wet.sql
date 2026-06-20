SELECT *
FROM {{ ref('stg_weather') }}
WHERE is_wet != 0 AND is_wet != 1 AND is_wet IS NOT NULL