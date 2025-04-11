I use SQL Server import and export wizard to import data into SQL Server Management Studio. 

<div align="center"> <img width="473" alt="image" src="https://github.com/user-attachments/assets/fa6971c1-8678-4f59-a52d-8a670c2f4712" /> </div>


```sql
SELECT *
FROM [SQL Projects].[dbo].[healthcare_dataset]
```
<div align="center"> <img width="790" alt="image" src="https://github.com/user-attachments/assets/b472961c-ee9f-40a9-a66b-ab935277881f" /> </div>
<div align="center"><img width="335" alt="image" src="https://github.com/user-attachments/assets/7a20cc4c-82c7-4f18-b18a-e22879e307c4" /> </div>


/* Problems : Inconcistency, Format (Date of admission, Discharge date, Billing Amount), Outliers (Hospital), 
NULL Values, Duplicate*/


# 1. Name Column 

### a) Correct inconsistencies UPPER & LOWER Case
Fix the inconsistency in name formatting. In this case, I considered several options, such as using the UPPER or LOWER function. However, I found the results to be less tidy and likely to cause excessive query repetition. Therefore, I decided to create a custom function using UDF—while also sharpening my newly acquired UDF skills. This approach allows the query to be more concise, clean, and reusable for other columns that require consistent formatting.


- Method 1 (Using UPPER/LOWER)
```sql
SELECT UPPER(LEFT(NAME, 1)) + LOWER(SUBSTRING(NAME, 2, LEN(NAME)))
FROM [dbo].[healthcare_dataset]

UPDATE [dbo].[healthcare_dataset]
SET Name = UPPER(LEFT(NAME, 1)) + LOWER(SUBSTRING(NAME, 2, LEN(NAME)))
```


- Method 2 (Using UDF)
```sql
CREATE FUNCTION dbo.CapitalizeWords (@input VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @output VARCHAR(MAX) = LOWER(@input); --- Convert all letters to lowercase
    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@output);

    --- Capitalize the first letter
    SET @output = STUFF(@output, 1, 1, UPPER(SUBSTRING(@output, 1, 1)));

    --- Implement a Loop to capitalize the first letter of each word
    WHILE @i <= @len
    BEGIN
        IF SUBSTRING(@output, @i, 1) = ' ' --- Check for spaces
        BEGIN
            SET @output = STUFF(@output, @i + 1, 1, UPPER(SUBSTRING(@output, @i + 1, 1)));
        END
        SET @i = @i + 1;
    END

    RETURN @output;
END;

UPDATE [dbo].[healthcare_dataset]
SET Name = dbo.CapitalizeWords(Name);
```

<div align="center"> <img width="302" alt="image" src="https://github.com/user-attachments/assets/ca305a12-00bf-49f3-8257-688782018274" /> </div>



### b) Ensure consistent formatting for names with titles like MR., MRS., DR., and MISS 

```sql
-- Remove the title in front of the name to ensure all names are consistent with the original name, just like other patients.

SELECT NAME,
       CASE WHEN NAME LIKE '%. %' THEN SUBSTRING(NAME,CHARINDEX('. ' , Name)+2, LEN(NAME))
            WHEN NAME LIKE 'MISS %' THEN SUBSTRING(Name, CHARINDEX(' ', Name) + 1 , LEN(name))
            ELSE Name
       END AS CORRECT_NAME
FROM [dbo].[healthcare_dataset1]
WHERE NAME LIKE 'MR.%'
        OR NAME LIKE 'MRS.%'
        OR NAME LIKE 'DR,%'
        OR NAME LIKE 'MISS%'

-- Update with fixes

UPDATE [dbo].[healthcare_dataset]
SET NAME =  CASE WHEN NAME LIKE '%. %' THEN SUBSTRING(NAME,CHARINDEX('. ' , Name)+2, LEN(NAME))
                 WHEN NAME LIKE 'MISS %' THEN SUBSTRING(Name, CHARINDEX(' ', Name) + 1 , LEN(name))
                 ELSE NAME END
            WHERE NAME LIKE 'MR.%'
               OR NAME LIKE 'MRS.%'
               OR NAME LIKE 'DR,%'
               OR NAME LIKE 'MISS%'

-- Update using the previously created function to maintain consistency

UPDATE [dbo].[healthcare_dataset]
SET Name = dbo.CapitalizeWords(Name);
```

<div align="center"> <img width="194" alt="image" src="https://github.com/user-attachments/assets/20529314-9f87-4f9f-ad5c-67b722e51ab3" />  
    <img width="88" alt="image" src="https://github.com/user-attachments/assets/1fac817e-71aa-4e02-a48e-671716a9f0e6" /> </div>


<br><br>

# 2. 'Date of Admission' and 'Discharge Date' columns  

Standardize the date format in the 'Date of Admission' and 'Discharge Date' columns YYYY-MM-DD

```sql
---  Date of Admission

ALTER TABLE [dbo].[healthcare_dataset]
ALTER COLUMN [Date of Admission] DATE

--- Discharge Date

ALTER TABLE [dbo].[healthcare_dataset]
ALTER COLUMN [Discharge Date] DATE
```
<div align="center"> <img width="181" alt="image" src="https://github.com/user-attachments/assets/6a45cb2e-f5ce-4e1a-9464-c1393152ddc6" /> </div>



