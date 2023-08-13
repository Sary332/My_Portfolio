-----------------------Customer Satisfaction and Product Reviews Analysis-------------------------

'''
Purpose: The purpose of this project is to analyze customer satisfaction and product reviews to gain insights 
		 into the factors affecting customer sentiment and identify potential areas for improvement.

Task: Analyze the customer reviews and associated product attributes to understand customer satisfaction 
	  levels and product performance.
	  
Goal: The goal of this project is to provide actionable insights to the e-commerce company (Olist, in this case) 
	  to enhance customer satisfaction, identify popular product categories, and improve product offerings based
	  on customer feedback.
	  
Analysis Tasks:

Customer Review Sentiment: Analyze the distribution of review scores to understand the overall customer satisfaction 
						   level. Calculate the average review score to get an overall sentiment rating.

Product Category Sentiment: Determine which product categories receive the highest and lowest average review 
							scores. Identify the best and worst-performing product categories in terms of 
							customer satisfaction.

Top Positive and Negative Reviews: Identify the top positive and negative reviews based on review scores and 
								   comments. Analyze common themes or issues mentioned in negative reviews.

Geographical Analysis: Analyze customer satisfaction levels based on their location (e.g., city, state) 
					   to identify regional variations in sentiment.

Product Attributes and Reviews: Analyze the relationship between product attributes and review scores. 
								Determine if specific product attributes correlate with higher customer 
								satisfaction.

Time-based Analysis: Examine customer satisfaction trends over time to identify any significant changes 
					 in sentiment.

Recommendations for Improvement: Based on the analysis, provide recommendations to improve customer satisfaction
								 and address any common issues mentioned in negative reviews.

'''

DROP TABLE IF EXISTS geolocation CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS order_payments;
DROP TABLE IF EXISTS order_review;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS seller CASCADE;
DROP TABLE IF EXISTS order_items;

----------------------------------------------------------------------------------------------------------------

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


CREATE TABLE seller
(
	seller_id				VARCHAR(100) PRIMARY KEY,
	zip_code				INT,
	seller_city				VARCHAR(50),
	seller_state			VARCHAR(10)
);

CREATE TABLE order_items
(
	order_id				VARCHAR(100) REFERENCES orders(order_id),
	order_item_id			INT,
	product_id				VARCHAR(100) REFERENCES products(product_id),
	seller_id				VARCHAR(100) REFERENCES seller(seller_id),
	shipping_limit_date		TIMESTAMP,
	price					DECIMAL(10,2),
	freight_value			DECIMAL(10,2)
);

------------------------------------------------BATAS--------------------------------------------------

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
	
'''

The dataset has been categorized into different review score categories, ranging from 1 to 5 stars. From the analysis, it is 
evident that the majority of customers have expressed their satisfaction through high review scores, with 4 and 5-star ratings 
being the most frequent. This suggests that a substantial portion of customers has had positive experiences and perceptions of 
the products and services provided.

The average review score across all review scores further reinforces the positive sentiment observed. The average review score 
of 4.20 out of 5 indicates that, on average, customers have rated their experiences positively. This average score reflects a 
generally favorable impression of the products and services offered by the e-commerce platform.

Additionally, the distribution of reviews within each rating category offers a more detailed perspective. The highest number of 
reviews falls into the 5-star category, followed by the 4-star and 1-star categories. While the 3-star and 2-star categories have 
comparatively fewer reviews, it is worth noting that negative experiences, as indicated by 1 and 2-star ratings, form a smaller 
portion of the overall sentiment.

In conclusion, the analysis of customer review sentiment showcases a predominantly positive sentiment among customers, with a 
significant number of reviews falling into the higher rating categories. This positive sentiment underscores the success of the 
e-commerce platform in delivering products and services that resonate well with its customers. While there are instances of less 
favorable reviews, they constitute a smaller proportion of the overall sentiment. This analysis provides a comprehensive 
understanding of customer sentiments and offers insights for further enhancing customer experiences and satisfaction.

'''
------------------------------------------------------------------------------------------------------------

--Top Positive and Negative Reviews:

--What are the top 5 positive reviews based on review scores and comments?

	select review_score, 
		   review_comment_title,
		   review_comment_message
	from order_review
	where review_score = 5
		  and review_comment_title is not null
		  and review_comment_message is not null
	limit 5
	
--What are the top 5 negative reviews based on review scores and comments ?

	select review_score, 
		   review_comment_title,
		   review_comment_message
	from order_review
	where review_score = 1
		  and review_comment_title is not null
		  and review_comment_message is not null
	limit 5

