{{ config(materialized='table') }}

-- Assign a random value to each row so we can split into train/test
-- without the original row order influencing the result.

SELECT
    *,
    RANDOM() AS random_value
FROM {{ ref('stg_customers') }}
