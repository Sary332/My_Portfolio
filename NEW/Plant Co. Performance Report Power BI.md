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

<br>

#### The Core Business Question It Tries to Answer: 

<br>

> **“What are the key drivers behind the changes in Gross Profit, Sales, or Quantity, and which countries, products, or customers are helping or hurting our performance compared to last year?”**

 <br>

### ✅ How This Helps:

The dashboard enables the business to:

* **Quickly detect issues** (e.g., declining profit in specific countries or products).
* **Analyze variance drivers** (drill from Month → Country → Product to find root causes).
* **Make informed strategic decisions** (e.g., adjust pricing, focus on high-margin products, reduce exposure to unprofitable markets).
* Transition from **reactive** to **proactive** performance management.

<br>


## What Kind of Insight It Brings ?

<details>
  <summary>GROSS PROFIT 2023–2024</summary>
  
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


### ✨Actionable Key Takeaways✨
- **Maintain margins** — control pricing & costs.  
- **Drive volume** — future Gross Profit growth hinges on account & key market penetration.  
- **Focus on Outdoor** — clear opportunities for strengthening sales in this product.  
- **Strengthen market strategy** — address declines in major countries, scale up in positive ones.  
- **Ensure monthly consistency** — avoid performance volatility with a more stable sales pipeline.

  <br>
  
</details>

<details>
  <summary>QUANTITY 2023–2024</summary>


### ✅ General Performance (YTD vs PYTD)

| Year | YTD Quantity | PYTD Quantity | Difference | Growth | GP%    |
| ---- | ------------ | ------------- | ---------- | ------ | ------ |
| 2023 | 555.66K      | 538.61K       | +17.05K    | +3.2%  | 39.62% |
| 2024 | 148.47K      | 160.84K       | -12.37K    | -7.7%  | 39.15% |

📌 **Insight:**

* 2023 showed **positive growth** in quantity with healthy profitability.
* 2024 experienced a **notable decline** in volume while maintaining stable GP%, indicating resilience in pricing or cost control.

🎯 **Recommendation:**

* Explore root causes of 2024 volume drop, especially in Q2.
* Maintain cost control to protect margins while rebuilding volume.

<br>

### ✅ Country-Level Breakdown

#### 📉 Top Contributors to Quantity Decline

* **2023:** 🇨🇳 China (-9.76K), 🇫🇷 France (-9.36K), 🇪🇸 Spain (-6.7K)
* **2024:** 🇨🇦 Canada (-5.42K), 🇺🇸 US (-2.45K), 🇭🇺 Hungary, 🇭🇷 Croatia, 🇨🇮 Ivory Coast

#### 📈 Countries with Quantity Growth

* **2023:** 🇸🇦 Saudi Arabia (+11.5K), 🇶🇦 Qatar (+6.7K), 🇨🇴 Colombia (+4.4K)
* **2024:** 🇵🇹 Portugal (+4.1K), 🇹🇭 Thailand (+2.7K), 🇬🇧 UK (+0.6K)

📌 **Insight:**

* Consistent underperformance in major markets like China and Canada impacted overall performance.
* Middle Eastern and Southeast Asian countries show **growth potential**.

🎯 **Recommendation:**

* Deep dive into top-declining markets to fix structural or operational issues.
* Double down on growing regions through local campaigns and distribution partnerships.

<br>

### ✅ Product-Type Breakdown

| Product Type | 2023 Delta | 2024 Delta |
| ------------ | ---------- | ---------- |
| Outdoor      | +24.8K     | -4.1K      |
| Indoor       | -4.7K      | -6.6K      |
| Landscape    | -3.1K      | -1.6K      |

📌 **Insight:**

* **2023:** Outdoor was the **key growth driver**.
* **2024:** All categories declined, with Indoor being the biggest drag.

🎯 **Recommendation:**

* Reevaluate Indoor product strategy: product relevance, pricing, and channel effectiveness.
* Consider targeted relaunch or bundled offers.

<br>

### ✅ Monthly & Quarterly Quantity Trends

#### 2023:

* **Growth Months:** April (+12K), June (+13K)
* **Drop Months:** July (-7K), September (-8K)
* **Best Quarter:** Q2 (157.06K)

#### 2024:

* **Growth Month:** February (+8.2K)
* **Drop Months:** March (-11.6K), April (-9.4K)
* **Worst Quarter:** Q2 (only 18.2K YTD)

📌 **Insight:**

* 2023 showed consistent Q2 performance; 2024 saw sharp early Q2 declines.

🎯 **Recommendation:**

* Reapply Q2 2023 strategies to reverse early-year slumps in 2024.
* Audit March-April campaigns, operations, and market conditions.

<br>

### ✅ Account Profitability Segmentation (Scatter Plot)

📌 **Insight:**

* In both years, many accounts reside in the **low quantity – low GP%** quadrant → potentially unprofitable.
* Some accounts show **low quantity – high GP%**, representing potential for **upselling**.

🎯 **Recommendation:**

