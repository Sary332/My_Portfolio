-- Create Table and data type

Create Table public.hr_analyticts
(
	satisfaction_level		real
   ,last_evaluation			real
   ,number_project			integer
   ,average_montly_hours	integer
   ,time_spend_company		integer
   ,work_accident			integer
   ,left_company			integer
   ,promotion_last_5years	integer
   ,department				character(15)
   ,salary					character(15)
);

--- Check Table

select *
from hr_analyticts
limit 1000

--- check unique Value in department & salary column

SELECT DISTINCT(department)
	 -- ,DISTINCT(salary)
FROM hr_analyticts

/*Calculate the average satisfaction level, last evaluation, number of projects, 
and average monthly hours worked for all employees. */

SELECT round(AVG(satisfaction_level):: numeric ,2) AS avg_satisfaction,
       round(AVG(last_evaluation):: numeric,2) AS avg_evaluation,
       round(AVG(number_project):: numeric,2) AS avg_projects,
       round(AVG(average_montly_hours):: numeric,2) AS avg_hours
FROM hr_analyticts;

/* Find the top 10% and bottom 10% performing employees based on the above metrics 
   and identify common characteristics. 
  
   Note: We can replace "satisfaction_level" with the other metrics to find the 
   		 top/bottom 10% performing employees based on those metrics. */
   
SELECT *
      ,CASE WHEN ROW_NUMBER() OVER (ORDER BY satisfaction_level DESC) <= 0.1 * COUNT(*) OVER() THEN 'Top 10%'
            WHEN ROW_NUMBER() OVER (ORDER BY satisfaction_level ASC) <= 0.1 * COUNT(*) OVER() THEN 'Bottom 10%'
            ELSE 'Middle 80%'
            END AS performance_category
FROM hr_analyticts
ORDER BY satisfaction_level DESC;


/* Calculate the correlation between satisfaction level and last evaluation, 
   and determine if there is a relationship between these two metrics and the 
   number of projects and average monthly hours worked. */
/* Note: This query will calculate the correlation between satisfaction level and 
   the other metrics. We can replace "satisfaction_level" with the other metrics 
   to calculate the correlation between those metrics. */

 SELECT 
	   round(CORR(satisfaction_level, last_evaluation):: numeric,2) AS satisfaction_evaluation_corr
      ,round(CORR(satisfaction_level, number_project):: numeric,2) AS satisfaction_projects_corr
      ,round(CORR(satisfaction_level, average_montly_hours):: numeric,2) AS satisfaction_hours_corr
FROM hr_analyticts;


 

