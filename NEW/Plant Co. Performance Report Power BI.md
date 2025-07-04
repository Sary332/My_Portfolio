##  What The Dashboard is About ?
This Power BI dashboard provides an interactive overview of **Plant & Co.’s performance metrics (Gross Profit, Sales, and Quantity)** for the years **2023 and 2024**.

The dashboard is designed to:

✅ **Monitor Year-to-Date (YTD) performance** against Prior Year-to-Date (PYTD) benchmarks.

✅ **Analyze country, product, and account-level contributions** to overall business results.

✅ **Identify trends and underperforming areas** using dynamic visualizations.

Key features include:

* **Metric Switcher (Gross Profit, Sales, Quantity):** Allows users to toggle between KPIs, automatically updating all visuals and titles.
* **Year Filter:** Enables selection of 2023 or 2024 data.
* **Performance Indicators:** Shows YTD, PYTD, variance (YTD vs PYTD), and GP% (Gross Profit Margin).
* **Key Features :**

  * Treemap of Bottom 10 Countries: Highlights underperformers with negative variance.
  * Explore performance variance using a drillable waterfall chart (Month → Country → Product).
  * Trend Chart by Month and Product Type: Stacked column chart (Indoor, Outdoor, Landscape) with PYTD line overlay.
  * Scatter Plot Account Segmentation
  * DAX Measures: Custom calculations for dynamic metric switching and variance analysis.

This dashboard empowers stakeholders to quickly assess financial health, investigate key drivers of performance, and make informed business decisions.

<br>

## What the Problem It Tries to Solve ?
In the business context, the dashboard addresses these key challenges:

1. **Unexplained Variance in Performance:**

   * Management notices that Gross Profit, Sales, or Quantity fluctuates across months or years, but lacks clarity on **why**.
   * There is no easy way to break down and attribute these variances to specific **countries, products, or accounts**.

2. **Identifying Underperforming Areas:**

   * Some countries, product lines, or customer accounts may consistently drag down overall performance.
   * Without visibility, underperforming segments go unnoticed until quarterly or annual reviews, which is too late for corrective action.

3. **Prioritizing Business Actions:**

   * The business needs to know **where to focus sales or cost optimization efforts**—whether at the market level (Country), product level, or customer level.
   * Decision-makers require a **clear picture of which areas are driving growth and which are eroding margins**.


### The Core Business Question It Tries to Answer:

> **“What are the key drivers behind the changes in Gross Profit, Sales, or Quantity, and which countries, products, or customers are helping or hurting our performance compared to last year?”**


### ✅ How This Helps:

The dashboard enables the business to:

* **Quickly detect issues** (e.g., declining profit in specific countries or products).
* **Analyze variance drivers** (drill from Month → Country → Product to find root causes).
* **Make informed strategic decisions** (e.g., adjust pricing, focus on high-margin products, reduce exposure to unprofitable markets).
* Transition from **reactive** to **proactive** performance management.

<br>


## What Kind of Insight It Brings ?

<details>
  <summary>Gross Profit 2023–2024</summary>
  
### ✅ Overall KPI Highlights
> Overall, total Gross Profit (YTD) dropped from 5.15M in 2023 to 1.40M in 2024 for the same period. However, the YTD vs PYTD gap improved
  significantly from -265K to -78K, indicating that the downward trend has been successfully mitigated. Gross Profit Margin remained relatively
  stable at around 39%, showing that margin structure is well maintained.


### ✅ Monthly Trend
> Monthly trends show sharp fluctuations. In 2023, declines were consistent in Q4, while in 2024 there was a positive spike in February (+117K)
  before declining again in March–April. This highlights the need for a more consistent month-on-month improvement momentum going forward.


### ✅ Product Type Performance
> Outdoor products continue to support growth amid weaknesses in Indoor & Landscape. In 2024, Outdoor recorded a net +44K while other products declined.  
  This signals an opportunity to expand Outdoor’s market share in the right segments.


### ✅ Country Breakdown
> Country analysis shows that some major contributors dropped sharply, such as Canada (-41K), Germany (-25K), and Japan (-19K). Conversely, markets
  like Poland, Qatar, and Thailand posted positive growth, albeit on a smaller scale.  
> **Recommendation**: strengthen strategies in declining markets and scale up in growing ones.”


