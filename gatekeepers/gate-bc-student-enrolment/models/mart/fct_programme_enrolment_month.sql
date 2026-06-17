WITH base AS (
  SELECT
    md5(programme_code)                          AS programme_sk,
    DATE_TRUNC('month', enrolment_date)::DATE    AS month_sk,
    student_id,
    enrolment_status
  FROM {{ ref('int_enrolments') }}
)
SELECT
  programme_sk,
  month_sk,
  COUNT(*)                                               AS total_enrolments,
  COUNT(*) FILTER (WHERE enrolment_status = 'enrolled')  AS active_enrolments,
  COUNT(DISTINCT student_id)                             AS unique_students
FROM base
GROUP BY programme_sk, month_sk