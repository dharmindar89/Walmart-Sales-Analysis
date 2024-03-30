Problem Statement:
The major aim of this project is to gain insights and to improve its sales into the sales data of three cities i.e. 
Yangon, Naypyitaw and Mandalay, Walmart to understand how sales strategies can be improved and optimized 
by understanding the different factors that affect sales of the different branches.

About Project:
This project aims to explore the Walmart Sales data to understand top performing branches and products, 
sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be 
improved and optimized. The dataset was obtained from the 
[Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

About Data:
This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, 
Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                     | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method          | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |


Analysis List:
1. Product Analysis
2. Sales Analysis
3. Customer Analysis

Approach Used:--
1. Data Wrangling: Created a database named 'SalesDataWalmart', then created a table 'sales' with 17 columns and inserted data into
2. this tables from a csv file. While creating table I set coumns as ''NOT NULL' so null or missing values are filtered out.
3. Feature Engineering: This helped generate some new columns(`time_of_day`,`day_name` and `month_name`) from existing ones.
4. Exploratory Data Analysis (EDA): Performed Exploratory data analysis is done to answer the listed questions and aims of this project.

Business questions to answer:

Generic Question:
1. How many unique cities does the data have?
2. In which city is each branch?

Product Questions:
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest VAT?
9. Which branch sold more products than average product sold?
10. What is the most common product line by gender?
11. What is the average rating of each product line?

Sales Questions:
1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
4. Which customer type pays the most in VAT?

Customer Questions:
1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day of the week has the best avg ratings?
10. Which day of the week has the best average ratings per branch?

Key Skills:
MySQL, Feature Engineering, Data Analysis

Project Insights:
> Fashion accessories is the top selling product line by women
> Food and beverages had the largest revenue compared to other product lines
> The city Naypyitaw was leading by revenue compared to other 2 cities
> Branch A sold more products compared to other 2 branches i.e. B and C
> In most of the days, sales occurred at evening with most ratings
> Registered members brought the most revenue

Final conclusion to improve sales:
Target the registered members living in the city Naypyitaw near branch A by showing them ads/offers/coupons mostly in the evening. 
Also give deals on 'Fashion accessories' as it is top selling product line by women.
