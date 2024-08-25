CREATE DATABASE IF NOT EXISTS salesDatabase;

CREATE TABLE IF NOT EXISTS sales(
      invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
      branch VARCHAR(5) NOT NULL,
      city VARCHAR(30) NOT NULL,
      customer_type VARCHAR(30) NOT NULL,
      gender VARCHAR(10) NOT NULL,
      product_line VARCHAR(100) NOT NULL,
      unit_price DECIMAL(10,2) NOT NULL,
      quantity INT NOT NULL,
      VAT FLOAT(6, 4) NOT NULL,
      total DECIMAL(12,4) NOT NULL,
      date DATETIME NOT NULL,
      time TIME NOT NULL,
      payment_method VARCHAR(15) NOT NULL,
      cogs DECIMAL (10,2) NOT NULL,
      gross_margin_pct FLOAT(11,9),
      gross_income DECIMAL(12,4) NOT NULL,
      rating FLOAT (2, 1)
      
      
      
      
      );
      
      
    #  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------TIME_OF_DAY--------------
SELECT 
     time,
     (CASE
        WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
        END
     ) AS time_of_date
FROM Sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (
CASE
        WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
        END
);

# day_name

SELECT 
     date,
     DAYNAME(date) AS day_name
FROM sales;


ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


#month_name

SELECT 
    date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = MONTHNAME(date);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------

---------------------------#GENERIC-----------------------------------------------------------

#How many unique cites does the data have ?
 SELECT 
      DISTINCT city 
FROM sales;

 SELECT 
      DISTINCT branch 
FROM sales;
#In which city each branch is
SELECT  DISTINCT city,
     branch
FROM sales;


-----------------------------------------------------------------------------------------------------
#--------------------------------PRODUCTS------------------------------------------------------------
 #How many unique product lines does the data have ?
 
 SELECT 
     COUNT(DISTINCT product_line)
FROM sales;

# WHAT IS THE MOST COMMON PAYMENT METHOED
SELECT payment_method , COUNT(*)AS no_of_times_used
FROM SALES
GROUP BY payment_method 
ORDER BY COUNT(*) DESC
#LIMIT 1

;

# What is most selling product line?
SELECT 
     product_line , COUNT(*)AS cnt
FROM SALES
GROUP BY product_line 
ORDER BY COUNT(*) DESC
LIMIT 1;

# What is total revenue by month ?
SELECT 
     month_name AS month,
     SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;
;

# What month had the largest cogs ?
SELECT 
     month_name AS month,
     SUM(cogs) AS cogs
FROM sales
GROUP BY month_name
ORDER BY cogs DESC ;

# What Product line has the largest revenue ?
SELECT
    product_line,
    SUM(total) AS total_revenue
FROM sales 
GROUP BY product_line
ORDER BY total_revenue desc;

# What city had the largest revenue?
SELECT
    city,
    SUM(total) AS total_city_revenue
FROM sales 
GROUP BY city
ORDER BY total_city_revenue desc;

#What product line had the largest VAT ?
SELECT
    product_line,
    AVG(VAT) AS avg_tax
FROM sales 
GROUP BY product_line
ORDER BY avg_tax DESC;

#Fetch each product line showing "Good", "Bad".
 SELECT product_line,
ROUND(AVG(total),2) AS avg_sales,
(CASE
WHEN AVG(total) > (SELECT AVG(total) FROM sales) THEN "Good"
ELSE "Bad"
END)
AS Remarks
FROM sales
GROUP BY product_line;




# Which branch sold more products than average product sold
SELECT branch, SUM(quantity) AS qty

FROM sales
GROUP BY branch 
HAVING SUM(quantity) > (SELECT AVG (quantity) FROM sales);


# What is the most common product line by gender
SELECT 
    gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;
    
-- --------------------------------------------------------------------------------------------------
-- -------------------------------------Sales ------------------------------------------------------


-- Number of sales made in each time of the day per weekday
SELECT 
time_of_day,
COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Monday"
GROUP BY time_of_day
ORDER BY TOTAL_SALES DESC;

# Which Type of customer brings most revenue

SELECT customer_type, SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

#Which city has largest value added tax(VAT)
SELECT city , MAX(VAT) AS VAT
FROM sales
GROUP BY city
ORDER BY city DESC; 

# Which customer type pays most in VAT
SELECT customer_type , AVG(VAT) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;
-- --------------------------------------------------------------------------------------------------
-- --------------------------------CUSTOMER--------------------------------------------------
# How many unique customertypes the data have?
SELECT DISTINCT customer_type
FROM sales;

# How many unique payment_method types the data have?
SELECT DISTINCT payment_method
FROM sales;

# What is the most common customer type ?
SELECT customer_type  AS Most_common_customer ,
       COUNT(*) AS No_of_times_customer_appeared
FROM sales
GROUP BY Most_common_customer 
ORDER BY No_of_times_customer_appeared DESC
LIMIT 1;

# Which customer type have least total
SELECT customer_type , SUM(total) AS total_expense
FROM sales
GROUP BY customer_type
ORDER BY total_expense ASC

LIMIT 1;

-- What is the gender of most of the customers?
SELECT  gender, COUNT(gender) AS most_common_gender
FROM sales
GROUP BY gender
ORDER BY most_common_gender DESC;

# What is the gender distribution per branch ?
SELECT  gender, COUNT(*) AS gender_cnt
FROM sales
WHERE branch = "B"
GROUP BY gender
ORDER BY gender_cnt DESC;

# Which time of the day do customers give most ratings?
SELECT  time_of_day, AVG(rating) AS Avg_Rating
FROM sales
GROUP BY time_of_day
ORDER BY Rating DESC;

# Which time of the day customer give most ratings per branch?
SELECT
     time_of_day,
     AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

# Which day of the week has the best avg ratings?
SELECT  day_name, AVG(rating) AS Avg_Rating
FROM sales
GROUP BY day_name
ORDER BY Avg_Rating  DESC;


# Which day of the week has the best average ratings per branch?
SELECT  day_name, AVG(rating) AS Avg_Rating
FROM sales
WHERE branch = 'C'
GROUP BY day_name
ORDER BY Avg_Rating  DESC;




       















    



 







     
      
      



          
	
      
      
      
      
      