### ✅ Account Segmentation
> The profitability segmentation scatter plot illustrates where accounts sit in terms of value (YTD sales) and profitability (GP%). Most accounts
  remain clustered in the Low Value–Low GP% quadrant, highlighting a concentration of lower-contributing accounts. A few accounts are beginning to
  shift toward higher GP% areas, though their overall value is still modest. This segmentation helps visualize opportunities for prioritization—accounts
  with high GP% but lower volumes could be targeted with up-sell and cross-sell strategies to move them into the High Value–High GP% quadrant.


### ✅ Slide 6 — Actionable Key Takeaways
- ✔️ **Maintain margins** — control pricing & costs.  
- ✔️ **Drive volume** — future Gross Profit growth hinges on account & key market penetration.  
- ✔️ **Focus on Outdoor** — clear opportunities for strengthening sales in this product.  
- ✔️ **Strengthen market strategy** — address declines in major countries, scale up in positive ones.  
- ✔️ **Ensure monthly consistency** — avoid performance volatility with a more stable sales pipeline.

  
</details>

<details>
  <summary>Quantity 2023–2024</summary>


### ✅ Key KPIs Comparison

| KPI              | 2023        | 2024        | Change       |
|------------------|-------------|-------------|--------------|
| Quantity YTD     | 555.66K     | 148.47K     | ▼ -407.19K * |
| PYTD             | 538.61K     | 160.84K     |              |
| YTD vs PYTD      | +17.05K     | -12.37K     | ▼ -29.42K    |
| Gross Profit %   | 39.62%      | 39.15%      | ≈ Stable     |

> *The large quantity gap is likely due to slicers filtering different product segments.

<br>

### ✅ Monthly Trend & Quarterly Highlights

| Period        | 2023           | 2024           | Insight                                 |
|---------------|----------------|----------------|-----------------------------------------|
| Q1            | Strong start   | Strong start   | Comparable performance                  |
| Q2            | +30K growth    | -30K decline   | Major driver of YoY quantity drop       |
| April (MoM)   | +12K           | -9.4K          | Sharp reversal                          |
| June (MoM)    | +13K           | N/A            | Lost growth momentum                    |

>  **Insight**: Q2 2024 is a critical turning point and requires immediate investigation.

<br>

### ✅ Country-Level Insights

| Country        | 2023 (Δ Qty) | 2024 (Δ Qty) | Notes                                  |
|----------------|--------------|--------------|----------------------------------------|
| China          | -9.76K       | N/A          | Sharp decline in 2023                  |
| France         | -9.36K       | N/A          | Same as China                          |
| Canada         | +3K →        | -5.42K ↓     | Major reversal                         |
| US             | +1.5K →      | -2.45K ↓     | Decline in 2024                        |
| Saudi Arabia   | +11.5K ↑     | N/A          | Key driver in 2023                     |
| Portugal       | N/A          | +4.1K ↑      | Growth area in 2024                    |

<br>

### ✅ Product Performance

| Product Type | 2023 (Δ Qty) | 2024 (Δ Qty) | Insights                                |
|--------------|--------------|--------------|-----------------------------------------|
| Outdoor      | +24.8K ↑     | -4.1K ↓      | Lost key momentum                       |
| Indoor       | -4.7K ↓      | -6.6K ↓      | Consistent underperformance             |
| Landscape    | -3.1K ↓      | -1.6K ↓      | Needs evaluation for relevance          |

<br>

### ✅ Account Profitability (Scatter Chart)

- Accounts in **low quantity, high GP%**: strong **upsell potential**.
- Accounts in **high quantity, low GP%**: may need **pricing review or cost control**.
- Many accounts sit in **low quantity, low GP%** quadrant → target for cleanup or repricing.

<br>

### ✅ Strategic Insights

1. **Q2 2024 Drop Is the Key Issue**  
   Sharp declines in March–April must be investigated and addressed.

2. **Shift in Country Performance**  
   - Canada & US shifted from contributors (2023) to decliners (2024).
   - Markets like Portugal and Saudi Arabia offer growth benchmarks.

3. **Indoor Products Need Attention**  
   Downtrend in both years indicates a need for strategy refresh (bundling, rebranding, promo).

4. **Profitability vs. Volume Trade-off**  
   Despite quantity drop, GP% stayed high → good margin control but possible market share loss.

<br>

### 📍 Recommended Actions

| Focus Area          | Action                                                   |
|---------------------|----------------------------------------------------------|
| Q2 Turnaround       | Investigate sales campaigns, supply chain, seasonality   |
| Market Re-entry     | Rebuild presence in Canada & US                          |
| Product Innovation  | Relaunch or reposition Indoor products                   |
| Account Segmentation| Upsell high-margin, low-volume clients                   |
| Efficiency Drive    | Exit or price-adjust low GP%, low quantity accounts      |


