select
    cast(programme_code as varchar) as programme_code,
    cast(programme_name as varchar) as programme_name,
    cast(start_date as date)        as start_date,
    cast(credits as integer)        as credits
from {{ source('raw', 'raw_programmes') }}
