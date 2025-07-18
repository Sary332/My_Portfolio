SELECT *
FROM COVID_DEATH ;

--- select the data thatwe are going to using 

select 
	location
	,date
	,population 
	,total_cases
	,new_cases
	,total_deaths
from 
	covid_death
order by 1,2

--looking at total cases vs total death
-- shows likelyhood of dying if you contract covid in your country
select 
	location
	,date
	,total_cases
	,total_deaths
	,(total_deaths / total_cases)*100 AS deaths_percentage 
from 
	covid_death
where location = 'Indonesia'
order by 1,2

-- looking at total cases vs population
-- shows what percentage of population got covid

select 
	location
	,date
	,population 
	,total_cases
	,round((100.0 * total_cases / population),2) AS deaths_percentage 
from 
	covid_death
where location = 'Indonesia'
order by 1,2

-- looking at country with highest infection rate compared to population

select 
	location
	,population 
	,max(total_cases) as highest_infection_country
	,max(round((100.0 * total_cases / population),2)) AS percentage_population_infected
from 
	covid_death
group by 1,2
having 
		population is  null
		and max(total_cases) is null
		and max(round((100.0 * total_cases / population),2)) is  null
order by 4 DESC

--countries with highest death count per population 

select 
	location
	,max(total_deaths) as total_death_count
from 
	covid_death
group by 1
--having max(total_deaths)  is not null
order by 2 desc

----------------------------------------------------------
--- LEST BREAK THINGS DOWN BY CONTINENT

select 
	continent
	,max(total_deaths) as total_death_count
from 
	covid_death
where continent is not null
group by 1
order by 2 desc

--- showing the continen with the highest 
death count per population

select 
	continent
	,max(total_deaths) as total_death_count
from 
	covid_death
where continent is not null
group by 1
order by 2 desc

--- GLOBAL NUMBERS

select 
	sum(new_cases) as total_cases
	,sum (new_cases) as total_death
	,round(100.0 * (sum(new_deaths) / sum(new_cases)),2) as Death_percentage
from
	covid_death
where
	continent is not null
order by 1,2

--- looking at total population vs vaccination

select 
	 d.continent
	,d.location
	,d.date
	,d.population
	,v.new_vaccinations
	,sum(v.new_vaccinations) over(partition by d.location order by d.location, d.date ) as rolling_people_vaccinated
from 
	covid_death d
join
	covid_vaccination v
on 
	d.location = v.location 
	and d.date = v.date
where d.continent is not null
--order by 2,37

--- USE CTE
WITH pop_vs_vac (continent,location,date,population,new_vaccinations,rolling_people_vaccinated)
as
(
select 
	 d.continent
	,d.location
	,d.date
	,d.population
	,v.new_vaccinations
	,sum(v.new_vaccinations) over(partition by d.location order by d.location, d.date ) as rolling_people_vaccinated
from 
	covid_death d
join
	covid_vaccination v
on 
	d.location = v.location 
	and d.date = v.date
where d.continent is not null
--order by 2,3
)
select 
	*
	,round((rolling_people_vaccination / population)* 100,2) 
from
	pop_vs_vac

--- TEMP TABLE

CREATE TABLE public.percent_population_vaccinated
(
	continent text
	,location text
	,date date
	,population numeric
	,new_vaccination numeric
	,rolling_people_vaccinated numeric
) ;

INSERT INTO percent_population_vaccinated
(select 
	 d.continent
	,d.location
	,d.date
	,d.population
	,v.new_vaccinations
	,sum(v.new_vaccinations) over(partition by d.location order by d.location, d.date ) as rolling_people_vaccinated
from 
	covid_death d
join
	covid_vaccination v
on 
	d.location = v.location 
	and d.date = v.date
where d.continent is not null
--order by 2,3 
) ;

select 
	*
	,round((rolling_people_vaccinated / population)* 100,2) 
from
	percent_population_vaccinated

---CREATING VIEW TO STORE DATA FOR DATA VISUALIZATION

CREATE VIEW percent_populationS_vaccinated 
AS  
select 
	 d.continent
	,d.location
	,d.date
	,d.population
	,v.new_vaccinations
	,sum(v.new_vaccinations) over(partition by d.location order by d.location, d.date ) as rolling_people_vaccinated
from 
	covid_death d
join
	covid_vaccination v
on 
	d.location = v.location 
	and d.date = v.date
where d.continent is not null
--order by 2,3 

----------------------------------------------
SELECT *
FROM percent_populations_vaccinated
