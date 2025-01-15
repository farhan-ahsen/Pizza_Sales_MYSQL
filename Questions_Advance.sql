-- 17) Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND((SUM(pizzas.price * order_details.quantity) / (SELECT 
                    SUM(pizzas.price * order_details.quantity)
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id)) * 100,
            2) AS Percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category
ORDER BY Percentage DESC;


-- 18) Analyze the cumulative revenue generated over time.


SELECT date ,round(revenue,2) Day_Sale,  round(sum(revenue) over (order by date),2) as Cum_Sale
from
(SELECT 
    orders.date,
    SUM(pizzas.price * order_details.quantity) revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    orders ON orders.order_id = order_details.order_id
    group by orders.date) as SAles_perDay;
    
--     19) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT name, revenue from
(select category, name , revenue,
rank() over ( partition by category order by revenue desc) as rn
from
(SELECT 
    pizza_types.category,
    pizza_types.name,
    SUM(pizzas.price * order_details.quantity) revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category , name
ORDER BY revenue DESC) as a) as b 
where rn<=3 limit 3;