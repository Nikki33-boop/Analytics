-- Find the total quantity of pizza category ordered

SELECT 
    pizza_types.category, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;


-- Determine the distribution of orders by the hour of the day

SELECT 
    HOUR(order_time) AS hour_of_day,
    COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hour_of_day
ORDER BY order_count DESC;


-- category wise distribution of pizzas

SELECT 
    category, COUNT(*) AS distribution
FROM
    pizza_types
GROUP BY category;


-- Average number of pizzas ordered per day

SELECT 
    ROUND(AVG(no_ordered), 2) AS avg_order_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS no_ordered
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY 1) sub;


-- Top 3 most ordered pizzas based on revenue

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 3;