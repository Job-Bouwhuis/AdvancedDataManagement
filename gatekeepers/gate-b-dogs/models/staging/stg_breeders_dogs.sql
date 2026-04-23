with raw_breeders_dogs as (
    select
        ROW_NUMBER() OVER() as dog_id,
        breeder_id,
        breed,
        dob
    from {{ source('dogs', 'breeders_dogs') }}
)

select
    dog_id,
    breeder_id,
    breed,
    cast(dob as date) as dob
from raw_breeders_dogs