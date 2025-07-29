
[🌐🔗 View Dataset Here](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)

[📃 View Queries Here](HealthCare%20Data%20Cleaning%20Queries.md)


When I decided to create this Data Cleaning project, I faced some challenges in finding the right dataset. I needed data that
wasn't overly simple yet contained meaningful complexities to both test and reflect on my current skill level. After searching, 
I discovered this interesting dataset on Kaggle that perfectly balanced these requirements.

## Query types used:

- Aggregation Functions (MAX/MIN,COUNT,SUM)
- Wilcards
- Case When
- String Functions (UPPER/LOWER,LEFT/RIGHT,LEN,CHARINDEX,SUBSTRING,REPLACE)
- Chained CTEs
- Exists
- Cast
- Scalar User-Defined Function (UDF)
- Group By
- Having
- Joins
- ISNULL
- Windows Function (Row_Number, PERCENTILE_CONT( ))
- Subquery
- Update And Delete
- Alter Table / Column

----

## Most Challenging Aspect: Problem Solving - Duplicate Data Handling

**Background :**
- Identified 11,000 duplicate rows (each entry had 2 identical copies)
- The table lacked a primary key, complicating the deduplication process
- Objective: Preserve only 1 row from each duplicate pair (retaining 5,500 rows total)

**Initial Failed Attempt :**
1. Approach:
   - Applied ROW_NUMBER() partitioned by all columns
   - Executed direct DELETE with ROW_NUMBER() > 1 condition

2. Outcome:
   - All 11,000 rows were deleted (instead of just removing 5,500 duplicates)
   - Root Cause: Without a unique identifier, the deletion targeted all identical rows in each partition

**Solution :**
1. Added an ID column as a unique identifier using IDENTITY(1,1)
2. Implemented `ROW_NUMBER()` with complete partitioning + ORDER BY ID
3. Only deleted rows with row_number > 1

**Lesson Learned**:
- The critical importance of primary keys for data operations
- CTE + ROW_NUMBER() technique proves highly effective for deduplication

