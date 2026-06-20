SELECT *
FROM {{ ref('stg_session_results') }}
WHERE final_position < 1 OR final_position > 25