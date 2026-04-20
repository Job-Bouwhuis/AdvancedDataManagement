{{ config(materialized='view') }}

SELECT
    customer_id,
    signup_year,
    months_as_customer,
    monthly_fee,
    total_spent,
    hours_watched_last_month,
    days_since_last_login,
    support_calls_last_month,
    payment_failures_last_year,
    number_of_profiles,
    avg_watch_time_per_day,
    will_leave
FROM {{ source('customer_leaving', 'customers') }}
