Select  * from orders
Select * from rst
DELETE FROM orders
USING (
  SELECT ctid,
         ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY ctid) AS rn
  FROM orders
) AS duplicates
WHERE orders.ctid = duplicates.ctid
  AND duplicates.rn > 1;

with group_data as(
select * from orders 
full join rst 
on orders.restaurant_id= rst.restaurant_id 

)
Select  
		group_data.city,avg(group_data.total_cost) from group_data
group by  group_data.city;

WITH group_data AS (
  SELECT 
    COALESCE(orders.restaurant_id, rst.restaurant_id) AS restaurant_id,
    rst.restaurant_name,
    orders.total_cost
  FROM orders 
  FULL JOIN rst 
    ON orders.restaurant_id = rst.restaurant_id
)
SELECT 
  restaurant_id,
  restaurant_name,
  SUM(total_cost) AS total_sales
FROM group_data
GROUP BY restaurant_id, restaurant_name
order by total_sales DESC
limit 5;

SELECT 
  orders.order_id,
  orders.customer_id,
  orders.order_date,
  orders.order_time,
  orders.delivery_time,
  orders.total_cost,
  orders.item_count,
  orders.payment_method,
  orders.customer_rating,
  rst.restaurant_id,
  rst.restaurant_name,
  rst.city,
  rst.area,
  rst.cuisine,
  rst.avg_rating,
  rst.total_ratings,
  rst.price_range,
  rst.delivery_available
FROM orders
JOIN  rst
  ON orders.restaurant_id = rst.restaurant_id;

