.editorconfig

[*]
indent_style = space
indent_size = 4

--------------------------------------------------------------- Nashville Housing Data Cleaning ------------------------------------------------------------------------
CREATE TABLE Housing 
			(
			    UniqueID 			INT Primary Key,
			    ParcelID			Varchar(50),
			    LandUse				Varchar(50),
			    PropertyAddress		Varchar(100),
			    SaleDate			Timestamp,
			    SalePrice			Money,
			    LegalReference		Varchar(50),
			    SoldAsVacant		Varchar(5),
			    OwnerName			Varchar(100),
			  	OwnerAddress		Varchar(100),
			  	Acreage				Decimal,
			  	TaxDistrict			Varchar(100),
			  	LandValue			INT,
			  	BuildingValue		INT,
			  	TotalValue			INT,
			  	YearBuilt			INT,
			  	Bedrooms			INT,
			  	FullBath			INT,
			  	HalfBath			INT
			);
------------------------------------------------------------------------------------
/*
 
Cleaning Data Using PostgreSQL

*/

---- Cheking the table
select *
from housing
limit 100

---- Standardize Date Format 

select saledate  
from   housing

alter table housing
alter column saledate type date using saledate :: date;

-- Populate propertyaddress data
/*
so first I'm gonna check does the column propertyaddress contain any null values. And, after checking the null values in propertyaddress, I found out that there is many null values in it, and we dont want that happend, so we have to find a way to solved. We can see that if the "parcelid" has the same value, then the "propertyaddress" value will also be the same. So something we can do is : If there is a null value in the column propertyaddress, then fill that null value with the value in the propertyaddress column itself that has the same value as the parcelid.

I'm gonna use self join
*/

-- a) Test the query using coalesce and compare the original values that are still null with the values that have been filled using the coalesce function.

select a.parcelid,a.propertyaddress, b.parcelid,b.propertyaddress, COALESCE(a.propertyaddress, b.propertyaddress) 
from housing a
join housing b
on  a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
and a.propertyaddress is null
order by a.parcelid 

-- b) Update the data
    
update housing a
set propertyaddress = coalesce(a.propertyaddress, b.propertyaddress)
from housing b
where a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
and a.propertyaddress is null;


---- Breaking out address into individual column(address, city,state)
/*
If take a look at it we are gonna realized that in propertyaddress column
there is a address and city name separated by a delimeter or a comma
*/

-- a) Breaking out propertyaddres column into address & city */

alter table housing
add column property_address varchar(50)

update housing
set property_address = split_part(propertyaddress,',',1)
---------------------------------------------------------------
alter table housing
add column property_city varchar(50)

update housing
set property_city = split_part(propertyaddress,',',2)
---------------------------------------------------------------

-- b) Breaking out owneraddress column into address, city, state 

alter table housing
add column owner_address varchar(50)

update housing
set owner_address = split_part(owneraddress,',',1)
---------------------------------------------------------------
alter table housing
add column owner_city varchar(50)

update housing
set owner_city = split_part(owneraddress,',',2)
---------------------------------------------------------------
alter table housing
add column owner_state varchar(5)

update housing
set owner_state = split_part(owneraddress,',',3)


---- Change Y and N to Yes and No in "Sold as Vacant" field
    
-- a) Checking and counting how many types of descriptions are there in the column 'soldasvacant'
    
select distinct soldasvacant, count(soldasvacant)
from housing
group by 1
order by 2

-- b) Update column
    
update housing
set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
						when soldasvacant = 'N' then 'No'
						else soldasvacant
						end
---------------------------------------------------------------
/* Note : I won't actually execute the query provided below on the real dataset to remove the data. It carries a certain level of risk to do so on actual data.                       Furthermore, as we can observe from the table, we initially established the uniqueid as the primary key, which ensures the absence of duplicate values in this              crucial field. Nevertheless, there might be scenarios where we decide to eliminate duplicates in the table at some point in the future, and if such a need                  arises, we can follow this approach.
*/

-- Remove duplicates using windows function

with duplicate_values as (
		select *,
		row_number() over(partition by parcelid,
						 			   propertyaddress,
						 			   saleprice,
						 			   sales_date,
						 			   legalreference
						  order by uniqueid
						 )row_num
		from housing
		)
delete 
from duplicate_values
where row_num > 1
		
-- Delete Unused column 
/* 
We delete propertyaddress and owneraddress column bcuz we already update both of this column into readable data that we've done 
before in "Breaking out address into individual column(address, city,state)" cleaning process. 
*/


alter table housing 
drop column propertyaddress 

alter table housing 
drop column owneraddress
