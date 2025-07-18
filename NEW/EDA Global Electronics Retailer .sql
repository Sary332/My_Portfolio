/*
Replace NULL in the Store table with 0 instead of NULL, as 0 is used to indicate online stores (Mistake when importing dataset 
using SQL Server Import and Export Wizard).
*/

UPDATE [dbo].[Stores]
SET Square_Meters = ISNULL(Square_Meters, 0)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- 1. What types of products does the company sell, and where are customers located ?

-- Types of products

SELECT DISTINCT(Category) 
FROM [dbo].[Products]

/* Result : 8 Rows */
  
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


/* Result : 32 Rows */
  
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

  
/* Result : 8 Rows */
  
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


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  

--- 2. Are there any seasonal patterns or trends for order volume or revenue ?

-- a) Weekly Patterns (US 2017 Example)
  
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

  
/* Result : 48 Rows */
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


  
-- b) Holiday Patterns (Christmas Example)

/* Pre-Christmas period analysis (December 20-31) */

SELECT 
    YEAR(S.Order_Date) AS Year,
    SUM(CASE WHEN MONTH(S.Order_Date) = 12 
             AND DAY(S.Order_Date) BETWEEN 20 AND 31 
             THEN S.Quantity END) AS PreChristmasOrders
FROM Sales S
LEFT JOIN Products P ON S.ProductKey = P.ProductKey 
GROUP BY YEAR(S.Order_Date)
ORDER BY Year

  
/* Result : 5 Rows */
Year    PreChristmasOrders
------  -----------------
2016          1808
2017          2544
2018          4284
2019          5125
2020          1316
2021          NULL


  
-- c) Purchase Trends by Country During Holiday / Big Celebration Months

/* 
Analysis of offline/Online purchases during major holiday months (February, September-December for Valentine's, Thanksgiving, Christmas).
Also, I chose to use Subcategory instead of Category because Category is too broad and, in my opinion, doesn't
accurately represent the specific types of products. 
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

  
/* Result : 4211 Rows */
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


  
-- d) Seasonal/Quarterly Breakdown Analysis

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

)
  
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

---

/* 
Result for GrowthCategory  & ASP Analysis 2020 :

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


  QUARTER   QUANTITY     REVENUE         ASP
-------   --------   -------------   --------
  1       18,483     4,971,321.35     268.96
  2       6,688      1,859,551.96     278.04    -- Although quantity dropped significantly in Q2–Q4 2020, ASP remained relatively stable.
  3       4,795      1,309,883.78     273.18
  4       4,497      1,153,875.05     256.59

*/



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- 3. Holiday Season Product Analysis

-- a) Seasonal Analysis (Holiday Season)

WITH HolidayOrders AS (
    SELECT 
        [Order_Number],
        YEAR([Order_Date]) AS Year,
        MONTH([Order_Date]) AS Month
    FROM Sales
    WHERE MONTH([Order_Date]) IN (2, 9, 10, 11, 12)  -- Holiday season months
    GROUP BY [Order_Number], YEAR([Order_Date]), MONTH([Order_Date])
),
HolidaySales AS (
    SELECT 
        ho.Year,
        p.Subcategory,
        SUM(s.Quantity) AS HolidayQuantity,
        SUM(s.Quantity * p.Unit_Price_USD) AS HolidayRevenue,
        -- Calculate the percentage of total annual sales
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


/*Result : 160 Rows */

Year    Subcategory    HolidayQuantity    HolidayRevenue    PctOfTotalSales    RevenueRank    QuantityRank
----    ------------   ---------------    --------------    ---------------    -----------    ------------
2016    Televisions         681	             534665.60	       3.129451             1              4
2016    Desktops            909              435997.00	       4.177197             2              2
2016    Water Heaters       415              43454.50	       1.907081             3              8
2016    Movie DVD           1902             214446.78	       8.740407             4              1
...       ...               ...                 ...              ...               ...            ...  


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- 4. How long is the average delivery time in days? Has that changed over time ?

-- a) Calculate shipping time for online store orders

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


-- b) Calculate average shipping time by year/month for online store

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



-- c) Year-over-Year Delivery Time Trend Analysis

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


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- 5. Product Analysis
-- a) Popular Product Analysis by Country


WITH CountryProductSales AS (
    SELECT 
        YEAR(S.[Order_Date]) AS [YEAR],
        C.Country,
        P.Subcategory,
        SUM(S.Quantity) AS TotalQuantity,
        SUM(S.Quantity * P.Unit_Price_USD) AS TotalRevenue,
        RANK() OVER (PARTITION BY YEAR(S.[Order_Date]), C.Country ORDER BY SUM(S.Quantity) DESC) AS QuantityRank
    FROM Sales S
    JOIN Products P ON S.ProductKey = P.ProductKey 
    JOIN Customers C ON S.CustomerKey = C.CustomerKey
    GROUP BY YEAR(S.[Order_Date]), C.Country, P.Subcategory
)
SELECT 
    Year,
    Country,
    Subcategory,
    TotalQuantity,
    TotalRevenue,
    QuantityRank
FROM CountryProductSales
WHERE QuantityRank <= 5  -- Retrieve top 5 based on quantity and revenue
ORDER BY Year, Country, QuantityRank;


-- b) Cross-Selling Analysis


WITH OrderProducts AS (
    SELECT 
        s.Order_Number,
        p.Subcategory
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
),
ProductPairs AS (
    SELECT 
        a.Subcategory AS ProductA,
        b.Subcategory AS ProductB,
        COUNT(DISTINCT a.Order_Number) AS CoOccurrence
    FROM OrderProducts a
    JOIN OrderProducts b ON a.Order_Number = b.Order_Number
        AND a.Subcategory < b.Subcategory
    GROUP BY a.Subcategory, b.Subcategory
)
SELECT TOP 20
    ProductA,
    ProductB,
    CoOccurrence,
    RANK() OVER (ORDER BY CoOccurrence DESC) AS Rank
FROM ProductPairs
ORDER BY CoOccurrence DESC;


      ProductA                 ProductB          CoOccurrence     Rank
--------------------    ---------------------    ------------    ------
Desktops                 Movie DVD                  1548           1
Bluetooth Headphones     Movie DVD                  1031           2
Download Games	         Movie DVD                  939            3
Boxed Games              Movie DVD                  920            4
Movie DVD                Touch Screen Phones        886            5
Movie DVD                Smart phones & PDAs        878            6
     ...                        ...                  ...          ...


        
-- c) AOV (Average Order Value) Analysis


WITH OrderValues AS (
    SELECT 
        [Order_Number],
        YEAR([Order_Date]) AS Year,
        c.Country,
        SUM(s.Quantity * p.Unit_Price_USD) AS OrderValue,
        SUM(s.Quantity) AS TotalItems
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
    JOIN Customers c ON s.CustomerKey = c.CustomerKey
    JOIN Stores st ON s.StoreKey = st.StoreKey
    GROUP BY [Order_Number], YEAR([Order_Date]), c.Country
)
SELECT 
    Year,
    Country,
    COUNT([Order_Number]) AS OrderCount,
    SUM(OrderValue) AS TotalRevenue,
    AVG(OrderValue) AS AOV,
    AVG(TotalItems) AS AvgItemsPerOrder
FROM OrderValues
GROUP BY Year, Country
ORDER BY Year, Country, AOV DESC;

        
