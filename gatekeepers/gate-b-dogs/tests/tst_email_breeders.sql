{{ config(severity='warn') }}

select *
from {{ ref('stg_breeders') }}
where email not like '%@%'
