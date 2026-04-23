{{ config(materialized='table') }}

-- Select the 70% of customers used to train the model.
-- Hint: filter WHERE random_value <= 0.7

SELECT *
FROM {{ ref('ml_randomize_customers') }}
-- add your WHERE clause here
