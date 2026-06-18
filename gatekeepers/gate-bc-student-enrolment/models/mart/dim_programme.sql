SELECT
  md5(programme_code) AS programme_sk,
  programme_code,
  programme_name,
  start_date,
  credits
FROM {{ ref('stg_programmes') }}