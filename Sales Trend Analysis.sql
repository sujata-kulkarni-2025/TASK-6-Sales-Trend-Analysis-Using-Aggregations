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


