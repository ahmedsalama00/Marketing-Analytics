# 📊 ShopEasy Marketing Data Analytics Dashboard

> **An end-to-end marketing analytics solution — from raw database to interactive insights.**

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)

---

## 🏢 About the Project

This project is a fully interactive **Power BI Dashboard** built for **ShopEasy** — an e-commerce platform — to analyze and monitor marketing performance across products, campaigns, social media channels, and customer reviews.

What makes this project different is that it's a **true end-to-end pipeline**: data was extracted using **SQL**, customer reviews were analyzed using **Python NLP (Sentiment Analysis)**, and the final interactive report was built in **Power BI** using a proper **Star Schema** data model with advanced **DAX** measures.

A **problem definition report** was written before any development began, to clearly align the analysis with business objectives.

---

## 🎯 Business Problem

ShopEasy's marketing team had data scattered across multiple sources with no unified view of:
- How well their campaigns are converting visitors into buyers
- Which products perform best across social media channels
- What customers actually think about their products (beyond star ratings)
- How conversion rates are trending compared to last year

This dashboard was built to answer all of the above in one place.

---

## 📁 Project Structure

```
ShopEasy-Marketing-Dashboard/
│
├── 📄 ShopEasy_Marketing.pbix         # Main Power BI file
├── 🐍 sentiment_analysis.py           # Python NLP script
├── 🗄️ queries/                        # SQL extraction queries
│   └── marketing_data.sql
├── 📊 data/                           # Processed data files
│   ├── fact_engagement.csv
│   ├── fact_journey.csv
│   ├── fact_reviews.csv
│   ├── dim_products.csv
│   └── dim_customers.csv
└── 📷 screenshots/                    # Dashboard preview images
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL** | Data extraction from relational database |
| **Python (NLP)** | Sentiment Analysis on customer reviews |
| **Power Query** | Data transformation & shaping |
| **DAX** | KPI measures, Time Intelligence & dynamic formatting |
| **Power BI Desktop** | Dashboard design & visualization |

---

## 🔄 Data Pipeline

```
Relational Database
      │
      ▼
SQL Queries (Extract raw data)
      │
      ▼
Python NLP (Sentiment Analysis on reviews)
      │
      ▼
Power Query (Clean, transform & load)
      │
      ▼
Star Schema Data Model
      │
      ▼
DAX Measures (KPIs, YoY, LY, dynamic formatting)
      │
      ▼
Power BI Interactive Dashboard (5 pages)
```

---

## 🐍 Python — Sentiment Analysis

Customer reviews were classified into **5 sentiment categories** using Python NLP:

| Category | Count | % |
|---|---|---|
| Positive | 275 | 61.7% |
| Negative | 82 | 18.4% |
| Mixed Negative | 60 | 13.5% |
| Mixed Positive | 21 | 4.7% |
| Neutral | 8 | 1.8% |

```python
# Example: Sentiment classification pipeline
from textblob import TextBlob  # or transformers-based model

def classify_sentiment(text):
    polarity = TextBlob(text).sentiment.polarity
    if polarity > 0.3:
        return "Positive"
    elif polarity > 0:
        return "Mixed Positive"
    elif polarity == 0:
        return "Neutral"
    elif polarity > -0.3:
        return "Mixed Negative"
    else:
        return "Negative"
```

---

## 📐 Data Model — Star Schema

```
                    ┌─────────────────┐
                    │  dim_products   │
                    │  - ProductID    │
                    │  - ProductName  │
                    │  - Category     │
                    └────────┬────────┘
                             │
