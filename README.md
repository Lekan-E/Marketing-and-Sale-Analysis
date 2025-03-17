# OxiN Marketing and Customer Analysis
## Project Background
OxiN is a global e-commerce company specializing in the sale of popular electronic products through its website. The company has recorded over 87K transactions from 2016-2020, covering sales, marketing expenditures, customer acquisition, and product offerings across 310 products in 10 business lines. This project thoroughly analyzes this data to uncover critical insights that will enhance OxiN’s marketing strategies and provide data-driven recommendations for forecasting future marketing investments (to be addressed in Part 2).

Insights and recommendations are provided on the following key areas and departments:

* **Sales Trends and Growth Rates**: Evaluation of sales patterns over the years, focusing on Revenue, Margin, Order Volume, and Average Order Value (AOV).
* **Product and Business Line Performance**: Analysis of OxiN’s various products and business lines to assess their impact on overall sales.
* **Customer Growth Analysis**: Examination of marketing costs in relation to the number of new and active customers, customer retention, average customer lifespan, and revenue per client.
* **Marketing Source Analysis**: Assessment of OxiN’s marketing investments, focusing on cost efficiency, return on investment (ROI), and margin performance across various channels.


## Executive Summary
Since its inception in 2016, OxiN has experienced substantial revenue growth, with a cumulative increase of 380%. This growth has been largely driven by strategic marketing investments. A significant year-over-year (YOY) increase in key performance indicators (KPIs), including revenue (135%) and order volume (157%), was observed in 2017. However, from 2018 onwards, revenue has stabilized, averaging $7.6M annually, with periods of decline. This report explores the key factors contributing to these trends and highlights opportunities for further optimization.

- The SQL queries used for this analysis can be found [HERE](https://github.com/Lekan-E/marketing-analysis/blob/54d9e338dc5631e115685160842c5b906d2f61e4/marketing_exploration.sql).
- An interactive Tableau dashboard used to report and explore sales trends can be found [HERE](https://public.tableau.com/app/profile/lekanelegbede/viz/OnlineSalesandMarketing_17393277783220/ExecutiveSummary?publish=yes).

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/6be13efd12caf30094b992ce6c345a5a570bd340/Data%20and%20Images/Summary%20Dashboard.png)

## Insights Deep-Dive
### Sales Trends and Growth Rates
- OxiN’s monthly revenue doubled in May 2017, reaching $535K, following the launch of 24 new products and a 3x marketing investment ($18K). This resulted in sustained monthly revenue averaging $637K.
- Sales peaked in November 2018 at $1.56M, correlating with Black Friday promotions, a seasonal trend consistently observed from 2017-2020.
- November has consistently been the highest-performing month, averaging $1.1M in revenue, compared to an overall period average of $601K.
- A revenue decline occurred from late 2018 through April 2019, hitting a low of $408K before partially recovering in subsequent months, following the pattern of marketing spend.
- YOY revenue growth was strongest in 2017 (135%) but slowed in later years: 46.7% in 2018, followed by a decline of -7.2% in 2020.

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/baa148a9d158a8f3be6455ee2d159d92804a3b3c/Misc/Revenue%20Trend.png)

### Marketing Investment Performance
- OxiN spent $953K on marketing, generating $30M in revenue and yielding a 21.3% margin from 2016-2020.
- In May 2017, a significant marketing spend of $18K (+135.3% vs previous period) drove record-high revenue of $535K. The company has since maintained an average monthly marketing spend of $20K.
- A strong correlation was observed between marketing spend and revenue generation, reinforcing the effectiveness of OxiN’s marketing strategy.

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/baa148a9d158a8f3be6455ee2d159d92804a3b3c/Misc/Cost%20vs%20Revenue%20Line.png)

#### Top-Performing Marketing Sources:
- **Source 9** ranked highest in multiple KPIs, generating $3.1M in revenue, $679K in margin, and the highest revenue per client ($706).
- **Source 6** demonstrated the highest efficiency, generating $3.14M in revenue with the lowest marketing cost ($39K), resulting in the best return on investment (ROI).
- **Source 3** was the least effective for customer acquisition, ranking 6th in purchase frequency, whereas Source 9 performed best in customer acquisition effectiveness.

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/baa148a9d158a8f3be6455ee2d159d92804a3b3c/Misc/Marketing%20Source.png)