* Segment customer base:

  * Focus on profitable accounts with sales potential.
  * Review pricing strategy or cost-to-serve for unprofitable segments.

<br> 

### ⛳ Strategies

| Focus Area   | Key Insight & Recommendation                                                                |
| ------------ | ------------------------------------------------------------------------------------------- |
| Country      | Investigate large drops (China, Canada); scale success in Portugal, Thailand, Saudi Arabia. |
| Product Type | Reboot Indoor strategy; maintain Outdoor relevance.                                         |
| Time Period  | Leverage Q2 seasonal strength from 2023; resolve Q2 2024 downturn immediately.              |
| Account Mgmt | Optimize around profitability, identify upsell opportunities in high GP% segments.          |

<br>

</details>



<details>
  <summary>SALES 2023–2024</summary>


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


<br>
</details>



## How I Build This

<details>
  <summary>DATA CLEANING</summary>
    
<br>
    
Minimal transformation was applied during this phase. I renamed tables for clarity (e.g., fact_sales, dim_account, dim_product) to distinguish 
fact and dimension tables. I removed duplicates (if any) based on unique identifiers like Account_ID and Product_Name_ID. Lastly, I reviewed and 
validated data types across all columns to ensure consistency and accuracy.

</details>


<details>
  <summary>DATA MODELING</summary> 

 <br>

The data model was designed using a star schema approach, with a clearly defined fact table and multiple dimension tables. Here's how I structured it:

#### 1️⃣ Date Dimension Table (`dim_date`)
   I created a custom date table using the following DAX formula:

   ```DAX
   Dim_Date = CALENDAR(DATE(2022,01,01), DATE(2024,12,31))
   ```
   After creation, I checked for and implemented hierarchy levels (e.g., Year, Quarter, Month) to support time-based analysis.

<br>

#### 2️⃣ InPast Column for Time Intelligence
   In the `dim_date` table, I added a calculated column named `InPast` using this DAX formula:

   ```DAX
   Inpast = 
   VAR lastsalesdate = MAX(Fact_Sales[Date_Time])
   VAR lastsalesdatePY = EDATE(lastsalesdate, -12)
   RETURN
   Dim_Date[Date] <= lastsalesdatePY
   ```

   This column returns a `TRUE/FALSE` value, and is especially useful when performing prior year or month comparisons—helping prevent
   blank result errors during time intelligence operations.
   
<br>

#### 3️⃣ Relationship Definition
   I defined **one-to-many relationships** between the `fact_sales` table and its related dimension tables (such as `dim_account`, `dim_product`, and `dim_date`)
   based on unique identifiers. This ensures referential integrity and enables accurate filtering across visuals.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2500ba60-3d82-418f-a818-bf2e30924a4a" alt="Data Model Diagram" width="500">
</p>

<br>

#### 4️⃣ Slicer Table (`slc_values`)
   I created a small static table using *Enter Data*, containing three values: `Gross Profit`, `Quantity`, and `Sales`.
   This table, named `slc_values`, is used as a slicer input to control dynamic filtering and toggle the metrics displayed across visuals.

<br>

#### 5️⃣ **DAX Measures :

* **Base Measures**
  Fundamental calculations that act as building blocks for more advanced measures.
  Includes:

  * `Gross Profit`
  * `Sales`
  * `Quantity`
  * `COGS` (Cost of Goods Sold)
  * `GP%` (Gross Profit Percentage)



* **PYTD (Prior Year-to-Date)**
  Measures used to calculate Prior Year-to-Date values for key metrics, enabling year-over-year performance comparison.
  Includes:

  * `PYTD_Gross Profit`
  * `PYTD_Sales`
  * `PYTD_Quantity`



* **YTD (Year-to-Date)**
  Measures used to calculate Year-to-Date values for Gross Profit, Sales, and Quantity, supporting cumulative performance tracking.
  Includes:

  * `YTD_Gross Profit`
  * `YTD_Sales`
  * `YTD_Quantity`


* **SWITCH Logic**
  Dynamic measures that allow switching between YTD, PYTD, and their comparisons based on user selection. These measures enable interactive dashboards that respond to user input.
  Includes:

  * `Switch YTD`
  * `Switch PYTD`
  * `YTD vs PYTD`



* **Dynamic Titles**
  Measures that dynamically adjust the titles of charts and reports based on the selected metric or time frame, ensuring clear and contextual information in the visuals.
  Includes:

  * `Column Chart Title`
  * `Report Title`
  * `Scatter Title`
  * `Waterfall Title`


</details>

<details>
  <summary>DATA VISUALIZATION</summary>

### >> KPI Card 

<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/8a0d5e9c-1a27-4d92-b46e-9ed80ca0cdb1" width="450">
</p>


1️⃣ **Purpose**

The KPI Card is used to provide a **quick summary of business performance**. This visualization displays the **total Year-to-Date (YTD) value**, comparison with Previous Year-to-Date (PYTD), and Gross Profit Margin (**GP%**) in one view. The purpose is to **enable users to instantly understand the business condition** without needing further exploration.