</details>



<details>
  <summary>Sales 2023–2024</summary>


### ✅ Overall Performance (YTD vs PYTD)

| Year | YTD Sales | PYTD Sales | Difference | Growth (%) | GP%    |
| ---- | --------- | ---------- | ---------- | ---------- | ------ |
| 2023 | 13.00M    | 13.51M     | -512K      | -3.8%      | 39.62% |
| 2024 | 3.57M     | 3.71M      | -136K      | -3.7%      | 39.15% |

⛳ **Insight:**

* Both years show **YoY decline in sales**, though **profit margins remain stable**.
* Indicates that **margin efficiency is intact**, but **sales volume needs improvement**.
  
 <br>

### ✅ Country-Level Breakdown

####  Top Declining Countries

* **2023**: 🇨🇳 China (-760K), 🇸🇪 Sweden (-240K), 🇫🇷 France (-150K)
* **2024**: 🇨🇦 Canada (-74K), 🇨🇴 Colombia (-61K), 🇩🇪 Germany (-41K)

#### Countries with Positive Growth

* **2023**: 🇸🇦 Saudi Arabia, 🇵🇭 Philippines, 🇵🇹 Portugal
* **2024**: 🇹🇭 Thailand, 🇵🇭 Philippines, 🇬🇧 United Kingdom

⛳ **Insight:**

* Major contributors to decline include **China, Canada, Colombia, and Germany**.
* **Southeast Asia and Middle East markets** are expanding → consider **marketing and distribution focus** here.

<br>

### ✅ Product-Type Breakdown

| Product Type | 2023 (Delta) | 2024 (Delta) |
| ------------ | ------------ | ------------ |
| Indoor       | -490K        | -145K        |
| Landscape    | -110K        | -118K        |
| Outdoor      | +100K        | +128K        |

⛳ **Insight:**

* **Outdoor** is the **only consistently growing category** across both years.
* Decline in **Indoor and Landscape** suggests **shifting customer preferences**.
  

🎯 **Recommendations:**

* Prioritize **marketing and development for Outdoor** category.
* Evaluate positioning and relevance of Indoor and Landscape products.

<br>

### ✅ Monthly & Quarterly Trends

#### 2023:

* Sharp decline in **Q1 (Feb)** and **Q4 (Oct–Nov)**.
* **Q2 (Apr–Jun)** was the strongest quarter.

#### 2024:

* **February showed positive growth**, but **March and April dropped significantly**.

⛳ **Insight:**

* **Strong seasonality observed**.
* **Q2 is a performance driver**, yet 2024 shows a worrying post-February trend.

🎯 **Recommendations:**

* **Replicate 2023 Q2 success strategies across other quarters**.
* Urgently assess **Q2 2024** performance drivers to avoid continued decline.

<br>

### ✅ Account Profitability Segmentation (Scatter Plot)

⛳ **Insight:**

* Several large accounts deliver **high sales but low GP%** → risky profile.
* Small accounts with **high GP%** offer **upsell opportunities**.
* 2024 shows **slightly better spread**, but many accounts remain in the unprofitable zone.

🎯 **Recommendations:**

* **Resegment the customer base**:

  * Focus acquisition efforts on **small to mid-sized accounts with healthy margins**.
  * Apply **churn management or renegotiate margins** for large low-GP accounts.


#### ✨ Strategic Summary

| Focus Area           | Key Insight & Recommendations                                                                                    |
| -------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Geography**        | Audit underperforming markets (China, Canada). Redirect resources to growing regions (Thailand, Saudi, PH)       |
| **Product**          | Outdoor = primary growth engine. Indoor & Landscape need repositioning or innovation                             |
| **Quarter Planning** | Q2 = key momentum driver. Needs replication and stronger campaign planning for Q3 and Q4                         |
| **Customer Account** | Prioritize profitable clients. Reevaluate high-volume low-margin accounts. Implement customer tiering strategies |

---

### ✨General Recommendations :✨

1. **Urgent Q2 2024 Action**:

   * Audit marketing campaigns, sales performance, and supply chain conditions.

2. **Market Realignment**:

   * Shift marketing budget to countries with positive trends.

3. **Product-Level Strategy**:

   * Launch special promos and bundles for Outdoor.
   * Reevaluate Indoor product relevance and positioning.

4. **Account Management**:

   * Prioritize accounts with healthy GP%.
   * Implement upselling in high-GP, low-volume segments.



</details>



    
## How I Build This

## Challenge That I Faced
