with enrolments as (

    select
        student_id,
        programme_code,
        enrolment_date,
        enrolment_status
    from {{ ref('stg_student_enrolments') }}

),

programmes as (

    select
        programme_code,
        programme_name,
        start_date,
        credits
    from {{ ref('stg_programmes') }}

),

joined as (

    select
        e.student_id,
        e.programme_code,
        e.enrolment_date,
        e.enrolment_status,

        p.programme_name,
        p.start_date,
        p.credits,

        datediff('day', e.enrolment_date, p.start_date) as days_before_start,

        case
            when datediff('day', e.enrolment_date, p.start_date) > 30 then 'early'
            when datediff('day', e.enrolment_date, p.start_date) between 0 and 30 then 'on_time'
            else 'late'
        end as enrolment_period

    from enrolments e
    left join programmes p
        on e.programme_code = p.programme_code

)

select *
from joined