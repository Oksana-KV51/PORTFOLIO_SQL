--Вывести аптеки, имеющие более 1.8 млн оборота (HAVING)
Для этого использовались функции:HAVING
SELECT 
    pharmacy_name, 
    SUM(price * count) AS total_sales
FROM 
    pharma_orders
GROUP BY 
    pharmacy_name
HAVING 
    SUM(price * count) > 1800000;