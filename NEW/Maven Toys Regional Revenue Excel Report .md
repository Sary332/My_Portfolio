# Maven Toys – Regional Revenue Dashboard (September 2021)

[🌐🔗 View Dataset Here](./MavenToys_Excel_Sales.xlsx) 

<p align="center">
  <img src="https://github.com/user-attachments/assets/18146678-5fee-4d9f-9498-2fa432712c85" alt="Data Model Diagram" width="800">
</p>


## What the Dashboard is About ?

This **Regional Revenue Dashboard** is designed to monitor and compare **monthly revenue performance** across three key markets: **Chicago**, **Los Angeles**, and **New York**. It provides a dynamic and filterable view of:

- Revenue performance vs. previous month and same month last year
- Store-level contribution and growth
- Product-level drivers and decliners
- Historical revenue trends (2020 vs 2021)



## What the Problem It Tries to Solve ?

This dashboard aims to answer critical business questions:

- Which region is underperforming and why?
- Which stores and products are driving revenue gains or losses?
- How does the current month compare with past trends?
- What should the business focus on next?

By surfacing both high-performing and underperforming entities, this dashboard helps regional managers and corporate teams **prioritize actions**, adjust strategies, and manage inventory effectively.



## What Kind of Insight It Brings ?

### 🔹 Chicago
- **Revenue**: `$61,704`  
- **Change**: ↓ 11.6% MoM, ↓ 8.7% YoY  
- **Top Products**: Nerf Gun (+$2,559), Rubik’s Cube (+$1,079)  
- **Loss Drivers**: Lego Bricks (-$4,479), Colorbuds (-$1,724)  
- **Insight**: Chicago experienced a broad-based decline, led by poor performance at Michigan Ave (-24%) and O’Hare (-33%). Toy categories like Lego and Colorbuds are losing traction.

### 🔹 Los Angeles
- **Revenue**: `$44,041`  
- **Change**: ↑ 6.7% MoM, ↑ 26.3% YoY  
- **Top Products**: Magic Sand (+$3,294), Toy Robot (+$1,533)  
- **Loss Drivers**: Rubik’s Cube (-$2,599), Dino Egg (-$1,242)  
- **Insight**: LA shows healthy recovery with growth driven by novelty products. However, several traditional toys saw a steep drop and need reevaluation.

### 🔹 New York
- **Revenue**: `$50,618`  
- **Change**: ↑ 1.6% MoM, ↑ 45.3% YoY  
- **Top Products**: Dinosaur Figures (+$989), Monopoly (+$740), Magic Sand (+$688)  
- **Loss Drivers**: Rubik’s Cube (-$1,359), Lego Bricks (-$800)  
- **Insight**: Strong YoY rebound supported by Times Square’s +14% MoM growth. However, Fifth Avenue dropped 14%. Rubik’s Cube continues to underperform across markets.



## How I Build This

### 🔸 Tools Used:
- **Microsoft Excel** (Pivot Table, Conditional Formatting, Slicers, Charts)
- **Raw Data**: Monthly revenue data by store, region, and product

### 🔸 Data Cleaning:
- Renamed columns for clarity
- Adjusted data types for dates and currency
- Checked and handled missing/duplicate records

### 🔸 Data Transformation:
- Created new fields for:
  - Month-over-Month (MoM) and Year-over-Year (YoY) deltas
  - Product-level MoM contribution
- Used pivot tables to summarize regional and product performance
- Built dynamic dropdown filters for region and date

### 🔸 Dashboard Design:
- KPI cards for quick overview
- Line charts for revenue trends
- Bar charts for store comparison
- Highlight tables with conditional formatting for product performance

---

## ✅ Recommendations

| Region     | Recommendation |
|------------|----------------|
| **Chicago** | Boost weak stores (O'Hare, Michigan Ave) through local promotions. Phase out consistently underperforming products like Lego Bricks. |
| **Los Angeles** | Scale up trending products like Magic Sand and Toy Robot. Reevaluate Rubik’s Cube positioning or bundling. |
| **New York** | Expand successful SKUs from Times Square to Fifth Avenue. Investigate decline in traditional toys and optimize shelf space accordingly. |
| **Global** | Identify cross-regional underperformers (e.g., Rubik’s Cube, Plush Pony) for possible discounting or bundling. Promote novelty items like Magic Sand and Dinosaur Figures across all regions. |



