SELECT *
FROM {{ ref('stg_session_results') }}
WHERE driver_id IS NULL