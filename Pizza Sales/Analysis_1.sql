-- Retrieve the total number of orders placed

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- calculate total revenue generated from pizza sales

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    

-- Identify the highest prized pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


-- Identify the commonly oprdered pizza size

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS number_of_orders
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY number_of_orders DESC;


-- List the 5 top most ordered pizza types along with their quantities

SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS pizza_ordered
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name
ORDER BY pizza_ordered DESC
LIMIT 5;