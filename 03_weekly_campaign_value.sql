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
)

SELECT
    DATE_TRUNC('week', ad_date)::date AS week_start,
    campaign_name,
    SUM(value) AS weekly_value
FROM data_together
GROUP BY
    week_start,
    campaign_name
ORDER BY
    weekly_value DESC NULLS LAST
LIMIT 1;