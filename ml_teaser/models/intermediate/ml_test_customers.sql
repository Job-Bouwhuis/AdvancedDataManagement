{{ config(materialized='table') }}

-- Select the remaining 30% of customers used to evaluate the model.
-- Hint: filter WHERE random_value > 0.7

SELECT *
FROM {{ ref('ml_randomize_customers') }}
-- add your WHERE clause here
