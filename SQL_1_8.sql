--"Самые частые клиенты аптек Горздрав и Здравсити"
   -- a Сделать две временные таблицы: для аптеки горздрав и здравсити (WITH)
    --b. Внутри каждой соединить таблицы заказов и клиентов (JOIN)
    --c. Внутри каждой привести данные в формат "клиент - кол-во заказов в аптеке"
    --d. Внутри каждой оставить топ 10 клиентов каждой аптеки
    --e. Объединить клиентов с помощью UNION
WITH gorzdrav_orders AS (
  SELECT 
    c.customer_id, 
    c.first_name || ' ' || c.second_name || ' ' || c.last_name AS full_name, 
    COUNT(po.order_id) AS order_count 
  FROM 
    pharma_orders po 
    JOIN customers c ON po.customer_id = c.customer_id 
  WHERE 
    po.pharmacy_name = 'Горздрав' 
  GROUP BY 
    c.customer_id, 
    full_name 
  ORDER BY 
    order_count DESC 
  LIMIT 
    10
), zdravcity_orders AS (
  SELECT 
    c.customer_id, 
    c.first_name || ' ' || c.second_name || ' ' || c.last_name AS full_name, 
    COUNT(po.order_id) AS order_count 
  FROM 
    pharma_orders po 
    JOIN customers c ON po.customer_id = c.customer_id 
  WHERE 
    po.pharmacy_name = 'Здравсити' 
  GROUP BY 
    c.customer_id, 
    full_name 
  ORDER BY 
    order_count DESC 
  LIMIT 
    10
) 
SELECT 
  'Горздрав' AS pharmacy_name, 
  full_name, 
  order_count 
FROM 
  gorzdrav_orders 
UNION ALL 
SELECT 
  'Здравсити' AS pharmacy_name, 
  full_name, 
  order_count 
FROM 
  zdravcity_orders;