--Are there any common themes or issues mentioned in the negative reviews?

  '''
  Under the topic of "Top Positive and Negative Reviews," the analysis of the top 5 positive and negative reviews provides 
  valuable insights into the sentiments and experiences of customers. 

  Starting with the positive reviews, it is evident that customers wh o awarded 5-star ratings have generally expressed high
  satisfaction and enthusiasm. Common themes among these positive reviews include recommendations, praise for product quality,
  and appreciation for reliable delivery. Customers emphasize the reliability of the sellers and their products, with comments
  such as "I highly recommend," "Excellent," and "Wonderful." These positive sentiments suggest a strong level of trust and 
  satisfaction with the e-commerce platforms offerings.
  
  On the other hand, the analysis of the top 5 negative reviews sheds light on some of the challenges and issues that customers
  have encountered. Negative reviews, predominantly featuring 1-star ratings, highlight issues such as product non-arrival, 
  incorrect or damaged items, delivery delays, and customer service problems. Customers express frustration with missing or 
  broken products, delays in receiving orders, and difficulties in resolving issues with customer service. The negative reviews 
  underscore the importance of addressing product quality, accurate delivery, and effective customer support to enhance overall 
  customer experiences.

  In conclusion, the analysis of the top positive and negative reviews reveals a range of sentiments expressed by customers. 
  Positive reviews highlight the e-commerce platforms strengths in delivering quality products and reliable service. Meanwhile, 
  negative reviews point to specific pain points that customers have encountered, emphasizing the need for improvements in areas
  such as product fulfillment, delivery, and customer support. By addressing the concerns raised in negative reviews, the 
  e-commerce platform has the opportunity to further elevate customer satisfaction and build lasting relationships with its 
  customers.
'''
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

--Can we identify any geographical patterns in customer sentiment?

'''
Under the topic of "Geographical Analysis," the examination of customer sentiment across different regions provides valuable 
insights into the variations of customer satisfaction based on location. The dataset has been segmented by states, allowing us to
understand how customer sentiment varies across different parts of the country.

The distribution of review scores across regions illustrates the overall sentiment levels within each state. It is evident that 
states like São Paulo ("SP"), Rio de Janeiro ("RJ"), and Minas Gerais ("MG") have the highest number of customers, reflecting 
their larger populations and higher order volumes. These states also exhibit a distribution that includes a notable proportion 
of 5-star reviews, indicating a generally positive sentiment among customers.

When considering the average review scores, we observe interesting variations in customer satisfaction. States such as São Paulo
("SP") and Paraná ("PR") have notably high average review scores, suggesting a higher level of customer satisfaction in these 
regions. Conversely, states like Roraima ("RR"), Maranhão ("MA"), and Alagoas ("AL") have relatively lower average review scores,
indicating potential areas for improvement in customer experiences.

Geographical patterns in customer sentiment become apparent when comparing the regions with the highest and lowest average review
scores. States with higher average review scores tend to be located in more economically developed and densely populated areas. 
This could indicate a correlation between economic prosperity, access to services, and higher customer satisfaction. On the other
hand, states with lower average review scores may require targeted efforts to enhance customer experiences and address any 
specific challenges.

In conclusion, the geographical analysis highlights intriguing trends in customer sentiment across different regions. The dataset
enables us to identify patterns in customer satisfaction, shedding light on areas of strength as well as opportunities for 
improvement. By recognizing these geographical patterns, the e-commerce platform can tailor its strategies to enhance customer
experiences and satisfaction, ultimately fostering stronger relationships with customers across diverse regions.

'''    
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
'''
Note :
	Hasil korelasi yang mendekati nol (0 koma sekian) menunjukkan bahwa ada sedikit atau tidak ada korelasi linear 
antara dua variabel yang Anda bandingkan. Dalam konteks analisis data, nilai korelasi mendekati nol mengindikasikan 
bahwa perubahan dalam satu variabel tidak secara linier berkaitan dengan perubahan dalam variabel lainnya.
'''


--Can we identify any trends in product attributes mentioned in reviews?
  Create Viz

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

  ''' i dont think we can do a measurement based on this Q, bcuz after the analysis above we ended up knowingthat we dont get a 
  	  complete data for Q1,Q2,Q3 in 2016 and Q4 in 2018. '''
	  
--Can we identify any seasonal trends in customer sentiment?
	
