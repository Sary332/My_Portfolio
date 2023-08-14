/* Create table */

create table public.cyclistic
(
 	 ride_id character varying Primary Key
    ,rideable_type character(15)
    ,started_at timestamp
    ,ended_at timestamp 
    ,start_station_name character(100)
    ,start_station_id character varying 
    ,end_station_name character (100)
    ,end_station_id  character varying 
    ,start_lat float8
    ,start_lng float8
    ,end_lat float8
    ,end_lng float8
    ,member_casual character(10)
);


<img width="670" alt="Screenshot 2023-06-21 165837" src="https://github.com/Sary332/My_Portfolio/assets/110008177/99a67f81-dacb-4cfb-9714-be929cc4afd7">


/* checking the table */

select count(distinct ride_id)
from cyclistic

/* 
 We start cleaning the data by identifying null values, duplicate values,
 misspelled words, etc for each table we'll be joining after cleaning later
*/
--Count the number of rows of each table and duplikat ride_id

select 
	count(*) as count_rows
from cyclistic

-- sceck if any duplicate values in ride_id 
Select 
	ride_id 
from cyclistic
group by 1
Having count(*) > 1
  
-- Ensure there are no typos in the bike type and member type by doing a Group By

select rideable_type
from cyclistic
group by 1 ;

select member_casual
from cyclistic
group by 1 

/* Ensure there are no null values in the data that we're going to used  */

select count(*) from cyclistic where ride_id   			is null
select count(*) from cyclistic where rideable_type  	is null
select count(*) from cyclistic where started_at 		is null
select count(*)	from cyclistic where ended_at  			is null
select count(*) from cyclistic where start_station_name is null
select count(*) from cyclistic where end_station_name 	is null
select count(*) from cyclistic where start_station_id 	is null
select count(*) from cyclistic where end_station_id   	is null
select count(*) from cyclistic where start_lat 			is null
select count(*) from cyclistic where start_lng 			is null
select count(*) from cyclistic where end_lat 			is null
select count(*) from cyclistic where end_lng 			is null
select count(*) from cyclistic where member_casual		is null


/*
NOTE :

After checking for null values in each column in the table it was found that for columns start_station_name,
end_station_name, start_station_id, end_station_id, start_lat, start_lng, end_lat, end_lng there are many null 
values which can affect data integrity and data bias. so here I decided to take only a few tables that meet 
data integrity, namely ride_id, rideable_type, started_at, ended_at, member_casual. while for the start 
station name and end_station_name it will still be taken as a percentage of the station that the user has 
traveled the most or the least by considering removing the null value during visualization. if we remove the 
null value as a whole, we will lose about 15% of the data that can be used as profit considerations

*/

--- Count ride_length and day_of_week
select 
	 ride_id
	,rideable_type
	,started_at
	,to_char(started_at,'Day') as day_of_week
	,ended_at
	,ended_at - started_at as ride_length
	,start_lat
	,start_lng
	,end_lat
	,end_lng
	,member_casual
from cyclistic
limit 10

--- Calculate the number of users who are members and casual fot each type of bike

select 
	 rideable_type
	,count(case when member_casual = 'member' then 1 else null end) as num_member
	,count(case when member_casual = 'casual' then 1 else null end) as num_casual
from cyclistic
group by 1
order by 1 desc

/* Calculate the day of the week that each ride started.
   We can also immediately see the difference in the number
   of rides for each day of the week */

-- calculate the mean of ride_length from each users

select 
	 member_casual
	,round(avg(extract(epoch from ended_at - started_at)/60),2) as avg_minute_ride_length
from cyclistic
where ended_at - started_at > '60 second'
group by 1


-- calculate the avg ride_length for users by day_of_week

select 
	 member_casual
	,to_char(started_at, 'Day') as day_of_week
	,count(ride_id) as number_of_users
	,round(avg(extract(epoch from ended_at - started_at)/60),2) as avg_minute_ride_length
from cyclistic
group by 1,2
order by 3 desc

/*calculate the average daily bicycle loan for each user. Later we can
	see the comparison of weekends and weekdays */

	select 
	    member_casual
	   ,to_char(started_at, 'Day') as day_of_week
	   ,sum(case when member_casual = 'member' then 1
			     when member_casual = 'casual' then 1 
		         else null end) as amount_of_users
	from cyclistic
	group by 1,2
	order by 2
   
----  Let's check what percent of annual and casual riders per quarter
select 
	 member_casual
	,quarter
	,amount_of_users
	,round(100.0 *amount_of_users / (select count(*) from cyclistic),2) as percentage
from (
		select 
			 member_casual
			,(extract(year from started_at)::text || '.Q' || extract(quarter from started_at)::text) as quarter
			,count(ride_id) as amount_of_users
		from cyclistic
		group by 1,2
	 )x
order by 2

--- OVERVIEW OF CASUAL AND ANNUAL CHOICE OF RIDE IN A WEEK

select 
	 rideable_type
	,to_char(started_at, 'Day') as day_of_week
	,count(to_char(started_at, 'Day')) as number_of_bike
from cyclistic
where member_casual = 'casual'
group by 1,2
order by 3 desc


------ 10 MOST USED END & START STATION BY CASUAL ADN MEMBER RIDERS
select 
	 end_station_name  --/start_station_name
	,end_lat
	,end_lng
	,count(end_station_name) as modus
from cyclistic
where member_casual = 'casual' --/'member'
group by 1,2,3
order by 4 desc
limit 10

--- Count different amount between casual and member
select 
	member_casual
	,count(member_casual) as number_of_users
from cyclistic
group by 1

---Count different amount between bike types
select 
	rideable_type
	,count(rideable_type)
from cyclistic
group by 1
---
select 
	 member_casual
	,rideable_type
	,sum(case when ride_id = ride_id then 1 else null end) as amount_of_users
from cyclistic
group by 1,2

------------------------------------------------
select 
	 rideable_type
	,count(case when member_casual = 'member' then 1 else null end) as num_member
	,count(case when member_casual = 'casual' then 1 else null end) as num_casual
from cyclistic
group by 1
order by 1 desc


-----------------------------------------------
/* count member who borrowed less then 24 hours */
select
	  number_of_days
	 ,count(number_of_borrows) as number_of_borrows
from (
		select
			  *
			 ,extract('day' from ended_at - started_at)  as number_of_days
			 ,case when  ride_id =  ride_id then  1 else null end as number_of_borrows
		from cyclistic
	)x
where ended_at - started_at < '24 hours' and member_casual = 'casual' --/'member'
group by 1
order by 2 desc

-------------------------------



