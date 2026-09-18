WITH ready_data AS (
  SELECT
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source AS source,
    traffic_source.medium AS medium,
    traffic_source.name AS campaign,
    event_name,
    user_pseudo_id ||
    CAST(
      (
        SELECT value.int_value
        FROM UNNEST(event_params)
        WHERE key = 'ga_session_id'
      ) AS STRING
    ) AS session_id

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

  WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20211231'
    AND event_name IN (
      'session_start',
      'add_to_cart',
      'begin_checkout',
      'purchase'
    )
),
valid_sessions AS (
  SELECT DISTINCT session_id
  FROM ready_data
  WHERE event_name = 'session_start'
),
sessions_count AS (
  SELECT
    r.event_date,
    r.source,
    r.medium,
    r.campaign,

    COUNT(DISTINCT CASE
      WHEN event_name = 'session_start' THEN r.session_id
    END) AS user_sessions_count,

    COUNT(DISTINCT CASE
      WHEN event_name = 'add_to_cart' THEN r.session_id
    END) AS visit_to_cart_count,

    COUNT(DISTINCT CASE
      WHEN event_name = 'begin_checkout' THEN r.session_id
    END) AS visit_to_checkout_count,

    COUNT(DISTINCT CASE
      WHEN event_name = 'purchase' THEN r.session_id
    END) AS visit_to_purchase_count

  FROM ready_data r
  INNER JOIN valid_sessions v
    ON r.session_id = v.session_id 
  GROUP BY
    event_date,
    source,
    medium,
    campaign
)

SELECT
  event_date,
  source,
  medium,
  campaign,
  user_sessions_count,
  COALESCE(ROUND(SAFE_DIVIDE(visit_to_cart_count, user_sessions_count) * 100, 2),0) AS visit_to_cart,
  COALESCE(ROUND(SAFE_DIVIDE(visit_to_checkout_count, user_sessions_count) * 100, 2),0) AS visit_to_checkout,
  COALESCE(ROUND(SAFE_DIVIDE(visit_to_purchase_count, user_sessions_count) * 100, 2),0) AS visit_to_purchase

FROM sessions_count
ORDER BY event_date DESC;
