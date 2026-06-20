SELECT
    driver_id,
    race_id,
    COUNT(*) as cnt
FROM {{ ref('stg_session_results') }}
GROUP BY driver_id, race_id
HAVING COUNT(*) > 1