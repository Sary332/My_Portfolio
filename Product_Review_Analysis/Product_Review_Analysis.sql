-----------------------Customer Satisfaction and Product Reviews Analysis------------------------


------------------------------------------------Cleaning Process Using Excel--------------------------------------------------
 '''
Customers Table :
	 1. Correct the city name in the customer_city column using the sort & filter feature, then find & replace.
	 2. Check duplicate value on customer_id using Conditional formating fiture
	 
Orders Table :
	 1. Remove the 'order_approved_at' column due to many null values.
	 2. Check duplicate value on order_id using Conditional formating fiture
	 3. Remove the 'order_delivered_carrier_date' column due to many null values.
	 4. Retain the 'order_purchase_timestamp', 'order_delivered_customer_date', and 'order_estimated_delivery_date' columns as they can be taken as benchmarks 
	    for the arrival of goods according to estimates or even earlier, which can also affect customer reviews.

Product Table :
	 1. Check duplicate value on product_id using Conditional formating fiture
	 2. Translate the product_category_name column from Portuguese to English took from the table "product_kategory_name_English_translation" which has been bundled with other 
	    tables using the "find and replace" feature.
	 3. Remove the `product_name_length` column.        
	 4. Remove the `product_description_length` column. 
	 5. Remove the `product_photos_qty` column.
	 
** The 2 others table look okay 
*** NOTE : Even though some tables have been modified, we still keep the original files as backups.
'''

DROP TABLE IF EXISTS geolocation CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS order_review;
DROP TABLE IF EXISTS products CASCADE;

------------------------------------------------------Create Table and Import Data Using PostgreSQL----------------------------------------------------------

CREATE TABLE geolocation
(
	zip_code				INT,
	geolocation_lat			DOUBLE PRECISION,
	geolocation_lng			DOUBLE PRECISION,
	geolocation_city		VARCHAR(50),
	geolocation_state		VARCHAR(10)
);

CREATE TABLE customers 
(
	customer_id				VARCHAR(100) PRIMARY KEY,
	zip_code		        INT,
	customer_city			VARCHAR(50),
	customer_state			VARCHAR(10)
);

CREATE TABLE orders
(
	order_id				VARCHAR(100) PRIMARY KEY,
	customer_id				VARCHAR(100) REFERENCES customers(customer_id),
	order_status			VARCHAR(50),
	order_purchase			TIMESTAMP,
	order_delivered			TIMESTAMP,
	estimated_delivery		TIMESTAMP
);

CREATE TABLE order_review
(
	order_id				VARCHAR(100) REFERENCES orders(order_id),
	review_score			INT,
	review_comment_title	VARCHAR(100) NULL,
	review_comment_message  VARCHAR(1000) NULL,
	review_creation_date	TIMESTAMP,
	review_answer_timestamp	TIMESTAMP
);

CREATE TABLE products
(
	product_id				VARCHAR(100) PRIMARY KEY,
	product_category_name	VARCHAR(50),
	product_weight_g		INT,
	product_length_cm		INT,
	product_height_cm		INT,
	product_width_cm		INT
);

CREATE TABLE order_items 
(
	order_id				VARCHAR(100) REFERENCES orders(order_id),
	order_item_id	        INT,
	product_id				VARCHAR(100) REFERENCES products(product_id),
	shipping_limit_date		TIMESTAMP,
	price					DECIMAL(10,2),
	freight_value           DECIMAL(10,2)
);
------------------------------------------------Analysis Process Using PostgreSQL--------------------------------------------------

--Customer Review Sentiment:

-- What is the distribution of review scores in the dataset ?

	select review_score, count(*) as num_reviews
	from order_review
	group by 1
	order by 1 

-- What is the average review score with all respect to reviews_score ?

	select cast(avg(num_reviews) as DECIMAL(10, 2)) as avg_review_score
	from (
		  select review_score, count(review_score) as num_reviews
		  from order_review
		  group by 1
		  order by 1
		 )x

-- How many reviews fall into each rating category (e.g., 1 star, 2 stars, etc.)?

	select review_score, count(*) as num_reviews
	from order_review
	group by 1
	order by 2 desc
	
