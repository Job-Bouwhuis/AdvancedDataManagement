{{ config(materialized='table') }}

-- Normalise test customer features using the same Min-Max scaling.
-- IMPORTANT: min/max must come from the TRAINING set (ml_selected_features),
-- not the test set, so both sets are on the same scale.
-- Output columns: customer_id, feature_1_n, feature_2_n, feature_3_n, feature_4_n, will_leave
--
-- Hint: ml_test_customers still has the original column names.
-- Use a CTE to apply the same feature aliases you chose in ml_selected_features
-- before normalising (e.g. days_since_last_login AS feature_1).

-- your SQL here
