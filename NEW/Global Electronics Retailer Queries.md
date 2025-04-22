
Ganti NULL di Store table dengan 0 instead NULL  karena itu 0 untuk menandai online store ( Kesalahan waktu import)
```sql
UPDATE [dbo].[Stores]
SET Square_Meters = ISNULL(Square_Meters, 0)
```


## 1. What types of products does the company sell, and where are customers located ?
```SQL
-- Types of products 

SELECT DISTINCT(Category) 
FROM [dbo].[Products]

#   Category          
----------------
TV and Video  
Audio  
Home Appliances  
Computers  
Cell phones  
Games and Toys  
Cameras and camcorders  
Music, Movies and Audio Books



SELECT DISTINCT(Subcategory) 
FROM [dbo].[Products]

#     SubCategory          
-------------------------
Bluetooth Headphones  
Home & Office Phones  
Printers, Scanners & Fax  
Microwaves  
Projectors & Screens  
        ...



-- Customers located

SELECT DISTINCT(Country),
       COUNT(DISTINCT State) AS [States / Regions]
FROM [dbo].[Customers]
GROUP BY  Country
ORDER BY  [States / Regions]

#    Country       [States / Regions]
----------------   ------------------
Australia                  8  
Netherlands                12  
Canada                     13  
Germany                    16  
France                     26  
United States              51  
Italy                      98  
United Kingdom             288

```

<br><br>


## 2. Are there any seasonal patterns or trends for order volume or revenue ?

### a) Weekly Patterns (US 2017 Example)
     
```SQL
/* 
   Weekly pattern analysis with 5-week moving average.
*/

SELECT 
    DATEPART(WEEK, S.Order_Date) AS WeekOfYear,
    AVG(SUM(S.Quantity)) OVER (ORDER BY DATEPART(WEEK, S.Order_Date) ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS MovingAvgOrders,
    AVG(SUM(S.Quantity * P.Unit_Price_USD)) OVER (ORDER BY DATEPART(WEEK, S.Order_Date) ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS MovingAvgRevenue
FROM Sales S
LEFT JOIN Products P ON S.ProductKey = P.ProductKey 
LEFT JOIN [dbo].[Customers] C ON S.CustomerKey = C.CustomerKey
WHERE YEAR (S.Order_Date) = 2017 AND C.Country = 'United States'
GROUP BY DATEPART(WEEK, S.Order_Date)--, YEAR(S.Order_date) 
ORDER BY  MovingAvgOrders DESC


WeekOfYear  MovingAvgOrders  MovingAvgRevenue
----------  ---------------  ---------------
    52          471              134232.56
    1           467              154149.73
    53          423              121222.88
    51          366              112936.24
    2           355              116975.45
    43          327              94106.44
    50          309              98716.98
   ...          ...                ...

```

**Findings:**

- Order peaks occur in the last weeks of December and first week of January
- Increase aligns with revenue, indicating Christmas and New Year period influence
- Consistent pattern from 2016-2020 shows stable annual trends


### b) Holiday Patterns (Christmas Example)

```sql
-- Pre-Christmas period analysis (December 20-31)

SELECT 
    YEAR(S.Order_Date) AS Year,
    SUM(CASE WHEN MONTH(S.Order_Date) = 12 
             AND DAY(S.Order_Date) BETWEEN 20 AND 31 
             THEN S.Quantity END) AS PreChristmasOrders
FROM Sales S
LEFT JOIN Products P ON S.ProductKey = P.ProductKey 
GROUP BY YEAR(S.Order_Date)
ORDER BY Year

Year    PreChristmasOrders
------  -----------------
2016          1808
2017          2544
2018          4284
2019          5125
2020          1316
2021          NULL

```
**Key Findings:**
- Steady year-over-year growth from 2016 (1,808 orders) to 2019 (5,125 orders)
- In 2020 Likely impacted by COVID-19 pandemic restrictions
- NULL values, indicating Incomplete data collection.


