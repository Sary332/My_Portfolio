# Purpose: 
The purpose of this project is to analyze customer satisfaction and product reviews to gain insights 
into the factors affecting customer sentiment and identify potential areas for improvement.

### Task: 
Analyze the customer reviews and associated product attributes to understand customer satisfaction 
levels and product performance.
	  
### Goal: 
The goal of this project is to provide actionable insights to the e-commerce company (Olist, in this case) to enhance customer satisfaction, identify popular product categories, and improve product offerings based on customer feedback.
	  
## Cleaning Process (Using Excel):

### Customers Table:
**1)** Correct city names using sort & filter, find & replace.
**2)** Check for duplicate customer IDs.

 ### Orders Table:
**1)** Remove 'order_approved_at' and 'order_delivered_carrier_date' columns.
**2)** Check for duplicate order IDs.

### Product Table:

**1)** Translate 'product_category_name' from Portuguese to English.
**1)** Remove unnecessary columns.

## CREATE TABLE and Import file using PostgreSQL:

Create tables for geolocation, customers, orders, order_review, products, and order_items.

## Analysis Tasks:

### Customer Review Sentiment:
**1)** Distribution of review scores.
**2)** The average review score for each product category

### Product Category Sentiment :
**1)** Product categories have the highest & lowest average review scores
**2)** Average review score calculation.
**3)** Categorize reviews by rating.

### Top Positive and Negative Reviews:
**1)** Identify top positive and negative reviews based on scores and comments.
**2)** Analyze common themes in negative reviews.

### Geographical Analysis:
**1)** Analyze satisfaction by region (city/state).
**2)** Identify regions with high/low average review scores.

### Product Attributes and Reviews:
**1)** Correlation between product attributes and review scores.
**2)** Trends in attributes mentioned in reviews.

### Time-based Analysis:
**1)** Customer satisfaction evolution over time.
**2)** Identify seasonal trends in review scores.

## Recommendations for Improvement:

****Timely Delivery and Communication :****
-->  Improve shipping efficiency and provide real-time updates.

****Product Quality Assurance :****	 
-->  Implement strict quality control and thorough inspections.

****Customer Support and Issue Resolution :****
--> Enhance support channels and resolution processes.

****Product Attributes Alignment :****	
--> Focus on attributes correlated with higher satisfaction.

****Regional Customer Sentiment :**** 
--> Tailor strategies to regional preferences.

****Seasonal Considerations:****	 
--> Prepare for peak seasons with staffing and inventory.

****Review Score Distribution :****	 
--> Use review scores to identify improvement areas.

****Translation and Communication :**** 
--> Implement multilingual support for accurate feedback.

****Continuous Improvement Culture :**** 
--> Foster a culture of improvement based on customer feedback.

By addressing these recommendations, the platform can enhance customer satisfaction, improve product quality, and build stronger relationships with customers.
