--Вывести топ 3 аптеки по объему продаж (GROUP BY, LIMIT)
SELECT 
  po.pharmacy_name, 
  SUM(po.price * po.count) AS total_sales 
FROM 
  pharma_orders po 
  JOIN customers c ON po.customer_id = c.customer_id 
GROUP BY 
  po.pharmacy_name 
ORDER BY 
  total_sales DESC 
LIMIT 
  3;