2️⃣ **Data Used**

* **Measures**:

  * `Value YTD`
  * `Value PYTD`
  * `Delta YTD vs PYTD`
  * `GP%`

3️⃣ **Reason for Choosing this Visualization**
    The KPI Card is chosen because:

* It provides a **focus on key numbers**.
* It allows users to **quickly see the YoY change**.
* It is effective for **opening the dashboard as an executive summary**.

<br>

### >> Treemap – Bottom 10 Countries by YTD vs PYTD Sales

<p align="center">
  <img src="https://github.com/user-attachments/assets/ae8edc0f-fdaf-49ba-99e3-4b0e83f5d50c" width="200">
</p>
                   

1️⃣ Purpose
This Treemap visualization illustrates the **bottom 10 countries** contributing to the **YTD vs PYTD sales decline**. It aims to highlight 
**countries that have seen the largest reductions** in sales compared to the previous year, allowing users to easily identify underperforming markets.

2️⃣ **Data Used**

* **Measures**:
  * `Delta YTD vs PYTD`
    
3️⃣ **Reason for Choosing this Visualization**
    A **Treemap** was chosen because:

* It provides a **clear, comparative view** of multiple countries at once.
* It effectively displays **proportional data**: the size of each country’s block correlates to the magnitude of the sales decline.
* This is ideal for showcasing the **relative size of declines across countries** without overwhelming the viewer.

<br>

### >> Waterfall Chart – Gross Profit YTD vs PYTD by Month, Country, and Product

<p align="center">
  <img src="https://github.com/user-attachments/assets/498f1da9-10d0-4527-a068-693af9eae806" width="200">
</p>


1️⃣ **Purpose**

This **Waterfall Chart** tracks the selected metric performance, broken down by **Month**, **Country**, and **Product**. The chart shows both the **increase** and **decrease** for each period, helping identify which months or factors (e.g., countries or products) contributed the most to the total performance.

2️⃣ **Data Used**

* **Measures**:

  * `Delta YTD vs PYTD`
  * `Month`, `Country`, `Product_Type`, `Product_Name`: Dimensions used to Drill-Down/Up the performance.

3️⃣ **Reason for Choosing this Visualization**

A **Waterfall Chart** was chosen because:

* It provides an excellent way to **visualize step-by-step changes** in the selected values over time.
* The **increase and decrease** are shown clearly, helping identify specific months with significant changes.
* This format is easy to read and shows cumulative effects, which is perfect for analyzing performance over time.


<br>

### >> Line and Stacked Column Chart – Gross Profit YTD & PYTD by Month

<p align="center">
  <img src="https://github.com/user-attachments/assets/a1da99a6-13e8-4717-9e7f-8111740041a5" width="400">
</p>


1️⃣ **Purpose**
This **Line and Stacked Column Chart** tracks the **Selected Metric YTD & PYTD** by **Month**, broken down by **Product Type** (Indoor, Landscape, Outdoor). The stacked column shows the monthly Selected Metric values for each product type, while the line chart represents the **Value PYTD** (Prior Year to Date), allowing comparisons of this year’s and last year’s performance.

2️⃣ **Data Used**

* **Measures**:

  * `Value_YTD`
  * `Value_PYTD`
  * `Month`, `Quarter`, `Product Type`: Dimensions used for performance breakdowns.

3️⃣ **Reason for Choosing this Visualization**

A **Line and Stacked Column Chart** was chosen because:

* It clearly **visualizes trends over time**, with both the **cumulative values** (via stacked columns) and **comparisons with last year** (via the line chart).
* The combination of a stacked column and line allows **multiple layers of data** to be presented in on view, making it easier to compare different product types and years.


<br>


### >> Scatter Plot – Account Profitability Segmentation by Month 

<p align="center">
  <img src="https://github.com/user-attachments/assets/af30aeb5-53d4-4117-9dff-74b35f147d67" width="400">
</p>


1️⃣ **Purpose**

This **scatter plot** visualizes the relationship between **Selected Metric** and **YTD Value** across different accounts. It segments the accounts based on their **profitability**, with the goal of identifying **high-value, high-margin accounts** (top right quadrant) and **low-margin accounts** (bottom left quadrant).

2️⃣ **Data Used**

* **Measures**:

  * `Selected Metric`
  * `Value_YTD`

3️⃣ **Interactivity**

* **Zoom Slider**: Allowing users to zoom in and out on the scatter plot to examine specific clusters of data and focus on a narrower range of values. This enables a more detailed view of accounts based on their Selected Metric and profitability.

4️⃣ **Reason for Choosing this Visualization**

A **scatter plot** was selected because:

* It effectively **shows distribution** and **correlations** between two continuous variables (Selected Metric and Sales Value).
* The quadrants dynamically adjust based on the selected metric, enabling users to focus on different aspects of account performance
  and profitability.


</details>


<br>

## Challenge That I Faced