## Customer Growth and Segmentation:
- Customer growth surged by 223.5% from 2016-2018, peaking at nearly 11,000. However, there was a -4.3% decline in 2019 before rebounding to over 9,000 in 2020.
- Repeat purchase rates improved steadily from 11.1% (2016) to 67.4% (2020), reflecting the success of marketing strategies in fostering customer loyalty.

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/baa148a9d158a8f3be6455ee2d159d92804a3b3c/Misc/Customer%20Growth%20Rate.png)

-	While customer growth increased exponentially, the cost per registration declined from $17.2 (2016) to $15.8 (2020), this suggests improved marketing efficiency.
-	Revenue per client steadily decreased from $596.6 (2016) to $487.4 (2020),  indicating a drop in customer spending over time.
-	Each customer, on average, is expected to generate $905.04 in revenue over their lifetime (CLV). This value is relatively low, suggesting that customers are not staying long enough or not spending much before leaving.
-	Additionally, the average customer lifespan is only 5 months. Short retention period meaning customers leave too quickly.

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/baa148a9d158a8f3be6455ee2d159d92804a3b3c/Misc/Customer%20Segments.png)

## Product & Business Line Performance:
- The top five revenue-generating products **(091, 301, 046, 113, 009)** each generated over $1M, with an Average Order Value (AOV) of $305 from over 3,000 units sold per product.
- Four business lines **(1, 5, 2, and 3)** each generated over $3M in revenue, with Business Line 1 leading at $4.9M and a $1.1M margin, making it the most profitable line.
- **Business Line 7**, despite having the lowest revenue, had the highest Return on Marketing Investment (ROMI) at 3,634.3%, with a minimal marketing cost of $54.6K.
- **Business Line 2** had the highest revenue per client ($497), indicating strong high-value customer attraction and engagement.

![alt text](https://github.com/Lekan-E/marketing-analysis/blob/baa148a9d158a8f3be6455ee2d159d92804a3b3c/Misc/Rev%20business%20line.png)

# Recommendations:
_Sales Trends & Growth Rates_
- **Leverage Seasonal Sales Patterns**: Implement a retargeting strategy before the peak season using email, social media, and paid ads to re-engage past buyers and maximize conversions.
- **Stabilize Revenue Growth by Improving Customer Retention**: Strengthen retention strategies such as exclusive offers and personalized product recommendations.

_Product & Business Line Optimization_
- **Optimize Top-Performing Business Lines for Higher Profitability**: Business Line 1 is the most profitable. Further improvements can be made by optimizing pricing strategies and enhancing product upselling. Expanding premium offerings in Business Line 2 can further drive high-revenue transactions.
- **Scale Underutilized High-ROI Products and Business Lines**: Expand inventory and marketing for high AOV products (e.g., products 091, 301, 046, etc.). Increase investment in Business Line 7 due to its high ROMI while maintaining cost efficiency.

_Marketing Strategy_
- **Reallocate Budget Toward High-Performing Marketing Sources**: Increasing investment in Source 6 can drive more efficient growth.
- **Optimize ROMI by Strengthening Conversion Tactics**: Focus on improving conversion rates through personalized email campaigns and better ad targeting.
- **Optimize Marketing Spend for Quality Over Quantity**: While Cost per Registration is declining, revenue per client is also decreasing. Shift focus to acquiring high-value customers, even if it increases acquisition costs slightly.

_Customer Growth Analysis_
- **Improve Customer Retention and Extend Customer Lifespan**: Implement post-purchase engagement tactics such as loyalty rewards, exclusive offers, and personalized content.
- **Enhance Customer Segmentation and Targeting**: For ‘Hibernating’ customers (39.8%), reinforce brand value by highlighting product benefits, showcasing testimonials, and offering win-back incentives such as exclusive discounts. For ‘About to Sleep’ customers (47.4%), deploy urgency-based marketing tactics, such as limited-time deals or early access to new products, to re-engage them before they become inactive.
