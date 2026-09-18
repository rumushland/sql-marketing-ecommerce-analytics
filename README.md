
# SQL Marketing & E-commerce Analytics

**PostgreSQL | Google BigQuery | Google Analytics 4 (GA4)**

## Project Overview

This project uses SQL to analyze online advertising performance and e-commerce user behavior across two independent datasets.

The advertising analysis examines Google Ads and Facebook Ads campaign performance using PostgreSQL. The e-commerce analysis uses Google BigQuery and Google Analytics 4 (GA4) event data to evaluate traffic channels and purchase conversions.

The objective is to transform raw data into meaningful insights that support data-driven business decisions.

## Tools & Technologies

- **SQL:** Data extraction, transformation and analysis
- **PostgreSQL:** Advertising performance analysis
- **DBeaver:** SQL development and database access
- **Google BigQuery:** E-commerce event analysis
- **Google Analytics 4 (GA4):** User behavior and conversion data

## Data Sources

**Advertising Data:** Google Ads and Facebook Ads performance data accessed through DBeaver using a PostgreSQL database.

**E-commerce Data:** Google Analytics 4 (GA4) e-commerce event data analyzed using Google BigQuery.

The two datasets were analyzed independently.

---

## 1. Advertising Performance Analysis

**Tools:** PostgreSQL, DBeaver

### Business Problem 1: Weekly Campaign Performance

**Question:** Which advertising campaign generated the highest weekly total value?

**Approach:** Used SQL DATE_TRUNC() to group campaign data by week start date and identified the campaign with the highest weekly total value.

**Finding:** The Expansion campaign generated the highest weekly total value of 2,294,120.

[View SQL Query](postgresql/03_weekly_campaign_value.sql)

### Business Problem 2: Consecutive Impression Streak

**Question:** Which ad set maintained the longest consecutive period of advertising impressions?

**Approach:** Used SQL ROW_NUMBER() to identify consecutive impression streaks.

**Finding:** Identified the longest consecutive impression streak of 108 days, including its start and end dates.

[View SQL Query](postgresql/05_longest_adset_streak.sql)

---

## 2. E-commerce & Conversion Analysis

**Tools:** Google BigQuery, Google Analytics 4 (GA4)

### Business Problem 3: Traffic Channel Conversion Analysis

**Question:** How do conversion rates vary across traffic channels?

**Approach:** Used SQL in Google BigQuery to analyze Google Analytics 4 (GA4) event data and calculate session-based cart, checkout and purchase conversion rates.

**Output:** Calculated conversion rates by date, traffic source, medium and campaign to compare performance across the purchasing journey.

[View SQL Query](bigquery/03_traffic_channel_conversions.sql)
