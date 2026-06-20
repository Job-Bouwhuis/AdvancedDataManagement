SELECT *
FROM {{ ref('stg_session_results') }}
WHERE race_id IS NULL