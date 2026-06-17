SELECT
  md5(student_id || programme_code || enrolment_date::VARCHAR) AS enrolment_sk,
  md5(student_id)      AS student_sk,
  md5(programme_code)  AS programme_sk,
  enrolment_date       AS date_sk,
  enrolment_status,
  days_before_start,
  enrolment_period,
  CASE WHEN enrolment_status = 'enrolled' THEN 1 ELSE 0 END AS is_active
FROM {{ ref('int_enrolments') }}