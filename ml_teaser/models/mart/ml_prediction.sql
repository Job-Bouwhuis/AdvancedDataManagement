{{ config(materialized='view') }}

-- Predict the new customer from Step 8 using your trained KNN model.
--
-- Look at the new customer data in the question paper and enter the raw value
-- for each of YOUR chosen features in new_customer_normalised below.
--
-- New customer data:
--   months_as_customer = 2        monthly_fee = 15
--   hours_watched_last_month = 3  days_since_last_login = 18
--   support_calls_last_month = 2  payment_failures_last_year = 1
--   number_of_profiles = 1        avg_watch_time_per_day = 0.1

WITH training_stats AS (
    SELECT
        MIN(feature_1) AS min_f1, MAX(feature_1) AS max_f1,
        MIN(feature_2) AS min_f2, MAX(feature_2) AS max_f2,
        MIN(feature_3) AS min_f3, MAX(feature_3) AS max_f3,
        MIN(feature_4) AS min_f4, MAX(feature_4) AS max_f4
    FROM {{ ref('ml_selected_features') }}
),

new_customer_normalised AS (
    SELECT
        (NULL - s.min_f1) / NULLIF(s.max_f1 - s.min_f1, 0) AS feature_1_n,  -- TODO: enter value for your feature_1
        (NULL - s.min_f2) / NULLIF(s.max_f2 - s.min_f2, 0) AS feature_2_n,  -- TODO: enter value for your feature_2
        (NULL - s.min_f3) / NULLIF(s.max_f3 - s.min_f3, 0) AS feature_3_n,  -- TODO: enter value for your feature_3
        (NULL - s.min_f4) / NULLIF(s.max_f4 - s.min_f4, 0) AS feature_4_n   -- TODO: enter value for your feature_4
    FROM training_stats s
),

distances AS (
    SELECT
        t.customer_id AS train_customer_id,
        t.will_leave  AS train_will_leave,
        SQRT(
            POWER(nc.feature_1_n - t.feature_1_n, 2) +
            POWER(nc.feature_2_n - t.feature_2_n, 2) +
            POWER(nc.feature_3_n - t.feature_3_n, 2) +
            POWER(nc.feature_4_n - t.feature_4_n, 2)
        ) AS distance
    FROM {{ ref('ml_train_customers_n') }} t
    CROSS JOIN new_customer_normalised nc
),

k_nearest AS (
    SELECT train_will_leave
    FROM distances
    ORDER BY distance ASC
    LIMIT (SELECT k FROM {{ ref('ml_k_value') }})
),

vote AS (
    SELECT
        SUM(train_will_leave) AS votes_leave,
        COUNT(*)              AS total_votes
    FROM k_nearest
)

SELECT
    CASE
        WHEN votes_leave > (total_votes / 2.0) THEN 1
        ELSE 0
    END AS predicted_will_leave,
    CASE
        WHEN votes_leave > (total_votes / 2.0)
            THEN CAST(votes_leave AS FLOAT) / total_votes
        ELSE CAST(total_votes - votes_leave AS FLOAT) / total_votes
    END AS confidence_score
FROM vote
