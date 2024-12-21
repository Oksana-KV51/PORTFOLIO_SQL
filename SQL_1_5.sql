--Запрос "Количество клиентов в аптеках"
    --a. Соединить таблицы заказов и клиентов (JOIN)
    --b. Посчитать кол-во уникальных клиентов на каждую аптеку (DISTINCT)
    --c. Отсортировать аптеки по убыванию кол-ва клиентов (ORDER BY)
SELECT 
  po.pharmacy_name, 
  COUNT(DISTINCT po.customer_id) AS unique_customer_count 
FROM 
  pharma_orders po 
  JOIN customers c ON po.customer_id = c.customer_id 
GROUP BY 
  po.pharmacy_name 
ORDER BY 
  unique_customer_count DESC;
