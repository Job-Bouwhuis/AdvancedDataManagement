{{ config(severity='warn') }}

select *
from {{ ref('stg_breeds') }}
where size not in ('small', 'medium', 'large')