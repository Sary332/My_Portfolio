I use SQL Server import and export wizard to import data into SQL Server Management Studio. 

<div align="center"> <img width="473" alt="image" src="https://github.com/user-attachments/assets/fa6971c1-8678-4f59-a52d-8a670c2f4712" /> </div>

```sql
SELECT TOP (1000) [Name]
      ,[Age]
      ,[Gender]
      ,[Blood Type]
      ,[Medical Condition]
      ,[Date of Admission]
      ,[Doctor]
      ,[Hospital]
      ,[Insurance Provider]
      ,[Billing Amount]
      ,[Room Number]
      ,[Admission Type]
      ,[Discharge Date]
      ,[Medication]
      ,[Test Results]
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






# 2. 'Date of Admission' and 'Discharge Date' columns  

Standardize the date format in the 'Date of Admission' and 'Discharge Date' columns to YYYY-MM-DD. And just like the improvement on the name column, I considered several options, such as using the CAST and FORMAT functions or utilizing a UDF. Although a UDF might not be strictly necessary, I still wanted to test how far my understanding of UDFs has progressed. Additionally, I believe that, just like CTE simplifies repetitive tasks, UDFs can also be very useful in the future when the same process needs to be executed repeatedly.

- Method 1 (Use CAST & FORMAT)

```sql
---  Date of Admission

UPDATE [dbo].[healthcare_dataset]
SET [Date of Admission] = CAST([Date of Admission] AS DATE)

UPDATE [dbo].[healthcare_dataset]
SET [Date of Admission] = FORMAT([Date of Admission], 'dd-MM-yyyy')


--- Discharge Date

UPDATE [dbo].[healthcare_dataset]
SET [Discharge Date] = CAST([Discharge Date] AS DATE)

UPDATE [dbo].[healthcare_dataset]
SET [Discharge Date] = FORMAT([Discharge Date], 'dd-MM-yyyy')
```

- Method 2 (Use UDF)
```sql
CREATE FUNCTION dbo.FormatDate
(
    @inputDate DATE
)
RETURNS NVARCHAR(10)
AS
BEGIN
    RETURN CONVERT(NVARCHAR(10), @inputDate, 120) -- Format: YYYY-MM-DD
END

-- Discharge Date

UPDATE [dbo].[healthcare_dataset]
SET  [Discharge Date]  = dbo.FormatDate([Discharge Date]);

-- Date of Admission

UPDATE [dbo].[healthcare_dataset]
SET [Date of Admission] = dbo.FormatDate([Date of Admission]);
```





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



# 4. Billing Amount Column

Fix the format to consistently show 2 decimal places for better readability. 

```sql
SELECT CAST(ROUND([Billing Amount], 2) AS DECIMAL (20,2))
FROM [dbo].[healthcare_dataset]

UPDATE [dbo].[healthcare_dataset]
SET [Billing Amount] = CAST(ROUND([Billing Amount], 2) AS DECIMAL (20,2))
```






# 5. Handle duplicate values 

The reason I placed this process at the end is that I first want to ensure the data is consistent before searching for duplicates. This is to avoid analysis errors, considering the raw data is quite messy, especially in patient and hospital names.

After checking, it turned out that there were many duplicate records that, upon further investigation, had identical information in all columns except for the **'Age' column**. This means that the patient's name, illness, admission date, and even discharge date were all the same, except for 'Age'. Such cases are actually very rare or may almost never happen in real life (I even asked my sister, who works in a hospital ICCU). However, since I know this is synthetic data, I will just take it as a learning experience.


```sql
WITH COBA1 AS (

-- Check Duplicate

/* The reason I used **GROUP BY** on all columns except 'Age' is that, otherwise, there could be up to four patients with
the same name appearing with the same room number or blood type, even though they are actually different patients.
Therefore, to accurately identify them as distinct individuals, I needed to differentiate them using more detailed information. */

SELECT Name,
     --Age
       Gender,
      [Blood Type],
      [Medical Condition],
      [Date of Admission],
       Doctor,
       Hospital,
      [Insurance Provider],
      [Billing Amount],
      [Room Number],
      [Admission Type],
      [Discharge Date],
       Medication,
      [Test Results],
       COUNT(*) AS Num_Duplicate 
FROM [dbo].[healthcare_dataset]
WHERE Name IS NOT NULL
GROUP BY Name ,Gender, [Blood Type],[Medical Condition], [Date of Admission],
         Doctor, Hospital, [Insurance Provider], [Billing Amount], [Room Number],
        [Admission Type], [Discharge Date], Medication,[Test Results]
HAVING  COUNT(*) > 1
),

