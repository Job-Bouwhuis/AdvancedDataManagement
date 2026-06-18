WITH date_range AS (
  SELECT
    MIN(enrolment_date)::DATE AS min_date,
    MAX(enrolment_date)::DATE AS max_date
  FROM {{ ref('int_enrolments') }}
)
SELECT
  d::DATE AS date_sk,
  d::DATE AS full_date,
  YEAR(d) AS year,
  MONTH(d) AS month,
  STRFTIME(d::DATE, '%B') AS month_name
FROM date_range,
  UNNEST(GENERATE_SERIES(min_date, max_date, INTERVAL '1 day')) AS t(d)