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

Cleaning Data in SQL Queries

*/

select *
from housing
limit 100

-- Standardize Date Format 

select saledate
from housing

alter table housing
alter column saledate type date using saledate:: date;

-- Populate propertyaddress data

so first we're gonna check does the column propertyaddress contain any null values.
And, after checking the null values in propertyaddress we found out that there is many null values
in it, and we dont want that happend, so we have to find a way to solved. We can see that if the parcelid
has the same value, then the propertyaddress value will also be the same.so something we can do is : 
If there is a null value in the column propertyaddress, then fill that null value with the value in the propertyaddress
column itself that has the same value as the parcelid."

we are gonna use self join
'''
select *
from housing
order by parcelid 


#dibaca : jika colom propertyaddres ditabel a null, maka isilah dia dengan propertyaddress yang ada di tabel b.

select a.parcelid,a.propertyaddress, b.parcelid,b.propertyaddress,COALESCE(a.propertyaddress, b.propertyaddress) 
from housing a
join housing b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
and a.propertyaddress is null
order by a.parcelid 


update housing a
set propertyaddress = coalesce(a.propertyaddress, b.propertyaddress)
from housing b
where a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
and a.propertyaddress is null;


-- Breaking out address into individual column(address, city,state)
select propertyaddress
from housing
'''
so, if take a look at it we are gonna realized that in propertyaddress column
there is a address and city name separated by a delimeter or a comma
'''

/* breaking out propertyaddres column into address & city */

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

/* breaking out owneraddress column into address, city, state */

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


-- Change Y and N to Yes and No in "Sold as Vacant" field

select distinct soldasvacant, count(soldasvacant)
from housing
group by 1
order by 2


update housing
set soldasvacant = case when soldasvacant = 'Y' then 'Yes'
						when soldasvacant = 'N' then 'No'
						else soldasvacant
						end
---------------------------------------------------------------
/* Note : we're not actually gonna remove the data that i wrote below from the actual data, because its kind of risky if we 
		  do it for real dataset. And also, as we can see in the table that we already set up the uniqueid as the primary key 
		  from the beginning which is means that there is no duplicate value in out primary key. but just in case if in some moment
		  we want to  remove the duplicate in a table, then  can to this.
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

