USE world;

# Data Cleaning
DELETE from sales
where Client LIKE ('%x');

# Drop records from 2015, as it's insignifcant in the calculation (Nov, Dec)
DELETE from sales
where YEAR(Date) = '2015' OR (YEAR(date) = 2020 AND MONTH(date) = 12);

ALTER TABLE sales
DROP COLUMN `Reg Date`;

# Create a view for visualizations in Tableau
CREATE OR REPLACE VIEW v_sale_data AS
select *
from sales;

########### Analysis ############

#---- 1. SALES TRENDS & GROWTH RATES
# Monthly revenue
SELECT CONCAT(MONTHNAME(date), '-', YEAR(Date)) AS `Month Year`, 
ROUND(sum(revenue),2) as `Monthly Revenue`,
ROUND(SUM(`Marketing Costs`),2) AS `Monthly Marketing Cost`
FROM sales
GROUP BY `Month Year`;

# Y-O-Y KPI growth
WITH yearly_metrics AS (
    SELECT 
        YEAR(date) AS year, 
        SUM(revenue) AS total_revenue,
        SUM(quantity) AS total_order_quantity,
        SUM(revenue) / NULLIF(SUM(quantity), 0) AS avg_order_value 
    FROM sales
    GROUP BY YEAR(date)
)
SELECT 
    *,
    -- YoY % Change Calculations
    ROUND(((total_revenue - LAG(total_revenue) OVER (ORDER BY year)) / 
           NULLIF(LAG(total_revenue) OVER (ORDER BY year), 0)) * 100, 2) AS yoy_revenue_change,
    ROUND(((total_order_quantity - LAG(total_order_quantity) OVER (ORDER BY year)) / 
           NULLIF(LAG(total_order_quantity) OVER (ORDER BY year), 0)) * 100, 2) AS yoy_quantity_change,
    ROUND(((avg_order_value - LAG(avg_order_value) OVER (ORDER BY year)) / 
           NULLIF(LAG(avg_order_value) OVER (ORDER BY year), 0)) * 100, 2) AS yoy_aov_change
FROM yearly_metrics;



#---- 2. MARKETING INVESTMENT ANALYSIS
# Total Marketing Cost, Revenue and Margin
SELECT ROUND(SUM(`Marketing Costs`),2) AS `Total Marketing Cost`,
ROUND(SUM(Revenue),2) AS `Total Revenue`,
ROUND(SUM(Margin),2) AS `Total Margin`
FROM sales;

# Monthly Monthly Marketing Spend
with monthly_marketing AS (
	SELECT CONCAT(MONTHNAME(date), '-', YEAR(Date)) AS `Month Year`, 
		ROUND(SUM(`Marketing Costs`),2) AS `Total Marketing Cost`,
        ROUND(SUM(Revenue),2) AS `Total Revenue`
    FROM sales
    GROUP BY `Month Year`
)
SELECT *,
LAG(`Total Marketing Cost`) OVER (ORDER BY STR_TO_DATE(`Month Year`, '%M-%Y')) AS `Previous Month Cost`,
ROUND((( `Total Marketing Cost` - LAG(`Total Marketing Cost`) OVER (ORDER BY STR_TO_DATE(`Month Year`, '%M-%Y')) ) 
/ LAG(`Total Marketing Cost`) OVER (ORDER BY STR_TO_DATE(`Month Year`, '%M-%Y')) ) * 100, 2) 
AS `MoM % Change`
FROM monthly_marketing;

# Top-performing marketing sources
SELECT `Marketing Source`,
ROUND(SUM(Revenue),2) AS `Total Revenue`,
ROUND(SUM(Margin),2) AS `Total Margin`,
ROUND(SUM(`Marketing Costs`),2) AS `Total Marketing Cost`,
ROUND(SUM(Revenue)/(COUNT(DISTINCT Client)),2) AS `Rev Per Client`,
ROUND((SUM(Revenue)-SUM(`Marketing Costs`))/SUM(`Marketing Costs`) * 100, 2) as `ROI`,
ROUND(SUM(Quantity)/COUNT(DISTINCT Client),2) AS `Purchase Frequency`
FROM sales
GROUP BY `Marketing Source`;


