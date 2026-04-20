{{ config(materialized='table') }}

-- For each test customer, find the K nearest training neighbours,
-- then predict using majority vote and calculate a confidence score.

WITH ranked_neighbours AS (
    SELECT
        test_customer_id,
        train_will_leave,
        distance,
        ROW_NUMBER() OVER (
            PARTITION BY test_customer_id
            ORDER BY distance ASC
        ) AS neighbour_rank
    FROM {{ ref('ml_test_distances') }}
),

k_value AS (
    SELECT k FROM {{ ref('ml_k_value') }}
),

k_neighbours AS (
    SELECT
        rn.test_customer_id,
        rn.train_will_leave
    FROM ranked_neighbours rn
    CROSS JOIN k_value k
    WHERE rn.neighbour_rank <= k.k
),

votes AS (
    SELECT
        test_customer_id,
        SUM(train_will_leave) AS votes_leave,
        COUNT(*)              AS total_votes
    FROM k_neighbours
    GROUP BY test_customer_id
)

SELECT
    test_customer_id,
    CASE
        WHEN votes_leave > (total_votes / 2.0) THEN 1
        ELSE 0
    END AS predicted_will_leave,
    CASE
        WHEN votes_leave > (total_votes / 2.0)
            THEN CAST(votes_leave AS FLOAT) / total_votes
        ELSE CAST(total_votes - votes_leave AS FLOAT) / total_votes
    END AS confidence_score
FROM votes
