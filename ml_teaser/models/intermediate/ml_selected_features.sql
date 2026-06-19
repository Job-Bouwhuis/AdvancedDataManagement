{{ config(materialized='view') }}

-- Choose exactly 4 features from ml_train_customers that predict churn.
-- Alias them as feature_1, feature_2, feature_3, feature_4.
-- The downstream normalisation, distance, and prediction models all
-- depend on these exact column names — do not change them.
--
-- Also include customer_id and will_leave (the target).
--
-- Example:
--   days_since_last_login AS feature_1,

SELECT
    customer_id,
    months_as_customer AS feature_1,
    hours_watched_last_month AS feature_2,
    days_since_last_login AS feature_3,
    support_calls_last_month AS feature_4,
    will_leave
FROM {{ ref('ml_train_customers') }}
