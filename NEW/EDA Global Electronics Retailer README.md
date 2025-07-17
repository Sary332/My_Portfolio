
# Global Electronics Retailer Analysis
[View Dataset Here](https://app.mavenanalytics.io/datasets?dataStructure=Multiple+tables&tag=Retail)

This project explores the company’s sales, product, and logistics data over a multi-year period to uncover patterns in customer behavior, seasonal trends, and operational performance. The findings are not just numbers—they reveal a story of growth, challenges, and opportunities.

<br>

## Query types used:

- Date Functions ( Datepart, Datediff)
- Aggregate Functions
- Frame Clause
- Offset Functions
- Chained CTEs
- Joins 
- Case When
- Windows Function
- Subquery


## Analysis Questions :

### 1. What types of products does the company sell, and where are customers located ?

### 2. Are there any seasonal patterns or trends for order volume or revenue ?
   - Purchase Trends by Country During Holiday / Big Celebration Months
   - Seasonal/Quarterly Breakdown Analysis

### 3. Holiday Season Product Analysis

### 4. How long is the average delivery time in days? Has that changed over time ?
   - Calculate shipping time for online store orders
   - Calculate average shipping time by year/month for online store
   - Year-over-Year Delivery Time Trend Analysis

### 5. Products Analysis
   - Popular Product Analysis by Country
   - Cross-Selling Analysis
   - AOV (Average Order Value) Analysis



<br><br>

## Project Insights :

### 🛍️ 1. Understanding the Products and Customers

The company’s product portfolio is diverse, spanning **seven major categories**:

* TV and Video
* Audio Devices
* Home Appliances
* Computers
* Cell Phones
* Games & Toys
* Cameras and Audio Books

Its customer base is global, with **a strong presence in Europe and North America**. The **United Kingdom (288 regions)** and **United States (51 regions)** stand out as key markets. Countries like **Italy (98 regions)** and **Germany (16 regions)** also contribute significantly.

This geographic spread shows the brand’s ability to penetrate both mature and emerging markets.

---

### 📅 2. Do Seasons Shape Sales Patterns?

#### >>> 📈 Seasonal Peaks

The data reveals a clear pattern:

* Orders and revenue **peak in late December and early January**—driven by **Christmas and New Year celebrations**.
* Secondary spikes appear in February (Valentine’s Day) and October-November (Thanksgiving in the US and Canada).

From 2016–2019, these trends remained **remarkably consistent**, highlighting predictable demand cycles.

#### >>> 🛑 2020: A Disrupted Year

The pandemic left its mark. Despite the holiday season, 2020 saw a **decline in order volume**, though the **average selling price (ASP) remained stable**—suggesting the company held pricing power and avoided deep discounting.

#### >>> 📊 Quarterly Performance

* **Strong Growth (e.g., Q1 2018):** +49.96% in quantity, +53.91% in revenue.
* **Risky Growth (e.g., Q1 2017):** Quantity up, but revenue down—possibly due to heavy discounting.
* **Declines (2020):** Likely linked to **lockdowns and supply chain issues**.

---

### 🛫 3. Holiday Season Product Trends

#### >> 🥇 Top Performers Over 6 Years :

* **Desktops** dominated revenue, leading in 4 out of 6 years.
* **Movie DVDs** ruled unit sales every single year.
* **Laptops and Touch Screen Phones** surged in 2020–2021, likely due to **work-from-home demand**.

But the pandemic also hit hard:

* Movie DVD revenue fell sharply, though unit sales stayed high.
* Across categories, 2020 saw **volume and revenue drops**, yet some product lines like **Laptops** rose in relevance.

---

### 🚚 4. How Fast Are Deliveries?

Logistics improvements tell a success story:

* Average delivery time dropped from **7 days in 2016 to 3 days in 2021**.
* Maximum delivery time fell from **17 to 8 days**.
* Variability decreased—by 2021, delivery performance was **consistent even during Q4 peaks**.

This suggests investments in **supply chain and fulfillment operations paid off**, allowing the company to handle holiday surges efficiently.

---

### 🛒 5. What Do Customers Buy Together?

#### >>> 🎯 Cross-Selling Opportunities

* **Movie DVDs are an anchor product**: appearing in 5 of the top 6 product pairings and 8 times in the top 20.
* Often paired with:

  * Desktops
  * Bluetooth Headphones
  * Boxed and Download Games
* Recommendation: use DVDs as a **loss leader** to drive bundles and upsell home entertainment setups.

#### >>> 💡 Untapped Potential

* **Desktops + Touch Screen Phones** combo (Rank #11) could be marketed together.
* **Televisions + Movie DVDs** (Rank #14) is underleveraged—ripe for bundle promotions.


### >>> 📍Average Order Value (AOV) Insights

| Country       | 2016 AOV  | 2021 AOV | Trend                          |
| ------------- | --------- | -------- | ------------------------------ |
| Germany       | \$3,044   | \$2,306  | Gradual decline (premium)      |
| United States | \~\$2,200 | Stable   | High volume, consistent ASP    |
| Italy         | ↑         | \$2,116  | Spike in bulk purchases (2021) |

Italy’s rise in **AvgItemsPerOrder (10 items)** in 2021 hints at a growing **wholesale/bulk buying trend**.

---
<br>

### ✅ Key Takeaways and Recommendations

1. **Leverage Seasonal Trends:**

   * Prepare inventory for Christmas, New Year, Valentine’s, and Thanksgiving peaks.

2. **Strengthen Cross-Selling:**

   * Promote Movie DVDs with electronics and entertainment bundles.
   * Create targeted offers for underperforming combos (e.g., TVs + DVDs).

3. **Maintain Delivery Standards:**

   * Preserve 3-day delivery even in high-demand seasons.
   * Highlight fast delivery as a competitive advantage.

4. **Monitor Country-Specific Patterns:**

   * Tailor promotions to local celebrations (e.g., Black Friday in US/Canada, Singles’ Day in Europe).

5. **Explore Bulk Deals in Italy:**

   * Consider wholesale programs to capture emerging demand.


