select
    cast(student_id as varchar)           as student_id,
    cast(programme_code as varchar)       as programme_code,
    cast(enrolment_date as date)           as enrolment_date,
    lower(cast(enrolment_status as varchar)) as enrolment_status
from {{ source('raw', 'raw_student_enrolments') }}
