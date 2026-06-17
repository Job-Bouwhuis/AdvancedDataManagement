WITH months AS (
  SELECT DISTINCT
    DATE_TRUNC('month', enrolment_date)::DATE AS month_sk
  FROM {{ ref('int_enrolments') }}
)
SELECT
  month_sk,
  YEAR(month_sk) AS year,
  MONTH(month_sk) AS month,
  STRFTIME(month_sk, '%B') AS month_name
FROM months