<br><br>

# 3. Hospital column 

Fix misspellings and variations in the 'Hospital column'. In this column, I found many inconsistencies, such as messy name formatting with misplaced or excessive punctuation.

- Corrections 
```sql
SELECT Hospital,							
	   CASE WHEN Hospital LIKE 'and %_, %' THEN SUBSTRING(Hospital, 5, CHARINDEX(',',Hospital) - 5) + ' and'
                                                   + SUBSTRING(Hospital, CHARINDEX(',', Hospital) + 1, LEN(Hospital)) 
												
                WHEN Hospital LIKE 'and %,' THEN SUBSTRING(Hospital,5,LEN(Hospital) - 5) 
                                               + SUBSTRING(Hospital,CHARINDEX(',',Hospital) + 1, LEN(Hospital))			
											  
                WHEN Hospital LIKE '% and%_,' OR Hospital LIKE '% and%_,%' THEN REPLACE(Hospital,',','')

                WHEN Hospital LIKE '%, and' THEN REPLACE(Hospital,', and','')

                WHEN Hospital LIKE '%, and %' THEN REPLACE(Hospital,', ',' ')
			
                WHEN Hospital LIKE 'and %' THEN REPLACE(Hospital,'and ','')

                WHEN Hospital LIKE '%_, %_ and' THEN REPLACE(LEFT(Hospital,LEN(Hospital) - 4), ',', ' and')

                WHEN Hospital LIKE '% and' and Hospital NOT LIKE '%, and' THEN REPLACE(Hospital,' and','')

		ELSE Hospital
            END AS Clean_Hospital_Name
FROM [dbo].[healthcare_dataset]
```
<div align="center">  <img width="293" alt="image" src="https://github.com/user-attachments/assets/31c344e1-f3ac-4d0c-bf37-2bc34f16af5c" /> </div>



- Updates
```sql
UPDATE [dbo].[healthcare_dataset]
SET Hospital = CASE WHEN Hospital LIKE 'and %_, %' THEN SUBSTRING(Hospital, 5, CHARINDEX(',',Hospital) - 5) + ' and'
                                                      + SUBSTRING(Hospital, CHARINDEX(',', Hospital) + 1, LEN(Hospital)) 
												
                    WHEN Hospital LIKE 'and %,' THEN SUBSTRING(Hospital,5,LEN(Hospital) - 5) 
                                                   + SUBSTRING(Hospital,CHARINDEX(',',Hospital) + 1, LEN(Hospital))			
											  
                    WHEN Hospital LIKE '% and%_,' OR Hospital LIKE '% and%_,%' THEN REPLACE(Hospital,',','')

                    WHEN Hospital LIKE '%, and' THEN REPLACE(Hospital,', and','')

                    WHEN Hospital LIKE '%, and %' THEN REPLACE(Hospital,', ',' ')
			
                    WHEN Hospital LIKE 'and %' THEN REPLACE(Hospital,'and ','')

                    WHEN Hospital LIKE '%_, %_ and' THEN REPLACE(LEFT(Hospital,LEN(Hospital) - 4), ',', ' and')

                    WHEN Hospital LIKE '% and' and Hospital NOT LIKE '%, and' THEN REPLACE(Hospital,' and','')

                ELSE Hospital END
```

<br><br>

# 4. Billing Amount Column

Fix the format to consistently show 2 decimal places for better readability. 

```sql
SELECT CAST(ROUND([Billing Amount], 2) AS DECIMAL (20,2))
FROM [dbo].[healthcare_dataset]

UPDATE [dbo].[healthcare_dataset]
SET [Billing Amount] = CAST(ROUND([Billing Amount], 2) AS DECIMAL (20,2))


# Billing Amount           
----------------
    18856.28
    33643.33
    27955.1
    37909.78
    14238.32
      ...

```



<br><br>

# 5. Handle duplicate values 

DATA DEDUPLICATION PROCESS :
1. Added unique ID since the table lacks a primary key
2. Calculate median age for each duplicate group
3. Used ROW_NUMBER() with ORDER BY ID to ensure consistent ordering
4. Only deleted rows with row_num > 1