┌──────────────┐    ┌────────▼────────┐    ┌─────────────────┐
│ dim_customers│    │  fact_journey   │    │ fact_engagement  │
│ - CustomerID │◄───│  - CustomerID   │    │ - ProductID      │
│ - Country    │    │  - ProductID    │    │ - ContentType    │
│ - Segment    │    │  - JourneyStage │    │ - Views          │
└──────────────┘    │  - Action       │    │ - Clicks         │
                    │  - Date         │    │ - Likes          │
                    └─────────────────┘    │ - Date           │
                                           └─────────────────┘
                    ┌─────────────────┐
                    │  fact_reviews   │
                    │ - CustomerID    │
                    │ - ProductID     │
                    │ - ReviewText    │
                    │ - Rating        │
                    │ - SentimentCat  │
                    │ - ReviewDate    │
                    └─────────────────┘
                    ┌─────────────────┐
                    │    Calendar     │
                    │ - Date          │
                    │ - Month         │
                    │ - MonthName     │
                    │ - Year          │
                    │ - Quarter       │
                    └─────────────────┘
```

All measures are stored in a dedicated **`_Calculations`** table — a best practice that keeps the model clean and organized.

---

## 📊 DAX Measures

### Core KPIs
```dax
-- Conversion Rate
Conversion Rate = 
DIVIDE(
    CALCULATE(COUNTROWS(fact_journey), fact_journey[Action] = "Purchase"),
    COUNTROWS(fact_journey)
)

-- Clicks
Clicks = SUM(fact_engagement[Clicks])

-- Likes
Likes = SUM(fact_engagement[Likes])

-- Views
Views = SUM(fact_engagement[Views])

-- Rating (Average)
Rating (Average) = AVERAGE(fact_reviews[Rating])

-- Number of Campaigns
Number of Campaigns = DISTINCTCOUNT(fact_engagement[CampaignID])

-- Number of Reviews
Number of Reviews = COUNTROWS(fact_reviews)

-- Number of Customer Journey
Number of Customer Journey = COUNTROWS(fact_journey)
```

### Time Intelligence
```dax
-- Conversion Rate Last Year
Conversion Rate LY = 
CALCULATE([Conversion Rate], SAMEPERIODLASTYEAR(Calendar[Date]))

-- Conversion Rate Year-over-Year %
Conversion Rate YoY % = 
DIVIDE([Conversion Rate] - [Conversion Rate LY], [Conversion Rate LY])
```

### Dynamic Formatting
```dax
-- Color FX (Green if improving, Red if declining)
Color FX = IF([Conversion Rate] > [Conversion Rate LY], 1, 0)

