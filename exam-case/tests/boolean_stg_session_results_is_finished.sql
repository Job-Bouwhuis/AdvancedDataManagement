SELECT *
FROM {{ ref('stg_session_results') }}
WHERE is_finished IS NOT TRUE AND is_finished IS NOT FALSE AND is_finished IS NOT NULL