-- Can we identify any trends or patterns in the distribution of review scores?

	Create Visualize the Distribution
	
------------------------------------------------------------------------------------------------------------

--Top Positive and Negative Reviews:

--What are the top 10 positive reviews based on review scores and comments?

	select review_score, 
		   review_comment_title,
		   review_comment_message
	from order_review
	where review_score = 5
		  and review_comment_title is not null
		  and review_comment_message is not null
	limit 10
	
--What are the top 10 negative reviews based on review scores and comments ?

	select review_score, 
		   review_comment_title,
		   review_comment_message
	from order_review
	where review_score = 1
		  and review_comment_title is not null
		  and review_comment_message is not null
	limit 10

--Are there any common themes or issues mentioned in the negative reviews?
--NOTE : Because comment_title and comment_message are only available in Portuguese, after conducting the analysis, we still need to perform a translation to english for them.	

------------------------------------------------------------------------------------------------------------
--Geographical Analysis:

--How does customer satisfaction vary across different regions (e.g., cities or states)?
	
	select count(c.*) as num_customer,
		   g.geolocation_state as state,
		   count(case when review_score = 5 then 1 end) as "5 Star",
		   count(case when review_score = 4 then 1 end) as "4 Star",
		   count(case when review_score = 3 then 1 end) as "3 Star",
		   count(case when review_score = 2 then 1 end) as "2 Star",
		   count(case when review_score = 1 then 1 end) as "1 Star"
	from      customers c
	left join geolocation g on c.zip_code = g.zip_code
	join 	  orders o on o.customer_id = c.customer_id
	join 	  order_review r on r.order_id = o.order_id
	group by 2
	order by 1 desc

--Which regions have the highest average review scores, and which have the lowest?
  
    select g.geolocation_state as state,
           cast(avg(r.review_score) as decimal(5,2)) as avg_review_score
	from      customers c
	left join geolocation g on c.zip_code = g.zip_code
	join 	  orders o on c.customer_id = o.customer_id
	join 	  order_review r on o.order_id = r.order_id
	group by 1
	order by 2 desc;

  
------------------------------------------------------------------------------------------------------------
--Product Attributes and Reviews:

--Are there any specific product attributes that correlate with higher review scores?
		 
		select product_category_name as category,
		   review_score,
		   count(review_score) as num_review,
		   cast(avg(extract(day from age(o.order_delivered, o.order_purchase))) as int) as avg_shipping_duration,
		   cast(avg(extract(day from age(o.estimated_delivery, o.order_purchase))) as int) as estimated_delivery_duration,
		   cast(avg(p.product_weight_g) as int) as weight_gram
		from 	  orders o
		left join order_items i on i.order_id = o.order_id
		join 	  order_review r on i.order_id = r.order_id
		join 	  products p on i.product_id = p.product_id
		--where review_score = 5
		group by 1,2
		order by 3 desc
		--limit 100

--Can we identify any trends in product attributes mentioned in reviews?

------------------------------------------------------------------------------------------------------------
--Time-based Analysis:
 
--How has customer satisfaction evolved over time ?
	
	select extract(year from review_creation_date) as years,
		   case 
		   		when extract(month from review_creation_date) in (1,2,3) then 'Q1'
				when extract(month from review_creation_date) in (4,5,6) then 'Q2'
				when extract(month from review_creation_date) in (7,8,9) then 'Q3'
				when extract(month from review_creation_date) in (10,11,12) then 'Q4'
			end as Quarter,
			--cast(avg(review_score) as decimal(5,2)) as avg_review_score	
			count(review_score)  as review_score
	from order_review	
	where extract(year from review_creation_date) in (2016,2017,2018)
	group by 1,2
	order by 1,2
	

--Are there any significant changes in review scores over the years ?

	select extract(year from  review_creation_date) as year,
       	       extract(month from review_creation_date) as month,
       	       cast(avg(review_score) as decimal(5,2)) as rata_rata_skor
	from order_review
	group by year, month
	order by  year, month;

	

------------------------------------------------------------------------------------------------------------
--Recommendations for Improvement:

--Based on the analysis, what are the common issues or areas for improvement identified from negative reviews ?
--What are some actionable recommendations to enhance customer satisfaction and product quality?
