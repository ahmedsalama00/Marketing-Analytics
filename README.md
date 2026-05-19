# 📊 End-to-End ShopEasy Marketing Analytics & Sentiment Analysis Project

## 🎯 Project Overview
This project delivers a comprehensive, data-driven solution analyzing marketing performance, customer behavior across the purchase funnel, and product feedback. By integrating **SQL data warehouse staging, Python NLP (Sentiment Analysis), robust Data Modeling, and interactive Power BI dashboards**, this project translates raw data into strategic, executive-level business decisions.

The ultimate goal is to optimize marketing spend, combat declining digital engagement, and increase overall conversion rates.

---

## 🛠️ Tech Stack & Tools
* **Database Management & ETL:** SQL Server (T-SQL)
* **Programming & NLP:** Python (Jupyter Notebook), Pandas, NLTK (VADER Lexicon)
* **Data Transformation & Modeling:** Power Query, Power BI Desktop (Star Schema)
* **Calculations:** DAX (Data Analysis Expressions)
* **Executive Reporting:** Microsoft PowerPoint

---

## 📐 Data Pipeline Architecture

### 1. Data Extraction & Advanced Cleansing (SQL)
Raw data was staged and cleaned within the SQL database to guarantee data quality and integrity before model ingestion:
* **Customer Journey Optimization (`Customer Journy.sql`):** Utilized **Window Functions** (`ROW_NUMBER`) to eliminate duplicate touchpoints and handle missing activity durations via `COALESCE` partition averages.
* **Customer Demographics & Geography (`Customers Geography.sql`):** Structured and normalized customer profiles by joining spatial data.
* **Engagement Filtering (`Engagement Data.sql`):** Cleaned social metrics, parsed consolidated strings into separate `Views` and `Clicks` metrics, and standardizing date types.
* **Product Categorization (`Price Categorize.sql`):** Dynamically segmented product pricing tiers using conditional logic (`CASE WHEN`).

### 2. AI-Powered Sentiment Analysis (Python & NLP)
To unlock deeper qualitative insights behind a stagnant **3.7/5.0 average customer rating**, a dedicated NLP pipeline was built in Python (`Sentiment Analysis.ipynb`):
* Loaded customer reviews text into an isolated workspace.
* Employed the **NLTK VADER Sentiment Intensity Analyzer** to score raw feedback text.
* Segmented reviews into highly actionable categories: `Positive`, `Negative`, `Mixed Positive`, and `Mixed Negative`.
* Exported the enriched dataset as `fact_customer_reviews_with_sentiment.csv` to directly empower dashboard analytics.

### 3. Data Modeling & DAX Measures (Power BI)
Data tables were mapped into a clean, highly scalable **Star Schema** utilizing strict **1-to-Many (One-to-Many)** relationships connecting dimension tables (`dim_customers`, `dim_products`, etc.) directly to the core fact tables.
* **Time Intelligence:** Programmed a custom **Date Table** to ensure continuous date-key coverage for month-over-month and seasonal trend analysis.
* **Calculations Workspace:** Organized a centralized measures table leveraging complex **DAX formulas** to calculate moving metrics such as *Conversion Rates, Click-Through Rates (CTR), and Audience Engagement Levels* dynamically.

### 4. Interactive Analytical Dashboards
The Power BI architecture spans **4 specialized reporting views**:
1. **Overview Dashboard:** Top-level executive summary tracking core business KPIs.
2. **Customer Journey Funnel:** Tracking step-by-step conversion pipeline stages (View -> Click -> Drop-off -> Purchase) to pinpoint drop-off friction points.
3. **Marketing Engagement Portal:** Investigating click patterns and social interactions across varied content channels.
4. **Customer Feedback Portal:** Deep-dive view visualizing sentiment score distributions and isolating low-rated product categories.

---

## 🚀 Key Insights & Business Recommendations

A detailed executive analysis was compiled into a final business report (`Report.pptx`), tackling key vulnerabilities discovered in the data:

* **The Funnel Bottleneck:** Identified a significant drop-off in the overall Conversion Rate during specific periods, hitting a **critical low of 4.48% in May**. 
  * *Action:* Shift marketing budgets toward historically proven peak months (January and December) and introduce targeted promotional incentives to bridge the mid-year seasonal slump.
* **Declining Engagement:** Social media views showed a clear downward trend, although the **CTR stood strong at 15.37%** (proving that once users engage, they interact effectively).
  * *Action:* Revitalize content strategy by pivoting to high-engagement video formats and user-generated content, optimizing Call-To-Action (CTA) placements during lower-performing months.
* **Product Satisfaction Shielding:** Product ratings hovered around a flat 3.7 average, failing the internal company target of 4.0.
  * *Action:* Deploy an automated product feedback loop targeting inventory scoring below 3.5. Leverage the sentiment classification keywords to fix product defects and initiate direct re-engagement campaigns with dissatisfied users.

---

## 📂 Repository Structure
```repo
├── SQL Scripts/
│   ├── Customer Journy.sql
│   ├── Customers Geography.sql
│   ├── Customers Reviews.sql
│   ├── Engagement Data.sql
│   └── Price Categorize.sql
├── Python NLP/
│   ├── Sentiment Analysis.ipynb
│   └── fact_customer_reviews_with_sentiment.csv
├── BI Dashboards/
│   ├── Marketing.pbix
│   └── Dashboard.pdf
└── Executive Report/
    └── Report.pptx