### c) Purchase Trends by Country During Holiday / Big Celebration Months

```SQL
/* 
   Analysis of offline/Online purchases during major holiday months (February, September-December for Valentine's, Thanksgiving, Christmas)
*/

SELECT 
    YEAR(S.Order_Date) AS Year,
    MONTH(S.Order_Date) AS Month,
    C.Country,
    P.Subcategory,
    SUM(S.Quantity) AS QUANTITY
FROM Sales S
LEFT JOIN Products P ON S.ProductKey = P.ProductKey 
LEFT JOIN [dbo].[Customers] C ON S.CustomerKey = C.CustomerKey
LEFT JOIN [dbo].[Stores] ST ON S.StoreKey = ST.StoreKey
WHERE S.StoreKey != 0   -- S.StoreKey = 0
  AND MONTH(S.Order_Date) IN (2, 9, 10, 11, 12)
GROUP BY YEAR(S.Order_Date), P.Subcategory, C.Country, MONTH(S.Order_Date)
ORDER BY QUANTITY DESC


Year  Month      Country     Subcategory   Quantity
----  -----   -------------  ------------  --------
2019   12     United States   Movie DVD      600
2020   2      United States   Movie DVD      504
2019   12     United States   Desktops       495
2018   12     United States   Movie DVD      482
2019   10     United States   Movie DVD      451
2019   9      United States   Movie DVD      437
2019   2      United States   Movie DVD      425
...   ...         ...           ...          ...

```

**Additional Findings:**

