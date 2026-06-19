{{ config(materialized='table') }}

-- Calculate Euclidean distance between every test customer and every training customer.
-- The calculate_distance macro expands to:
--   SQRT( (f1_test - f1_train)^2 + (f2_test - f2_train)^2 + ... )
-- Output columns: test_customer_id, train_customer_id, train_will_leave, distance

SELECT
    t.customer_id AS test_customer_id,
    tr.customer_id AS train_customer_id,
    tr.will_leave AS train_will_leave,
    {{ calculate_distance('t', 'tr') }} AS distance
FROM {{ ref('ml_test_customers_n') }} t
CROSS JOIN {{ ref('ml_train_customers_n') }} tr
