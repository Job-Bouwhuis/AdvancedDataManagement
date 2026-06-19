{{ config(materialized='view') }}

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
    Points
FROM {{ source('raw', 'raw_session_results') }}