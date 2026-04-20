{{ config(materialized='table') }}

-- Normalise the 4 selected features using Min-Max scaling.
-- Formula: (value - min) / (max - min)
-- Statistics must come from the training set only (ml_selected_features).
-- Output columns: customer_id, feature_1_n, feature_2_n, feature_3_n, feature_4_n, will_leave
--
-- Hint: use a CTE to calculate MIN and MAX for each feature,
-- then CROSS JOIN it onto the main query.

-- your SQL here
