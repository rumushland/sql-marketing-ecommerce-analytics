# online-advertising-conversion-analysis

# SQL Marketing & E-commerce Analytics

**PostgreSQL | Google BigQuery | Google Analytics 4 (GA4)**

## Project Overview

This project uses SQL to analyze online advertising performance and e-commerce user behavior across two independent datasets.

The advertising analysis examines Google Ads and Facebook Ads campaign performance using PostgreSQL. The e-commerce analysis uses Google BigQuery and Google Analytics 4 (GA4) event data to evaluate user behavior, traffic conversions, landing page performance and purchase activity.

The objective is to transform raw data into meaningful insights that support data-driven marketing and business decisions.

## Tools & Technologies

- **SQL:** Data extraction, transformation and analysis
- **PostgreSQL:** Advertising performance analysis
- **DBeaver:** SQL development and execution
- **Google BigQuery:** E-commerce event analysis
- **Google Analytics 4 (GA4):** User behavior and conversion data

## Data Sources

### Advertising Data

Google Ads and Facebook Ads datasets from the GoIT training database.

Tables used:
- `google_ads_basic_daily`
- `facebook_ads_basic_daily`
- `facebook_campaign`
- `facebook_adset`

### E-commerce Data

Google Analytics 4 public sample e-commerce dataset, accessed through Google BigQuery.

Dataset: `bigquery-public-data.ga4_obfuscated_sample_ecommerce`

The GA4 analyses use event data from 2020 and 2021.

The advertising and e-commerce datasets are analyzed separately and are not directly joined.

## 1. Advertising Performance Analysis

**Tools: PostgreSQL, DBeaver**

Analyzed Google Ads and Facebook Ads data to investigate advertising efficiency and campaign performance.

The analysis includes:

- Daily advertising spend statistics.
- Five dates with the highest return-to-spend ratios.
- Campaigns with the highest weekly total value.
- Campaigns with the largest monthly reach growth.
- Ad sets with the longest consecutive impression activity.

SQL techniques include CTEs, JOINs, UNION ALL, aggregations and window functions.

## 2. E-commerce & Conversion Analysis

**Tools: Google BigQuery, Google Analytics 4 (GA4)**

### GA4 Event Data Preparation

Extracted and transformed 2021 GA4 event data to prepare a structured dataset for BI reporting.

Selected key e-commerce events, including session starts, product views, cart additions, checkout activities and purchases.

### Traffic Channel Conversion Analysis

Calculated session-based conversion rates by date, traffic source, medium and campaign.

Metrics:
- Visit-to-Cart Rate
- Visit-to-Checkout Rate
- Visit-to-Purchase Rate

Used user and session identifiers to distinguish sessions and included only sessions containing a session_start event.

### Landing Page Conversion Analysis

Analyzed 2020 GA4 event data to compare landing pages based on:

- Unique user sessions.
- Sessions containing a purchase.
- Purchase conversion rates.

Extracted page paths and associated purchases with their corresponding landing pages using session identifiers.

### User Engagement & Purchase Correlation

Explored the relationship between user engagement and purchasing behavior using 2020 GA4 event data.

Calculated correlations between:

- Session engagement and purchase activity.
- Total engagement time and purchase activity.

## SQL Skills Demonstrated

- Common Table Expressions (CTEs)
- JOINs and UNION ALL
- Window functions: ROW_NUMBER and LAG
- Aggregation and conditional calculations
- Date and timestamp transformations
- Session-level analysis
- Conversion rate calculations
- Correlation analysis
- NULL handling and safe division

## Key Findings & Visualizations

Selected analysis results, screenshots and key findings will be added here.

## Project Structure

The repository is organized into two main analysis sections:

**PostgreSQL — Advertising Performance**

Five SQL queries covering advertising spend, return-to-spend ratios, campaign performance, reach growth and consecutive impression activity.

**BigQuery — GA4 E-commerce Analytics**

Four SQL queries covering event data preparation, traffic channel conversions, landing page conversions and engagement correlations.

## Data & Methodology Notes

- PostgreSQL queries use the GoIT training database.
- BigQuery queries use Google's public GA4 sample e-commerce dataset.
- GA4 traffic source fields represent first-user acquisition information.
- Purchase conversion metrics are calculated at the session level.
- Advertising return-to-spend is calculated as total value divided by total spend.
- Correlation results indicate statistical associations, not causation.
