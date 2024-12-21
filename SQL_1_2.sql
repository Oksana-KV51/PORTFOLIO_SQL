--Вывести топ 3 лекарства по объему продаж (GROUP BY, LIMIT)
SELECT 
    drug, 
    SUM(price * count) AS total_sales
FROM 
    pharma_orders
GROUP BY 
    drug
ORDER BY 
    total_sales DESC
LIMIT 
	3;