-- 1) Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) TOtal_orders
FROM
    orders;



-- 3) Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) Total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;


-- 4) Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price AS max_price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY max_price DESC
LIMIT 1;


# 5) Identify the most common pizza size ordered.

SELECT 
    pizzas.size, COUNT(order_details.quantity) AS total_orders
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY total_orders DESC;


-- 6) List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name p, SUM(order_details.quantity) total_orders
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY p
ORDER BY total_orders DESC
LIMIT 5;


#10)  Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category categry,
    SUM(order_details.quantity) total_orders
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY categry
ORDER BY total_orders DESC;


# 11) Determie the distribution of orders by hour of the day.

SELECT 
     HOUR(time) hour_order, COUNT(order_id) orders
FROM
    orders
GROUP BY hour_order
ORDER BY orders DESC;


# 12 Join relevant tables to find the category-wise distribution of pizzas

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;


#13 Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(Sum_of_orders), 0)
FROM
    (SELECT 
        date, SUM(quantity) AS Sum_of_orders
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY date) AS order_quantity;

#14) Determine the top 3 most ordered pizza types based on revenue. 

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;