'''
Under the topic of "Time-based Analysis," the examination of customer satisfaction trends over different time periods provides us
with valuable insights into the evolving sentiment of customers. The presented data showcases how average review scores have 
changed over the years, segmented by quarters.

Upon analyzing the results, we can identify some intriguing patterns:

1. Fluctuations Across Quarters**: Looking at the average review scores across quarters, we notice some fluctuations. In 2017,
   for instance, the review scores were relatively high in the first and third quarters ("Q1" and "Q3"), dipped slightly in the 
   second quarter ("Q2"), and then rebounded in the fourth quarter ("Q4"). These variations could potentially be attributed to 
   seasonal factors, shifts in consumer behavior, or changes in business operations.

2. Dip in 2018: In the transition to 2018, there is a noticeable decline in average review scores. This suggests that there 
   might have been factors influencing customer sentiment during this period, which may warrant further investigation. Its 
   interesting to note that despite this dip, the average review scores saw an upward trend in the subsequent quarters of 2018.

3. Stability and Uptick: Overall, the data indicates that customer satisfaction has been relatively stable across the years, 
   with an uptick in average review scores in the latter part of 2018. This could be reflective of improvements made by the 
   business in response to customer feedback, leading to an enhanced customer experience.

4. Seasonal Considerations: While not explicitly detailed in the presented data, the variations across quarters could 
   potentially be indicative of seasonal trends. For instance, certain quarters might coincide with holidays or peak shopping 
   seasons, influencing customer sentiment. Further analysis would be necessary to confirm and understand the nature of these 
   seasonal patterns.

In conclusion, the time-based analysis reveals fluctuations in average review scores across different quarters and years. 
While there is no definitive pattern evident from the presented data, the variations suggest the influence of various external 
factors on customer sentiment. To comprehensively understand the seasonal trends and their implications, a more in-depth 
investigation could involve additional data points, external factors, and potentially qualitative insights from customers. 
This would enable businesses to tailor strategies and initiatives to effectively address seasonal shifts in customer sentiment 
and provide a consistently positive experience year-round.

'''
------------------------------------------------------------------------------------------------------------
--Recommendations for Improvement:

--Based on the analysis, what are the common issues or areas for improvement identified from negative reviews ?
--What are some actionable recommendations to enhance customer satisfaction and product quality?

'''
**Recommendations for Improvement:**

Based on the comprehensive analysis conducted on customer reviews, sentiment, product attributes, geographical patterns, and 
time-based trends, several common issues and areas for improvement have been identified from negative reviews. These 
recommendations aim to address these issues and enhance customer satisfaction and product quality:

Timely Delivery and Communication :

	Negative reviews often highlight delays in product delivery or lack of communication regarding shipment status. To improve 
customer satisfaction, businesses should prioritize timely delivery and provide real-time updates on order status. Implementing
effective tracking systems and proactive communication can alleviate customer concerns.

(1) Product Quality Assurance : 

	Instances of damaged or subpar products were mentioned in negative reviews. Implementing stringent quality assurance measures
can help ensure that products meet or exceed customer expectations. Regular quality checks, proper packaging, and thorough 
inspections before shipping can reduce the occurrence of such issues.

(2) Customer Support and Issue Resolution : 

	Negative reviews sometimes cite difficulties in reaching customer support or unsatisfactory resolution of issues. Enhancing 
customer support channels, providing prompt responses, and empowering support teams to swiftly address and resolve concerns can 
turn negative experiences into positive ones.

(3) Product Attributes Alignment :
	
	Analyzing product attributes and their correlation with review scores revealed that certain 
attributes positively impact customer satisfaction. Businesses should focus on these attributes while also gathering customer 
feedback to continually refine product offerings and align them with customer preferences.

(4) Regional Customer Sentiment : 

	Geographical analysis highlighted varying customer sentiment across different regions. Tailoring marketing strategies, product
offerings, and support services to regional preferences can enhance customer satisfaction and build stronger customer relationships.

(5) Seasonal Considerations : 

	Time-based analysis suggested potential seasonal trends in customer sentiment. Businesses can leverage this insight to 
anticipate and address shifts in customer behavior, adjust inventory levels, and plan targeted promotional campaigns during 
peak seasons.

(6) Review Score Distribution : 

	Understanding the distribution of review scores and identifying trends in customer sentiment can guide businesses in 
identifying areas for improvement. Regularly monitoring and analyzing review scores can provide early indicators of potential
issues and opportunities for enhancement.

(7) Translation and Communication :

	Language barriers were observed as a challenge in understanding customer comments. Implementing translation tools or providing
multilingual support can improve communication and ensure that customer feedback is accurately captured and addressed.

(8) Continuous Improvement Culture : 

	Overall, fostering a culture of continuous improvement based on customer feedback is crucial. Regularly collecting and 
analyzing customer reviews, engaging in data-driven decision-making, and acting upon insights can lead to ongoing enhancements
in customer satisfaction and product quality.

By addressing these common issues and implementing actionable recommendations, businesses can create a customer-centric approach 
that not only resolves existing concerns but also proactively improves the overall customer experience, fosters brand loyalty, 
and drives long-term success.

 
