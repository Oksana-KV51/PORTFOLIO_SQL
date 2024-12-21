--"Накопленная сумма по клиентам"
    --a. Соединить таблицы заказов и клиентов
   -- b. Соединить ФИО в одно поле
    --c. Рассчитать накопленную сумму по каждому клиенту
SELECT 
  c.customer_id, 
  c.first_name || ' ' || c.second_name || ' ' || c.last_name AS full_name, 
  SUM(po.price * po.count) AS cumulative_sum 
FROM 
  pharma_orders po 
  JOIN customers c ON po.customer_id = c.customer_id 
GROUP BY 
  c.customer_id, 
  full_name;
