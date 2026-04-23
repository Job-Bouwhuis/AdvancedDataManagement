with raw_breeders as (
    select
        id as breeder_id,
        name as breeder_name,
        contact as breeder_email,
        distance_from_purchaser
    from {{ source('dogs', 'breeders') }}
)

select
    breeder_id,
    breeder_name,
    breeder_email,
    distance_from_purchaser
from raw_breeders