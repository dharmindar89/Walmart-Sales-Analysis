-- ---------------Wallmart Sales Data Analysis Project-----------------
-- create a schema--
CREATE DATABASE IF NOT EXISTS SalesDataWalmart;

-- create a custom table--
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
	branch VARCHAR(5) NOT NULL,
	city VARCHAR(30) NOT NULL,
	customer_type VARCHAR(30) NOT NULL,
	gender VARCHAR(10) NOT NULL,
	product_line VARCHAR(100) NOT NULL,
	unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6, 4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10, 2) NOT NULL,
    gross_margin_percentage FLOAT(11,9) NOT NULL,
    gross_income DECIMAL(12, 2) NOT NULL,
    rating FLOAT(2, 1) NOT NULL
);


-- -------------------------------------------------------------------------------
-- ------------------------------Feature Engineering------------------------------
-- 1. time_of_day: add a new column

SELECT time,
	(
    CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
	) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day =(
				CASE
					WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
					WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
					ELSE "Evening"
				END
                );
                
-- 2. day_name: add a new column
SELECT date,
DAYNAME(date) AS day_name
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name=	DAYNAME(date);
            
-- 3. month_name: add a new column
SELECT date,
MONTHNAME(date) AS month_name
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = MONTHNAME(date);
-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
-- -------------------------Generic Questions-------------------------------------

-- 1. How many unique cities does the data have?
SELECT DISTINCT city FROM sales;		-- 3 cities--

-- 2. In which city is each branch?
SELECT DISTINCT branch FROM sales;
SELECT DISTINCT city,branch FROM sales;
-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
-- -------------------------Product Questions-------------------------------------

-- 1. How many unique product lines does the data have?
SELECT DISTINCT product_line FROM sales;		#6

-- 2. What is the most common payment method?
SELECT payment_method, COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;		#cash method is most common

-- 3. What is the most selling product line?
SELECT product_line, COUNT(product_line) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;		#Fassion accessiories - 178

-- 4. What is the total revenue by month?
SELECT month_name, ROUND(SUM(total), 2) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;		#January: 116291.87, March: 108867.15, February: 95727.38

-- 5. What month had the largest COGS?
SELECT month_name, SUM(cogs) AS cogs_total
FROM sales
GROUP BY month_name
ORDER BY cogs_total DESC;		#January had largest cogs(110754.16)

-- 6. What product line had the largest revenue?
SELECT product_line, SUM(total) AS product_line_revenue
FROM sales
GROUP BY product_line
ORDER BY product_line_revenue DESC;		#Food and beverages had the largest revenue(56144.8440)

-- 7. What is the city with the largest revenue?
SELECT city, SUM(total) as city_revenue
FROM sales
GROUP BY city
ORDER BY city_revenue DESC;		#Naypyitaw has largest revenue(110490.7755)

-- 8. What product line had the largest VAT?
SELECT product_line, SUM(VAT) AS product_line_vat
FROM sales
GROUP BY product_line
ORDER BY product_line_vat DESC;		#Food and beverages had largest VAT(2673.5640)

-- 9. Which branch sold more products than average product sold?
SELECT branch, SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);	#branch A sold more products, 1849

-- 10. What is the most common product line by gender?
SELECT gender, product_line, COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;	#Fassion accessories is the most common product_line (96) by Female

-- 11. What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) AS  avg_rating		#ROUND function puts number of values we give it, in decimal part 
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;
-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
-- -------------------------Sales Questions---------------------------------------
-- 1. Number of sales made in each time of the day per weekday
SELECT time_of_day, COUNT(*) AS total_sales
FROM sales
WHERE day_name="Wednesday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- 2. Which of the customer types brings the most revenue?
SELECT customer_type, SUM(total) AS most_revenue_by_customer
FROM sales
GROUP BY customer_type
ORDER BY most_revenue_by_customer DESC; 	#customer_type 'member' brought the most revenue '163625.1015'

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
SELECT city, SUM(VAT) AS VAT_by_city
FROM sales
GROUP BY city
ORDER BY VAT_by_city DESC;		#Naypyitaw has largest VAT '5261.4655'

-- 4. Which customer type pays the most in VAT?
SELECT customer_type, SUM(VAT) AS VAT_by_customer
FROM sales
GROUP BY customer_type
ORDER BY VAT_by_customer DESC;		#customer_type 'member' pays the most VAT '7791.6715'
-- -------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------
-- -------------------------Customer Questions------------------------------------
-- 1. How many unique customer types does the data have?
SELECT DISTINCT customer_type
FROM sales;						#There are two unique customer types

-- 2. How many unique payment methods does the data have?
SELECT DISTINCT payment_method
FROM sales;						#Three unique payment methods i.e Credit card, Ewallet, Cash

-- 3. What is the most common customer type?
SELECT customer_type, COUNT(*) AS customer_cnt
FROM sales
GROUP BY customer_type
ORDER BY customer_cnt DESC;		#Member is the leading customer type '499'

-- 4. Which customer type buys the most?
SELECT customer_type, SUM(quantity) AS most_qty_by_customer
FROM sales
GROUP BY customer_type
ORDER BY most_qty_by_customer DESC;				#customer_type 'Member' bought most product (2773)

-- 5. What is the gender of most of the customers?
SELECT gender, COUNT(gender) AS customer_gender
FROM sales
GROUP BY gender
ORDER BY customer_gender DESC;			#most of the customers are male (498)

-- 6. What is the gender distribution per branch?
SELECT gender, COUNT(gender) AS gender_per_branch
FROM sales
WHERE branch="A"			#You can put any branch here
GROUP BY gender
ORDER BY gender_per_branch DESC;

-- 7. Which time of the day do customers give most ratings?
SELECT time_of_day, COUNT(rating) AS rating_in_time
FROM sales
GROUP BY time_of_day
ORDER BY rating_in_time DESC;			#At evening, customers give most ratings '429'(rating count at eve)

-- 8. Which time of the day do customers give most ratings per branch?
SELECT time_of_day, COUNT(rating) AS rating_in_time
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY rating_in_time DESC;		#most ratings, per branch, at evening

-- 9. Which day of the week has the best avg ratings?
SELECT day_name, AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;			#Monday has the best average ratings

-- 10. Which day of the week has the best average ratings per branch?
SELECT day_name, AVG(rating) AS avg_rating
FROM sales
WHERE branch="C"
GROUP BY day_name
ORDER BY avg_rating DESC;		#branch A: Friday, branch B: Monday, branch C: Saturday


