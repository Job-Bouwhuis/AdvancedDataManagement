{{ config(materialized='view') }}

-- Set the K value used by the KNN algorithm.
-- K = 5 is a common starting point for small datasets.
-- A higher K produces a smoother decision boundary; a lower K is more sensitive to noise.

SELECT 5 AS k
