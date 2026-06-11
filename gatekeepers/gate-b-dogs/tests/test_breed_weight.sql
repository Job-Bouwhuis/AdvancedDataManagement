{{ config(severity='error') }}

SELECT *
FROM {{ ref('stg_breeds') }}
WHERE weight IS NOT NULL
  AND ( weight < 1 OR weight > 99 )