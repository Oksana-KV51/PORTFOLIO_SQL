--a. Соединить таблицы заказов и клиентов (JOIN)
    --b. Посчитать тотал сумму заказов для каждого клиента
    --c. Проранжировать клиентов по убыванию суммы заказа (row_number)
   --d. Оставить топ-10 клиентов
WITH customer_totals AS (
  SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.second_name, 
    SUM(po.price * po.count) AS total_order_amount 
  FROM 
    pharma_orders po 
    JOIN customers c ON po.customer_id = c.customer_id 
  GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.second_name
), 
ranked_customers AS (
  SELECT 
    customer_id, 
    first_name, 
    last_name, 
    second_name, 
    total_order_amount, 
    ROW_NUMBER() OVER (
      ORDER BY 
        total_order_amount DESC
    ) AS rank 
  FROM 
    customer_totals
) 
SELECT 
  customer_id, 
  first_name, 
  last_name, 
  second_name, 
  total_order_amount 
FROM 
  ranked_customers 
WHERE 
  rank <= 10;