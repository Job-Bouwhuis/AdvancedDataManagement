SELECT
  md5(student_id) AS student_sk,
  student_id
FROM {{ ref('int_enrolments') }}
GROUP BY student_id