```sql
/*
ALTER TABLE [dbo].[healthcare_dataset]
ADD ID INT IDENTITY(1,1)
*/


WITH DuplicateData AS (
    SELECT Name, Gender, [Blood Type], [Medical Condition], [Date of Admission],
           Doctor, Hospital, [Insurance Provider], [Billing Amount], [Room Number],
           [Admission Type], [Discharge Date], Medication, [Test Results],
           COUNT(*) AS Num_Duplicate
    FROM [dbo].[healthcare_dataset]
    WHERE Name IS NOT NULL
    GROUP BY Name, Gender, [Blood Type], [Medical Condition], [Date of Admission],
             Doctor, Hospital, [Insurance Provider], [Billing Amount], [Room Number],
             [Admission Type], [Discharge Date], Medication, [Test Results]
    HAVING COUNT(*) > 1

# Name           Gender    Blood Type          Num_Duplicate
--------------  --------  ------------        --------------
Aaron Archer    Female        B-                    2
Aaron Carr      Female        O-                    2
Aaron Dalton    Male          O+       ...          2
Aaron Davis     Male          O-                    2
Aaron Fox       Male          O-                    2
...

--Records : 5,500 rows

),

/*I need to quantify the age variance caused by these duplicate entries (11,000 Rows) to determine the most effective 
deduplication methodology. This statistical assessment will inform our data remediation strategy. */

FilteredData AS (
    SELECT h.*
    FROM [dbo].[healthcare_dataset] h
    WHERE EXISTS ( 
        SELECT 1 
        FROM DuplicateData c 
        WHERE c.Name = h.Name 
        AND c.[Room Number] = h.[Room Number] 
        AND c.[Date of Admission] = h.[Date of Admission]
        AND c.[Discharge Date] = h.[Discharge Date]
        AND c.Gender = h.Gender
        AND c.[Medical Condition] = h.[Medical Condition]
    )
--Records : 11,000 rows

),

/*
SELECT Name, MAX(AGE) - MIN(AGE) AS Age_Different
FROM FilteredData
GROUP BY Name,Gender, [Blood Type], [Medical Condition],[Date of Admission],[Room Number], [Discharge Date]    
ORDER BY Age_Different DESC

# Name             Age_Different
---------------   -------------:
Aaron Gates               5
Aaron Owen                5
Aaron Walter              5
Abigail Shannon           5
Adam Gray                 5
...                      ...
*/

---

/* After checking, it turns out that the largest age difference is only about 5 years, so I decided to use 
MEDIAN instead of AVERAGE. Why is Median Better than Average (Avg) for This Case? Median is Not Affected by Outliers. 
If the age difference is small (example: [30, 31]), the median and average are almost the same. But if there is an input error 
(example: [30, 60]), the median (45) is safer than the average (45). */


MedianData AS (
    SELECT 
        ID, 
        Name, Gender, [Blood Type], [Medical Condition], [Date of Admission],
        Doctor, Hospital, [Insurance Provider], [Billing Amount], [Room Number],
        [Admission Type], [Discharge Date], Medication, [Test Results],

        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Age) 
        OVER (PARTITION BY Name, Gender, [Blood Type], [Medical Condition], [Date of Admission],
              Doctor, Hospital, [Insurance Provider], [Billing Amount], [Room Number],
              [Admission Type], [Discharge Date], Medication, [Test Results]) AS MedianAge,

        ROW_NUMBER() OVER (
            PARTITION BY Name, Gender, [Blood Type], [Medical Condition], [Date of Admission],
                         Doctor, Hospital, [Insurance Provider], [Billing Amount], [Room Number],
                         [Admission Type], [Discharge Date], Medication, [Test Results]
            ORDER BY ID
        ) AS RowNum
    FROM FilteredData

# ID       Name           Gender    Blood Type            MedianAge    RowNum
------   ------------    ------    -----------           ---------    ------
24523    Aaron Archer    Female        B-                   48          1
50413    Aaron Archer    Female        B-      ...          48          2
7399     Aaron Carr      Female        O-                  59.5         1
22402    Aaron Carr      Female        O-                  59.5         2
...

)

-- Remove duplicate entries by filtering RowNum > 1 (keeping first occurrence)

DELETE FROM [dbo].[healthcare_dataset]
WHERE ID IN (
    SELECT ID 
    FROM MedianData 
    WHERE RowNum > 1
);

```
**Records :**

<img width="244" alt="image" src="https://github.com/user-attachments/assets/c178cc76-377b-4657-bf3d-466f405ac124" /> 


**Results :**
   | Metric            | Before  | After  |
|-------------------|---------|--------|
| Total Records     | 11,000  | 5,500  |
| Duplicate Pairs   | 5,500   | 0      |


<br><br>

# 6. Handling NULL Values 

- Check the number of null values

```sql
SELECT COUNT(*) AS Total_Rows,
       COUNT(NAME) AS Total_NonNull,
       COUNT(*) - COUNT(NAME) AS Null_Count
FROM [dbo].[healthcare_dataset]

# Total_Rows   Total_NonNull   Null_Count
------------  --------------  -----------
   51,000        50,000          1,000
```

After checking, I found around 1,000 null values, and these nulls exist across all columns. So, I have a few options: delete them, 
leave them as null, or replace them with other values. But I think I’ll go with the first option bcuz these records contained no analyzable data and occupied storage unnecessarily.

```sql
SELECT *
FROM [dbo].[healthcare_dataset]
WHERE NAME IS NULL
```

<div align="center"> <img width="740" alt="image" src="https://github.com/user-attachments/assets/77d5f1a8-0d80-40db-ba20-319bd737e6d3" /> </div>


```SQL
DELETE FROM [dbo].[healthcare_dataset]
WHERE NAME IS NULL
```

<img width="243" alt="image" src="https://github.com/user-attachments/assets/4c3644c2-22f9-4523-8dd6-981fb76c06e3" />