#---- 3. PRODUCT & BUSINESS LINE PERFORMANCE
# Top 5 selling products
SELECT Product,
round(SUM(Revenue),2) as `Total Revenue`,
SUM(Quantity) as `Total Orders`,
ROUND(SUM(Revenue)/SUM(Quantity),2) as Avg_Order_Value
FROM sales
GROUP BY Product
ORDER BY `Total Revenue` DESC
LIMIT 5;

# Products KPI
select product,
sum(revenue) as total_revenue,
count(*) as order_count,
ROUND(SUM(Revenue)/SUM(Quantity),2) as Avg_Order_Value,
ROUND(SUM(Margin),2) as Total_Margin
from sales
group by product
order by total_revenue asc;

# Business Line
SELECT `Business Line`,
round(SUM(Revenue),2) as `Total Revenue`,
SUM(Quantity) as `Total Orders`,
ROUND(SUM(Margin),2) AS `Total Margin`,
ROUND((SUM(Revenue)-SUM(`Marketing Costs`))/SUM(`Marketing Costs`) * 100, 2) as `ROI`,
ROUND(SUM(`Marketing Costs`),2) AS `Total Marketing Cost`,
ROUND(SUM(Revenue)/(COUNT(DISTINCT Client)),2) AS `Rev Per Client`
FROM sales
GROUP BY `Business Line`
ORDER BY `Total Revenue` DESC;

#---- 4. CUSTOMER GROWTH ANALYSIS
WITH first_buy AS (
    SELECT 
        YEAR(Date) AS Year, 
        COUNT(DISTINCT Client) AS first_time_client
    FROM sales
    WHERE YEAR(`Client Registration Date`) = YEAR(Date)
    GROUP BY YEAR(Date)
),
repeat_buy AS (
    SELECT 
        YEAR(Date) AS Year, 
        COUNT(DISTINCT Client) AS repeat_client
    FROM sales
    WHERE YEAR(`Client Registration Date`) != YEAR(Date)
    GROUP BY YEAR(Date)
)
SELECT 
    fb.Year, 
    fb.first_time_client, 
    ifnull(rb.repeat_client,0) as repeat_client, 
    round(ifnull((rb.repeat_client/fb.first_time_client)*100,0),2) as repeat_rate
FROM first_buy fb
LEFT JOIN repeat_buy rb 
    ON fb.Year = rb.Year
ORDER BY fb.Year;

## Average Customer Lifespan
WITH customer_lifespan AS (
    SELECT `Client`, 
           DATEDIFF(MAX(date), MIN(date)) / 365.0 AS lifespan_years
    FROM sales
    GROUP BY `Client`
)
SELECT AVG(lifespan_years) AS avg_customer_lifespan
FROM customer_lifespan;

## Customer Lifetime Value (CLV)
WITH customer_revenue AS (
    SELECT `Client`, 
           SUM(revenue) AS total_revenue,
           COUNT(DISTINCT YEAR(date)) AS active_years  -- Number of years the customer made purchases
    FROM sales
    GROUP BY `Client`
),
average_revenue_per_customer AS (
    SELECT AVG(total_revenue) AS avg_revenue_per_customer
    FROM customer_revenue
),
average_customer_lifespan AS (
    SELECT AVG(active_years) AS avg_customer_lifespan
    FROM customer_revenue
)
SELECT 
    (avg_revenue_per_customer * avg_customer_lifespan) AS CLV
FROM average_revenue_per_customer, average_customer_lifespan;

## Customer Churn Rate
WITH customer_counts AS (
    SELECT YEAR(date) AS year, 
           COUNT(DISTINCT `Client`) AS customer_count
    FROM sales
    GROUP BY YEAR(date)
)
SELECT 
    c1.year,
    c1.customer_count AS current_customers,
    c2.customer_count AS previous_customers,
    ROUND(100 * (1 - (c1.customer_count / NULLIF(c2.customer_count, 0))), 2) AS churn_rate
FROM customer_counts c1
LEFT JOIN customer_counts c2 ON c1.year = c2.year + 1
ORDER BY c1.year;


# Cost per Registration AND Revenue per Client
SELECT YEAR(date), 
ROUND(SUM(`Marketing Costs`)/(COUNT(DISTINCT CLIENT)),2) AS `Cost Per Registration`,
ROUND(SUM(Revenue)/(COUNT(DISTINCT Client)),2) As Revenue_Client 
FROM sales
GROUP BY Year(Date);