-- YoY Icon with Arrow
CON YoY Icon = 
IF(
    [Conversion Rate] > [Conversion Rate LY],
    UNICHAR(9650) & " " & FORMAT([Conversion Rate YoY %], "0.00%"),
    UNICHAR(9660) & " " & FORMAT([Conversion Rate YoY %], "0.00%")
)
```

---

## 📄 Dashboard Pages

### 🏠 Home Page
Professional landing page featuring:
- ShopEasy logo & branding
- Project tagline: *"Turning data into insights. Driving growth for ShopEasy."*
- Navigation buttons to all 4 report sections with icons and descriptions

---

### 📊 Overview Page
High-level marketing performance summary:

**KPI Cards:**
| KPI | Value |
|---|---|
| Conversion Rate | 8.48% |
| Clicks | 458.35K |
| Likes | 74K |
| Views | 2.98M |
| AVG Rating | 3.67 ⭐ |

**Visuals:**
- 📈 **Likes, Clicks and Views by Month** — Line chart tracking engagement trends across the year
- 📈 **Conversion Rate by Month** — Area chart showing monthly conversion fluctuations. January peaked at **19.61%**
- 📊 **Views, Clicks and Likes** — Horizontal bar chart showing the proportional scale between channels (Views dominate at 2.98M)
- 📊 **Conversion Rate by Product** — Bar chart ranking products. **Ski Boots (20.69%)** and **Kayak (17.86%)** lead conversion
- 📉 **Rating by Month** — Line chart tracking average rating trend across the year (range: 3.48 – 3.97)
- 📊 **Rating by Product** — Bar chart ranking products by AVG rating. **Football Helmet leads at 4.13**

---

### 🔄 Conversion Details Page
Deep-dive into conversion funnel performance:

**KPI Cards:**
- Conversion Rate: **8.48%**
- YoY Change: **▼ -26.76%** (dynamic arrow + color)

**Visuals:**
- 📊 **Number of Customer Journey by Action** — Funnel-style bar chart showing drop-off across stages: View (672) → Click (355) → Drop-off (185) → Purchase (57)
- 📈 **Conversion Rate by Month** — Line chart with data labels
- 🗂️ **Conversion Rate Matrix** — Table showing Conversion Rate per product per month with totals

**Slicers:** Product Name, Year, Month

---

### 📱 Social Media Details Page
Social media engagement breakdown:

**KPI Cards:**
- Clicks: 458K
- Likes: 74K
- Views: 2.98M

**Visuals:**
- 📊 **Views by Month and Content Type** — Grouped bar chart comparing BLOG vs SOCIAL MEDIA vs VIDEO performance monthly
- 📈 **Clicks, Likes and Views by Month** — Multi-line trend chart
- 📊 **Views, Clicks and Likes** — 100% stacked bar showing channel proportions
- 🗂️ **Views By Product Name and Month** — Detailed matrix with monthly breakdown per product. **Total: 2,982,369 views**

---

### ⭐ Customer Reviews Details Page
Sentiment and review analysis:

**KPI:** AVG Rating: **3.67**

**Visuals:**
- 📊 **Rating by Month and Sentiment Category** — Grouped bar chart with 5 color-coded sentiment categories
- 🗂️ **Reviews Table** — Full review log with: Date, CustomerID, ReviewText, Rating, SentimentCategory
- 📊 **Number of Reviews by Sentiment** — Bar chart. Positive (275) dominates, Negative (82) is second
- 🍩 **Number of Reviews by Rating** — Donut chart. Rating 4 leads (140 reviews / 31.39%), Rating 1 is lowest (57 / 12.78%)

**Slicers:** Product Name, Year, Month, Country, Sentiment Category

---

## 💡 Key Insights

- ⚠️ **Conversion Rate dropped -26.76% YoY** — January was the peak month at 19.61%, followed by a sharp decline
- 🏆 **Ski Boots and Kayak** are the top-converting products at 20.69% and 17.86% respectively
- 📉 **Massive funnel drop-off**: 672 views → only 57 purchases — less than 10% complete the journey
- 👍 **61.7% of reviews are Positive** — strong overall sentiment, but 18.4% Negative reviews need attention
- 🎥 **VIDEO content drives the most views** across all months on social media
- ⭐ **Football Helmet has the highest AVG rating (4.13)**, while Climbing Rope has the lowest (3.65)
- 📊 **2.98M total social media views** with Clicks at only 458K — engagement-to-click ratio needs improvement

---

## 🎨 Design Decisions

- **Purple/blue color scheme** for a clean, modern marketing feel
- **Dedicated `_Calculations` table** for all DAX measures — keeps the model organized and scalable
- **Dynamic YoY arrow icons (▲▼)** with conditional color formatting for instant visual feedback
- **Sentiment Analysis via Python** instead of manual tagging — scalable and objective
- **Star Schema** instead of a flat table — ensures fast query performance and proper relationships
- **Problem definition report written first** — ensures the dashboard answers real business questions, not just displays data

---

## 🚀 How to Use

1. Clone this repository
2. Run `sentiment_analysis.py` to generate the sentiment-labeled reviews file
3. Execute SQL queries in `/queries/` to extract the latest data
4. Open `ShopEasy_Marketing.pbix` in **Power BI Desktop**
5. Refresh the data source if prompted
6. Use **slicers** on each page to filter by Product, Year, Month, Country, or Sentiment
7. Click **navigation buttons** on the Home Page to move between sections

---

## 📬 Contact
**Ahmed Salama**
*Data Scientist*
- 💼 [LinkedIn Profile](https://www.linkedin.com/in/ahmedsalamaa00/)
- 🐙 [GitHub Profile](https://github.com/ahmedsalama00) 
- 👤 [Portfolio](https://ahmedsalama00.github.io/Ahmed)

---

*If you found this project useful, feel free to ⭐ star the repository!*
