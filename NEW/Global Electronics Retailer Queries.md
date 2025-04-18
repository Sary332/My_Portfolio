
Ganti NULL di Store table dengan 0 instead NULL  karena itu 0 untuk menandai online store ( Kesalahan waktu import)
```sql
UPDATE [dbo].[Stores]
SET Square_Meters = ISNULL(Square_Meters, 0)
```


### 1. What types of products does the company sell, and where are customers located ?
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


### 2. Are there any seasonal patterns or trends for order volume or revenue ?

#### a) Weekly Patterns (US 2017 Example)
     
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


#### b) Holiday Patterns (Christmas Example)

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


#### c) Purchase Trends by Country During Holiday / Big Celebration Months

```SQL
/* 
   Analysis of offline purchases during major holiday months (February, September-December for Valentine's, Thanksgiving, Christmas)
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
WHERE S.StoreKey != 0 
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
- Christmas/New Year period shows the most consistent annual peaks
- For 5 consecutive years, the best-selling product has always been the 'Movie DVD' subcategory, which also includes DVD players.
- Different patterns observed across countries based on local culture/celebrations



#### d) Seasonal/Quarterly Breakdown Analysis

```sql
WITH QuarterlySales AS (
    SELECT 
        YEAR(S.Order_Date) AS [Year],
        DATEPART(QUARTER, S.Order_Date) AS [Quarter],
        SUM(S.Quantity) AS OrderQuantity,
        SUM(S.Quantity * P.Unit_Price_USD) AS Revenue
    FROM Sales S
    LEFT JOIN Products P ON S.ProductKey = P.ProductKey
    WHERE YEAR(S.Order_Date) != 2021 -- Excluded due to incomplete data
    GROUP BY YEAR(S.Order_Date), DATEPART(QUARTER, S.Order_Date)
),

QuarterlyWithPreviousYear AS (
    SELECT 
        [Year],
        [Quarter],
        OrderQuantity,
        Revenue,
        /* Window function (LAG) must be applied to non-aggregated data before GROUP BY */
        LAG(OrderQuantity) OVER (PARTITION BY [Quarter] ORDER BY [Year]) AS PreviousYearOrderVolume
    FROM QuarterlySales
), 

QuarterlyGrowthCalculation AS (
    SELECT 
        [Year],
        [Quarter],
        OrderQuantity,
        Revenue,
        PreviousYearOrderVolume,
        CAST(COALESCE((OrderQuantity - PreviousYearOrderVolume) * 100.0 / 
            NULLIF(PreviousYearOrderVolume, 0), 0) AS DECIMAL(10,2)) AS YoYGrowthPercentage
    FROM QuarterlyWithPreviousYear
),

QuarterlyRevenueGrowth AS (
    SELECT
        [Year],
        [Quarter],
        OrderQuantity,
        Revenue,
        PreviousYearOrderVolume,
        YoYGrowthPercentage,
        -- Additional analysis
        CAST((Revenue - LAG(Revenue) OVER (PARTITION BY [Quarter] ORDER BY [Year])) * 100.0 / 
              NULLIF(LAG(Revenue) OVER (PARTITION BY [Quarter] ORDER BY [Year]), 0) AS DECIMAL(19,2)) AS YoYRevenueGrowthPercentage
    FROM QuarterlyGrowthCalculation
)

SELECT
    [Year],
    [Quarter],
    OrderQuantity,
    Revenue,
    YoYGrowthPercentage,
    YoYRevenueGrowthPercentage,
    -- Revised growth category (considering both revenue and quantity)
    CASE
        WHEN YoYGrowthPercentage > 0 AND YoYRevenueGrowthPercentage > 0 THEN 'Strong Growth'
        WHEN YoYGrowthPercentage > 0 AND YoYRevenueGrowthPercentage < 0 THEN 'Risky Growth' -- Quantity up, but revenue down
        WHEN YoYGrowthPercentage < 0 AND YoYRevenueGrowthPercentage < 0 THEN 'Decline'
        WHEN YoYGrowthPercentage < 0 AND YoYRevenueGrowthPercentage > 0 THEN 'Recovery' -- Quantity down, but revenue up (price increase)
        ELSE 'No Baseline Data'
    END AS GrowthCategory
FROM QuarterlyRevenueGrowth
-- ORDER BY [Year], [Quarter]


Year  Quarter  Quantity     Revenue     YoYGrowth%  YoYRevenue%    GrowthCategory
----  -------  --------  -------------  ----------  -----------  -----------------
2016    1      5,687     1,879,424.44       0.00       NULL       No Baseline Data
2017    1      5,805     1,751,889.58       2.07       -6.79      Risky Growth
2018    1      8,705     2,696,369.20      49.96       53.91      Strong Growth
2019    1      17,328    4,889,687.23      99.06       81.34      Strong Growth
2020    1      18,483    4,971,321.35       6.67        1.67      Strong Growth
2016    2      3,836     1,225,163.09       0.00       NULL       No Baseline Data
2017    2      4,065     1,306,570.33       5.97        6.64      Strong Growth
2018    2      7,450     2,117,868.43      83.27       62.09      Strong Growth
2019    2      12,025    3,149,200.58      61.41       48.70      Strong Growth
2020    2      6,688     1,859,551.96     -44.38      -40.95      Decline
...    ...     ...           ...            ...        ...            ...

```
