{{ config(materialized='view') }}
WITH cleaned_results AS (
    SELECT
        LOWER(DriverId) AS driver_id,
        DriverNumber,
        race_id,
        circuit,
        race_year,
        TeamName AS team_name,
        Position AS final_position,
        Status AS race_status,
        CASE 
            WHEN Status = 'Finished' THEN TRUE 
            ELSE FALSE 
        END AS is_finished,
        Points,
        
        CASE 
            WHEN Position IS NULL THEN 'Missing position'
            WHEN Position < 1 OR Position > 25 THEN 'Invalid position'
            ELSE 'Valid'
        END AS position_quality_flag,
        CASE 
            WHEN Status IN ('Finished', 'DNF', 'Retired', 'DSQ') THEN 'Valid status'
            ELSE 'Unknown status'
        END AS status_quality_flag
    FROM {{ source('raw', 'raw_session_results') }}
)

SELECT
    driver_id,
    DriverNumber,
    race_id,
    circuit,
    race_year,
    team_name,
    final_position,
    race_status,
    is_finished,
    Points,
    
    position_quality_flag,
    status_quality_flag
FROM cleaned_results
WHERE driver_id IS NOT NULL
  AND race_id IS NOT NULL
  AND final_position IS NOT NULL
  AND final_position >= 1
ORDER BY race_id, final_position