/*I need to quantify the age variance caused by these duplicate entries (11,000 cases) to determine the most effective 
deduplication methodology. This statistical assessment will inform data remediation strategy. */

COBA2 AS (
SELECT *
FROM [dbo].[healthcare_dataset] H
WHERE EXISTS ( SELECT 1 
               FROM COBA1 C 
               WHERE C.Name = H.Name 
                   AND C.[Room Number] = H.[Room Number] 
                   AND C.[Date of Admission] = H.[Date of Admission]
                   AND C.[Discharge Date] = H.[Discharge Date]
                   AND C.Gender = H.Gender
                   AND C.[Medical Condition] = H.[Medical Condition]
			 )
--ORDER BY Name 

)

SELECT Name, MAX(AGE) - MIN(AGE) AS Age_Different
FROM COBA2
GROUP BY Name,Gender, [Blood Type], [Medical Condition],[Date of Admission],[Room Number], [Discharge Date]    
ORDER BY Age_Different DESC
```


/* After checking, it turns out that the largest age difference is only about 5 years, so I decided to use 
MEDIAN instead of AVERAGE. Why is Median Better than Average (Avg) for This Case? Median is Not Affected by Outliers. 
If the age difference is small (example: [30, 31]), the median and average are almost the same. But if there is an input error 
(example: [30, 60]), the median (45) is safer than the average (45). */


-- Step 1: Identify duplicates and calculate the median

```sql
--- 1. Apply median values directly in the update

WITH MedianData AS (
    SELECT 
        Name,  
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Age) OVER (
            PARTITION BY [Name], [Gender], [Blood Type], [Medical Condition], [Date of Admission],
                        [Doctor], [Hospital], [Insurance Provider], [Billing Amount], [Room Number],
                        [Admission Type], [Discharge Date], [Medication], [Test Results]
        ) AS MedianAge
    FROM [dbo].[healthcare_dataset]
    WHERE Name IS NOT NULL
	--ORDER BY Name
)

UPDATE H
SET H.Age = M.MedianAge
FROM [dbo].[healthcare_dataset] H
JOIN MedianData M ON H.Name = M.Name;
```

-- 2. Remove one of the two duplicate records, as I want to keep only a single entry.
```sql
WITH RecordsToDelete AS (
    SELECT 
        Name,
        ROW_NUMBER() OVER (
            PARTITION BY [Name], [Gender], [Blood Type], [Medical Condition], [Date of Admission],
                        [Doctor], [Hospital], [Insurance Provider], [Billing Amount], [Room Number],
                        [Admission Type], [Discharge Date], [Medication], [Test Results]
            ORDER BY Name  -- -- or another column as a tie-breaker
        ) AS RowNum
    FROM [dbo].[healthcare_dataset]
    WHERE Name IS NOT NULL
)

DELETE FROM [dbo].[healthcare_dataset]
WHERE Name IN (SELECT Name FROM RecordsToDelete WHERE RowNum > 1)
```



/* Handling NULL Values */

-- Check the number of null values

```sql
SELECT COUNT(*) AS Total_Rows,
	   COUNT(NAME) AS Total_NonNull,
	   COUNT(*) - COUNT(NAME) AS Null_Count
FROM [dbo].[healthcare_dataset]
```

/* After checking, I found around 1,000 null values, and these nulls exist across all columns. So, I have a few options: delete them, 
leave them as null, or replace them with other values. But I think I’ll go with the third option as a safe choice. */

```sql
UPDATE [dbo].[healthcare_dataset]
SET Name = ISNULL(Name,'0'),
	Age = ISNULL(Age,'0'),
	Gender = ISNULL(Gender,'0'),
	[Blood Type] = ISNULL([Blood Type],'0'),
	[Medical Condition] = ISNULL([Medical Condition],'0'),
	Doctor = ISNULL(Doctor,'0'),
	Hospital = ISNULL(Hospital,'0'),
	[Insurance Provider] = ISNULL([Insurance Provider],'0'),
	[Billing Amount] = ISNULL([Billing Amount],'0'),
	[Room Number] = ISNULL([Room Number],'0'),
	[Admission Type] = ISNULL([Admission Type],'0'),
	[Discharge Date] = ISNUlL([Discharge Date],'0'),
	Medication = ISNULL(Medication,'0'),
	[Test Results] = ISNULL([Test Results],'0')
```
