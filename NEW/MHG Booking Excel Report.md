# MHG Booking Report

[🌐🔗 View Dataset Here](./MHG_Booking_Data.xlsx) 

<p align="center">
  <img src="https://github.com/user-attachments/assets/12a323d9-14c3-45d3-9069-503f5986ca9a" alt="Data Model Diagram" width="800">
</p>


## What The Dashboard is About?

This dashboard is designed to analyze **cancellation behavior in resort bookings during the summer months (July & August)** and its impact on potential revenue. It focuses on identifying cancellation patterns and average daily rates (ADR) based on booking lead time — especially comparing same-month bookings with advance bookings.



## What the Problem It Tries to Solve?

The dashboard aims to address the following issues:

1. **High cancellation rates during summer** caused a significant revenue loss — around **\$1 million in July & August 2016** alone.
2. **Bookings made more than 30 days before arrival have a higher cancellation rate (38%)**, and yet they make up the majority of all bookings.
3. **There is no current strategy to overbook during high-risk periods**, which leaves a large revenue gap unaddressed.



## What Kind of Insight It Brings?

Key insights derived from the dashboard:

* **Cancellation spikes during July and August**, aligning with higher average daily rates — leading to greater financial loss.
* **Same-month bookings (<30 days)** account for **only 17% of total cancellations**, with a **much lower cancellation rate (20%)** than long-lead bookings.
* Interestingly, **same-month bookings also command a higher ADR (\$191 vs \$169)**.
* This suggests that **strategic overbooking of same-month reservations** could significantly reduce revenue loss without increasing risk.



## How I Build This

The dashboard was developed through the following steps:

#### Data Preparation :

* Imported and cleaned the raw dataset from Excel.
* Converted `Booking Date` and `Arrival Date` into proper datetime formats.
* Created new calculated columns:

  * **Booking Lead Time Bucket** (0–30 days vs. >30 days)
  * **Monthly aggregation** for revenue and loss
  * **Cancellation Rate** based on booking lead time

#### Data Transformation & Modeling :

* Calculated key metrics: `Cancellation Rate`, `Average Daily Rate`, `Revenue`, and `Revenue Loss`.
* Aggregated data across 3 years (2015–2017) to analyze seasonal trends.
* Segmented the dataset by booking lead time for performance comparison.

#### Dashboard Design :

* Used a mix of visuals:

  * **Line + column chart** to show trends in cancellation rates and ADR
  * **Horizontal bar charts** to show booking volume and revenue loss
  * **Stacked comparisons** for lead time, cancellation rate, and pricing
  * Insight and recommendation highlights using icons, color cues, and layout emphasis (blue/orange, pointers, 💡 icon)



### ✅ Recommendation :

Based on these findings, here are actionable recommendations:

1. **Implement overbooking strategy for July & August** — targeting reservations made within 30 days of arrival.
2. **Prioritize last-minute bookings**, as they:

   * Are less likely to be cancelled
   * Bring in higher revenue per night
3. **Segment customers by lead time** to personalize marketing and pricing strategies.
4. **Continuously monitor seasonal cancellation trends** to adjust overbooking tactics dynamically.

