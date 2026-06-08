WITH source AS (
    SELECT *
    FROM {{ source('dogs', 'breeds') }}
),

renamed AS (
    SELECT
        lower(trim(breed)) AS breed,
        "group" AS breed_group,
        score,
        longevity,
        purchase_price,
        grooming,
        size,
        weight,
        height
    FROM source
)

SELECT *
FROM renamed