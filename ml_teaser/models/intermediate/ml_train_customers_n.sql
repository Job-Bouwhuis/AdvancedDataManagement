{{ config(materialized='table') }}

WITH feature_stats AS (
    SELECT
        MIN(feature_1) AS min_1,
        MAX(feature_1) AS max_1,
        MIN(feature_2) AS min_2,
        MAX(feature_2) AS max_2,
        MIN(feature_3) AS min_3,
        MAX(feature_3) AS max_3,
        MIN(feature_4) AS min_4,
        MAX(feature_4) AS max_4
    FROM {{ ref('ml_selected_features') }}
),

normalized AS (
    SELECT
        s.customer_id,
        (s.feature_1 - fs.min_1) / NULLIF(fs.max_1 - fs.min_1, 0) AS feature_1_n,
        (s.feature_2 - fs.min_2) / NULLIF(fs.max_2 - fs.min_2, 0) AS feature_2_n,
        (s.feature_3 - fs.min_3) / NULLIF(fs.max_3 - fs.min_3, 0) AS feature_3_n,
        (s.feature_4 - fs.min_4) / NULLIF(fs.max_4 - fs.min_4, 0) AS feature_4_n,
        s.will_leave
    FROM {{ ref('ml_selected_features') }} s
    CROSS JOIN feature_stats fs
)

SELECT * FROM normalized