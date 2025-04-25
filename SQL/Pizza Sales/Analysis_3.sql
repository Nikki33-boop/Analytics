-- Calcualte the percentage contribution of each pizza type to total revenue

WITH T1 AS(
	SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
    FROM pizzas JOIN order_details 
	ON order_details.pizza_id = pizzas.pizza_id
)
SELECT pizza_types.category, ROUND(SUM(order_details.quantity * pizzas.price)/(SELECT total_revenue FROM T1) * 100 , 2) AS revenue_percent
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;


-- Analyze the cumulative revenue generated overtime

WITH T1 AS(
	SELECT orders.order_date AS o_date, ROUND(SUM(order_details.quantity * pizzas.price)) AS revenue
	FROM pizzas JOIN order_details 
	ON order_details.pizza_id = pizzas.pizza_id
	JOIN orders ON orders.order_id = order_details.order_id
    GROUP BY 1
)
SELECT o_date, SUM(revenue) OVER (ORDER BY o_date) AS cumulative_revenue FROM T1;


-- Top 3 most ordered pizza types for each pizza categroy based on revenue

WITH T1 AS (
SELECT 
    pizza_types.name AS name,
    pizza_types.category AS category,
    SUM(order_details.quantity * pizzas.price) revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1 , 2
ORDER BY revenue DESC
),
T2 AS (
	SELECT name, category, revenue, 
	RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rnk
	FROM T1
)
SELECT name, category, revenue FROM T2 WHERE rnk <= 3 