- February purchase increase (Valentine's Day)
- Significant October-November spikes in US and Canada (Thanksgiving)
- Christmas/New Year period shows the most consistent annual peaks for each country
- For 5 consecutive years, the best-selling product has always been the 'Movie DVD' subcategory, which also includes DVD players 
- Different patterns observed across countries based on local culture/celebrations



### d) Seasonal/Quarterly Breakdown Analysis

```sql
WITH QuarterlySales AS (
    SELECT 
        YEAR(S.Order_Date) AS [YEAR],
        DATEPART(QUARTER, S.Order_Date) AS [QUARTER],
        SUM(S.Quantity) AS QUANTITY,
        SUM(S.Quantity * P.Unit_Price_USD) AS REVENUE	
    FROM Sales S
    LEFT JOIN [dbo].[Customers] C ON S.CustomerKey = C.CustomerKey
    LEFT JOIN [dbo].[Stores] ST ON S.StoreKey = ST.StoreKey
    LEFT JOIN Products P ON S.ProductKey = P.ProductKey
    WHERE YEAR(S.Order_Date) != 2021
    GROUP BY YEAR(S.Order_Date), DATEPART(QUARTER, S.Order_Date)
),

QuarterlyWithPreviousYear AS (
    SELECT 
        [YEAR],
        [QUARTER],
        QUANTITY,
        REVENUE,
         /* Window function (LAG) must be applied to non-aggregated data before GROUP BY */
        LAG(QUANTITY) OVER (PARTITION BY [QUARTER] ORDER BY [YEAR]) AS PrevYearOrderVolume,
        LAG(REVENUE) OVER (PARTITION BY [QUARTER] ORDER BY [YEAR]) AS PrevYearRevenue
    FROM QuarterlySales
), 

QuarterlyGrowthCalculation AS (
    SELECT 
        [YEAR],
        [QUARTER],
        QUANTITY,
        REVENUE,
        PrevYearOrderVolume,
        PrevYearRevenue,
          -- Additional analysis
        CAST(COALESCE((QUANTITY - PrevYearOrderVolume) * 100.0 / NULLIF(PrevYearOrderVolume, 0), 0) AS DECIMAL(10,2)) AS YoYGrowth%,
        CAST(COALESCE((REVENUE - PrevYearRevenue) * 100.0 / NULLIF(PrevYearRevenue, 0), 0) AS DECIMAL(19,2)) AS YoYRevenue%
    FROM QuarterlyWithPreviousYear
),

GrowthCategory AS (
    SELECT
        [YEAR],
        [QUARTER],
        QUANTITY,
        REVENUE,
        YoYGrowth%,
        YoYRevenue%,
        CASE
            WHEN YoYGrowth% > 0 AND YoYRevenue% > 0 THEN 'Growth Strong'
            WHEN YoYGrowth% > 0 AND YoYRevenue% < 0 THEN 'Growth Risky'   -- Quantity up, but revenue down
            WHEN YoYGrowth% < 0 AND YoYRevenue% < 0 THEN 'Decline'
            WHEN YoYGrowth% < 0 AND YoYRevenue% > 0 THEN 'Recovery'  -- Quantity down, but revenue up (price increase)
            ELSE 'No Baseline Data'
        END AS GrowthCategory
    FROM QuarterlyGrowthCalculation



YEAR  QUARTER  QUANTITY     REVENUE     YoYGrowth%  YoYRevenue%    GrowthCategory
----  -------  --------  -------------  ----------  -----------  -----------------
2016    1      5,687     1,879,424.44       0.00       0.00       No Baseline Data
2017    1      5,805     1,751,889.58       2.07       -6.79      Risky Growth
2018    1      8,705     2,696,369.20      49.96       53.91      Strong Growth
2019    1      17,328    4,889,687.23      99.06       81.34      Strong Growth
2020    1      18,483    4,971,321.35       6.67        1.67      Strong Growth
2016    2      3,836     1,225,163.09       0.00       0.00       No Baseline Data
2017    2      4,065     1,306,570.33       5.97        6.64      Strong Growth
2018    2      7,450     2,117,868.43      83.27       62.09      Strong Growth
2019    2      12,025    3,149,200.58      61.41       48.70      Strong Growth
2020    2      6,688     1,859,551.96     -44.38      -40.95      Decline
...    ...     ...           ...            ...        ...            ...


) -- Still continue...
```

**Identified Growth Patterns for GrowthCategory:**

1. Growth Strong
   - Quantity and Revenue show positive growth
   - Example: 2018 Q1 (Qty +49.96%, Rev +53.91%)

2. Growth Risky
   - Quantity increases but Revenue decreases
   - Only occurred in 2017 Q1 (Qty +2.07%, Rev -6.79%)
   - Maybe bcus Possible price discounts/cuts ?

3. Decline (**Need further analysis**)
   - Both Quantity and Revenue decrease
   - Occurred in all quarters of 2020 except Q1
   - Is it due to COVID-19 lockdown, supply chain issues, or internal factors ?

4. No Baseline Data
   - First year data (2016) cannot be compared (no previous year for reference)



```SQL

/* ASP Analysis 2020 :

- Is the decline in revenue proportional to the quantity?
- If ASP is stable, it means the issue lies purely in volume.

*/

SELECT 
    [YEAR],
    [QUARTER],
    QUANTITY,
    REVENUE,
    ROUND(REVENUE/NULLIF(QUANTITY, 0), 2) AS ASP
FROM COBA4
WHERE [YEAR] = 2020
ORDER BY [QUARTER];


QUARTER   QUANTITY     REVENUE         ASP
-------   --------   -------------   --------
  1       18,483     4,971,321.35     268.96
  2       6,688      1,859,551.96     278.04
  3       4,795      1,309,883.78     273.18
  4       4,497      1,153,875.05     256.59
```
- Although quantity dropped significantly in Q2–Q4 2020, ASP remained relatively stable.
- This indicates that the company may have maintained pricing (did not offer major discounts) despite the drop in demand.


<br><br>





## 3. Holiday Season Product Analysis 

```sql
-- Analisis Musiman (Holiday Season) - Versi Alternatif
WITH HolidayOrders AS (
    SELECT 
        [Order_Number],
        YEAR([Order_Date]) AS Year,
        MONTH([Order_Date]) AS Month
    FROM Sales
    WHERE MONTH([Order_Date]) IN (2, 9, 10, 11, 12)  -- Bulan holiday season
    GROUP BY [Order_Number], YEAR([Order_Date]), MONTH([Order_Date])
),
HolidaySales AS (
    SELECT 
        ho.Year,
        p.Subcategory,
        SUM(s.Quantity) AS HolidayQuantity,
        SUM(s.Quantity * p.Unit_Price_USD) AS HolidayRevenue,
        -- Hitung persentase dari total penjualan tahunan
        SUM(s.Quantity * 100.0) / 
        (SELECT SUM(Quantity) FROM Sales WHERE YEAR([Order_Date]) = ho.Year) AS PctOfTotalSales
    FROM Sales s
    JOIN HolidayOrders ho ON s.[Order_Number] = ho.[Order_Number]
    JOIN Products p ON s.ProductKey = p.ProductKey
    GROUP BY ho.Year, p.Subcategory
)
SELECT 
    Year,
    Subcategory,
    HolidayQuantity,
    HolidayRevenue,
    PctOfTotalSales,
    RANK() OVER (PARTITION BY Year ORDER BY HolidayRevenue DESC) AS RevenueRank,
    RANK() OVER (PARTITION BY Year ORDER BY HolidayQuantity DESC) AS QuantityRank
FROM HolidaySales
ORDER BY Year, RevenueRank;


Year    Subcategory    HolidayQuantity    HolidayRevenue    PctOfTotalSales    RevenueRank    QuantityRank
----    ------------   ---------------    --------------    ---------------    -----------    ------------
2016    Televisions         681	             534665.60	       3.129451             1              4
2016    Desktops            909              435997.00	       4.177197             2              2
2016    Water Heaters       415              43454.50	       1.907081             3              8
2016    Movie DVD           1902             214446.78	       8.740407             4              1
...       ...               ...                 ...              ...               ...            ...  

```

**Key Holiday Sales Trends :**

1. Top Revenue-Generating Products  
- Desktops dominated as the #1 revenue contributor in 4 out of 6 years.  
- Televisions held the top spot in 2016 but dropped in ranking in subsequent years.  
- Projectors & Screens consistently ranked in the top 5 since 2018.

2. Top Selling Products by Volume
- Movie DVDs consistently ranked #1 in quantity sold every year.  
- Desktops maintained a stable #2 position in terms of quantity.  
- Touch Screen Phones emerged as strong competitors during 2019–2021.

3. Trend Shifts in 2020–2021
- Significant declines across all categories (pandemic impact?).  
- Movie DVDs remained dominant in volume but experienced a sharp drop in revenue.  
- Laptops entered the top 5 revenue contributors in 2020 (due to work-from-home demand ?).





<br><br>


## 4. How long is the average delivery time in days? Has that changed over time ?

```sql

- Calculate shipping time for online store orders
-- Focuses on the longest shipping durations

SELECT 
    S.Order_Date,
    S.Delivery_Date,
    C.Country,
    DATEDIFF(DAY, S.Order_Date, S.Delivery_Date) AS Shipping_Days
FROM 
    [dbo].[Sales] S
    LEFT JOIN [dbo].[Customers] C ON S.CustomerKey = C.CustomerKey
    LEFT JOIN [dbo].[Stores] ST ON S.StoreKey = ST.StoreKey
WHERE 
    ST.StoreKey = 0 -- Online Store only
ORDER BY 
    Shipping_Days DESC,  -- Show longest shipping times first
    Order_Date DESC      -- Secondary sort by most recent orders



 Order_Date       Delivery_Date          Country        Shipping_Days 
-------------    --------------    ----------------    --------------
 2016-02-27       2016-03-15         United States           17            
 2016-02-27       2016-03-15         United States           17            
 2016-02-27       2016-03-15         United States           17            
 2016-06-09       2016-06-24         Canada                  15
    ...              ...                 ...                ...

```

- Maximum shipping time observed: 17 days (United States, Feb-Mar 2016)
- All extreme cases occur in 2016, suggesting potential logistics improvements in later years



```sql


-- Calculate average shipping time by year/month for online store
-- Includes year-over-year comparison and performance trends
SELECT 
    YEAR(S.Order_Date) AS [YEAR],
    MONTH(S.Order_Date) AS [MONTH],
    AVG(DATEDIFF(DAY, S.Order_Date, S.Delivery_Date)) AS Avg_Shipping_Days,
    MIN(DATEDIFF(DAY, S.Order_Date, S.Delivery_Date)) AS Min_Shipping_Days,
    MAX(DATEDIFF(DAY, S.Order_Date, S.Delivery_Date)) AS Max_Shipping_Days
FROM 
    [dbo].[Sales] S
    JOIN [dbo].[Stores] ST ON S.StoreKey = ST.StoreKey
WHERE 
    ST.StoreKey = 0 -- Online Store only
GROUP BY 
    YEAR(S.Order_Date), 
    MONTH(S.Order_Date)
ORDER BY 
    [Year], [Month]


YEAR   MONTH    Avg_Shipping_Days    Min_Shipping_Days    Max_Shipping_Days
----   -----    -----------------    -----------------    -----------------
2016	 1             8                    4                    15
2016	 2             7                    3                    17
2016	 3             8                    2                    13
2016	 4             6                    3                    10
2016	 5             7                    2                    14
...     ...           ...                  ...                   ...


```

**Key Monthly Breakdown**  
**1. Best Performance**  
- December 2019 & November 2020: Average of 3 days (fastest)  
- 2021: Consistently achieved 3-day delivery  

**2. Early Challenges**  
- February 2016: Maximum delivery time of 17 days  
- 2016 overall: Wide variation (1–17 days)  

**Significant Changes (2016 vs 2021)**  
**Logistics Improvement**  
- Average delivery time decreased from 7 days → 3 days  
- Maximum delivery time decreased from 17 days → 8 days  

**Service Consistency**  
- Standard deviation of delivery time dropped significantly  
- Min-max gap in 2021 was only 7 days (vs 16 days in 2016)  

**Year-End Quarter Performance**  
- Q4 2016: 6–7 days  
- Q4 2020: 3–4 days  
- Increased capacity to handle peak season  


```sql
-- Year-over-Year Delivery Time Trend Analysis

WITH YearlyDelivery AS (
    SELECT 
        YEAR(S.Order_Date) AS [YEAR],
        AVG(DATEDIFF(DAY, S.Order_Date, S.Delivery_Date)) AS Avg_Delivery_Days
    FROM [dbo].[Sales] S
    LEFT JOIN [dbo].[Customers] C ON S.CustomerKey = C.CustomerKey
    LEFT JOIN [dbo].[Stores] ST ON S.StoreKey = ST.StoreKey
    WHERE 
        ST.StoreKey = 0 -- Focus on Online or Specific Store (StoreKey = 0)
        AND YEAR(S.Order_Date) != 2021 -- Exclude year 2021
    GROUP BY 
        YEAR(S.Order_Date)
)

SELECT 
    [YAER],
    Avg_Delivery_Days,
    LAG(Avg_Delivery_Days) OVER (ORDER BY [Year]) AS Prev_Year_Avg,
    ROUND(Avg_Delivery_Days - LAG(Avg_Delivery_Days) OVER (ORDER BY [Year]), 2) AS YoY_Change
FROM 
    YearlyDelivery;


YEAR    Avg_Delivery_Days    Prev_Year_Avg    YoY_Change
----    -----------------    -------------    ----------
2016	       7                  NULL           NULL
2017	       5                   7              -2
2018	       4                   5              -1
2019	       4                   4               0     --Stable
2020	       4                   4               0     --Stable

```



