WITH facebook_data AS (
    SELECT
        fbad.ad_date,
        'facebook_ads' AS media_source,
        fc.campaign_name,
        fa.adset_name,
        COALESCE(fbad.spend, 0) AS spend,
        COALESCE(fbad.impressions, 0) AS impressions,
        COALESCE(fbad.value, 0) AS value,
        COALESCE(fbad.reach, 0) AS reach,
        fbad.url_parameters
    FROM facebook_ads_basic_daily fbad
    LEFT JOIN facebook_campaign fc
        ON fbad.campaign_id = fc.campaign_id
    LEFT JOIN facebook_adset fa
        ON fbad.adset_id = fa.adset_id
),

data_together AS (
    SELECT
        ad_date,
        'google_ads' AS media_source,
        campaign_name,
        adset_name,
        COALESCE(spend, 0) AS spend,
        COALESCE(impressions, 0) AS impressions,
        COALESCE(value, 0) AS value,
        COALESCE(reach, 0) AS reach,
        DATE_TRUNC('month', ad_date)::date AS ad_month,
        url_parameters
    FROM google_ads_basic_daily

    UNION ALL

    SELECT
        ad_date,
        media_source,
        campaign_name,
        adset_name,
        spend,
        impressions,
        value,
        reach,
        DATE_TRUNC('month', ad_date)::date AS ad_month,
        url_parameters
    FROM facebook_data
),

active_adset_days AS (
    SELECT DISTINCT
        ad_date,
        adset_name
    FROM data_together
    WHERE impressions > 0
),

ordered_streaks AS (
    SELECT
        ad_date,
        adset_name,
        ad_date
        - (
            ROW_NUMBER() OVER (
                PARTITION BY adset_name
                ORDER BY ad_date
            ) * INTERVAL '1 day'
        ) AS streak_group
    FROM active_adset_days
),

streak_lengths AS (
    SELECT
        adset_name,
        MIN(ad_date) AS streak_start,
        MAX(ad_date) AS streak_end,
        COUNT(*) AS streak_length
    FROM ordered_streaks
    GROUP BY
        adset_name,
        streak_group
)

SELECT
    adset_name,
    streak_start,
    streak_end,
    streak_length
FROM streak_lengths
ORDER BY
    streak_length DESC
LIMIT 1;