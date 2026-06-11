WITH source AS (

    SELECT *
    FROM {{ source('dogs', 'breeds') }}

),

decoded AS (

    SELECT

        lower(trim(breed)) AS breed,
        lower(trim("group")) AS breed_group,

        TRY_CAST(REPLACE(score, ',', '.') AS DECIMAL(5,2)) AS score,
        TRY_CAST(REPLACE(longevity, ',', '.') AS DECIMAL(5,1)) AS longevity,

        CAST(ailments AS INTEGER) AS ailments,
        CAST(purchase_price AS INTEGER) AS purchase_price,

        CASE grooming
            WHEN 1 THEN 'daily'
            WHEN 2 THEN 'weekly'
            WHEN 3 THEN 'few_weeks'
            ELSE NULL
        END AS grooming,

        CASE children
            WHEN 1 THEN 'high'
            WHEN 2 THEN 'medium'
            WHEN 3 THEN 'low'
            ELSE NULL
        END AS children_suitability,

        lower(trim(size)) AS size,

        TRY_CAST(REPLACE(NULLIF(weight, 'NA'), ',', '.') AS DECIMAL(5,2)) AS weight,

        TRY_CAST(NULLIF(height, 'NA') AS INTEGER) AS height,

        CASE TRIM(repetition)
            WHEN '<5' THEN '<5'
            WHEN '5-15' THEN '5-15'
            WHEN '15-25' THEN '15-25'
            WHEN '25-40' THEN '25-40'
            WHEN '40-80' THEN '40-80'
            WHEN '>80' THEN '>80'
            ELSE NULL
        END AS repetition_bucket

    FROM source

)

SELECT *
FROM decoded