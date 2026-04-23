{{ config(materialized='view') }}

-- Compare predictions against actual will_leave values
-- and calculate the overall model accuracy.

WITH actuals AS (
    SELECT
        customer_id AS test_customer_id,
        will_leave  AS actual_will_leave
    FROM {{ ref('ml_test_customers') }}
),

comparison AS (
    SELECT
        CASE
            WHEN p.predicted_will_leave = a.actual_will_leave THEN 1
            ELSE 0
        END AS correct
    FROM {{ ref('ml_test_predictions') }} p
    LEFT JOIN actuals a
        ON p.test_customer_id = a.test_customer_id
)

SELECT
    COUNT(*)                                             AS total_predictions,
    SUM(correct)                                         AS correct_predictions,
    ROUND(CAST(SUM(correct) AS FLOAT) / COUNT(*), 4)     AS accuracy_score
FROM comparison
