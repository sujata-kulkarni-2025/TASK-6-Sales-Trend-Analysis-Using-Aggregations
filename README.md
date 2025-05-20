# TASK-6-Sales-Trend-Analysis-Using-Aggregations

📅 Monthly Revenue and Order Volume Analysis
Month	Total Orders	Total Revenue	Average Order Value
2024-01	2	350.00	175.00
2024-02	2	300.00	150.00
2024-03	2	470.00	235.00
2024-04	2	400.00	200.00
2024-05	2	900.00	450.00

📈 Insights:
Steady order volume (2 per month).

Strong growth trend in revenue: Jan → May shows a 157% increase.

Average order value also climbs monthly, indicating possible:

Upselling,

Larger basket sizes,

Shift toward higher-priced products.

🏆 Top 3 Months by Revenue
Month	Total Revenue
2024-05	900.00
2024-03	470.00
2024-04	400.00

💡 Insights:
May 2024 leads with the highest revenue, nearly doubling the next month.

March and April show strong mid-period performance, possibly due to successful campaigns or seasonal products.

📦 Top-Selling Product by Revenue per Month
Month	Product ID	Revenue
2024-01	102	200.00
2024-02	104	180.00
2024-03	105	250.00
2024-04	107	300.00
2024-05	110	500.00

🛍️ Insights:
Each month has a distinct top-selling product, suggesting:

Strong product rotation

Possibly successful product launches

Product 110 in May generated the highest monthly revenue (₹500), showing standout performance.

✅ Strategic Takeaways:
Sustained Growth: Revenue is consistently increasing. Capitalize on what worked in March–May.

Product Strategy: Promote top-sellers earlier in the month or replicate their success across other products.

CREATE TABLE online_sales (
    order_id INTEGER,
    order_date DATE,
    amount DECIMAL(10, 2),
    product_id INTEGER
);

INSERT INTO online_sales (order_id, order_date, amount, product_id) VALUES
(1, '2024-01-15', 150.00, 101),
(2, '2024-01-20', 200.00, 102),
(3, '2024-02-10', 120.00, 103),
(4, '2024-02-12', 180.00, 104),
(5, '2024-03-05', 250.00, 105),
(6, '2024-03-22', 220.00, 106),
(7, '2024-04-01', 300.00, 107),
(8, '2024-04-15', 100.00, 108),
(9, '2024-05-03', 400.00, 109),
(10, '2024-05-10', 500.00, 110);

-- Monthly Revenue and Order Volume Analysis

SELECT 
    FORMAT(order_date, 'yyyy-MM') AS month, 
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_revenue,
    AVG(amount) AS average_order_value
FROM 
    online_sales
GROUP BY 
    FORMAT(order_date, 'yyyy-MM')
ORDER BY 
    month;

	--Top 3 Months by Total Revenue

	SELECT 
    FORMAT(order_date, 'yyyy-MM') AS month,      
    SUM(amount) AS total_revenue
FROM 
    online_sales
GROUP BY 
    FORMAT(order_date, 'yyyy-MM')
ORDER BY 
    total_revenue DESC

--Top-Selling Product by Revenue per Month


	WITH MonthlyProductRevenue AS (
    SELECT 
        FORMAT(order_date, 'yyyy-MM') AS month,
        product_id,
        SUM(amount) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY FORMAT(order_date, 'yyyy-MM') 
            ORDER BY SUM(amount) DESC
        ) AS rn
    FROM 
        online_sales
    GROUP BY 
        FORMAT(order_date, 'yyyy-MM'), product_id
)
SELECT 
    month,
    product_id,
    total_revenue
FROM 
    MonthlyProductRevenue
WHERE 
    rn = 1
ORDER BY 
    month;




May Success Analysis: Dive into May’s success — higher volume or pricing? Which marketing initiatives were active?

Product Portfolio Optimization: Identify attributes of top products (price, category, delivery time) for future recommendations.

