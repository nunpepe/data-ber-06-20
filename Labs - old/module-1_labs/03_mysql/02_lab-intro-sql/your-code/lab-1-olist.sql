-- Database: "olist"
-- Lab: SQL - LAB 2
-- Link to lab: https://github.com/ironhack-datalabs/data-ber-06-20/blob/master/Labs/module-1_labs/03_mysql/02_lab-intro-sql/lab-2-olist.md

-- 1. From the marketing_qualified_leads table, find the earliest and latest first_contact_date.

SELECT MIN(DATE(first_contact_date)), MAX(DATE(first_contact_date))
FROM marketing_qualified_leads;

-- 2. From the marketing_qualified_leads table, find the top 3 most frequent origin types for all first_contact_date entries in 2018.d

SELECT origin, 
			COUNT(mql_id) AS total
FROM marketing_qualified_leads
WHERE YEAR(first_contact_date) = 2018
GROUP BY origin
ORDER BY COUNT(mql_id) DESC
LIMIT 3;

-- 3. From the marketing_qualified_leads table, find the first_contact_date with the highest number of mql_id entries and state the number of entries on that date.

SELECT first_contact_date, 
			COUNT(mql_id) 				AS total
FROM marketing_qualified_leads
GROUP BY first_contact_date
ORDER BY total DESC;


-- 4. From the products table, find the name and count of the top 2 product category names.

SELECT 
	product_category_name 	AS category,
	COUNT(product_id)     	AS product
FROM products
GROUP BY category
ORDER BY product DESC
LIMIT 2;

-- 5. From the products table, find the product_category_name with the highest recorded product weight in grams.

SELECT 
	product_category_name 			AS category,
	product_weight_g 					AS g
FROM products
ORDER BY product_weight_g DESC
LIMIT 1;


-- 6. From the products table, find the product_category_name with the greatest sum of dimensions including length, height and width in centimeters.

SELECT
	product_category_name 																AS category,
	product_length_cm + product_width_cm + product_height_cm 	AS total_cm
FROM products
ORDER BY total_cm DESC
LIMIT 1;

-- 7. From the order_payments table, find the payment_type with the greatest number of order_id entries and the count of that payment type.

SELECT 
	payment_type 				AS payment,
	COUNT(payment_type)	AS count_type,		
	COUNT(order_id)			AS total_orders
FROM order_payments
GROUP BY payment
ORDER BY total_orders DESC
LIMIT 1;

-- 8. From the order_payments table, find the highest payment value for an individual order_id.

SELECT 
	MAX(payment_value)			AS highest_payment_value
FROM order_payments;

-- 9. From the sellers table, find the 3 seller states with the greatest number of distinct seller cities.

SELECT 
	COUNT(DISTINCT seller_city) 		AS unique_cities,
	seller_state
FROM sellers
GROUP BY seller_state
ORDER BY unique_cities DESC
LIMIT 3;