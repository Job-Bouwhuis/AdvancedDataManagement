{{ config(severity='warn') }}

select *
from {{ ref('stg_breeders') }}
where breeder_email  not like '%@%'
