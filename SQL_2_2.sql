--Лекарства от насморка. 
--Выделяем препараты, начинающиеся со слова “аква” (с использованием оператора LIKE). 
--Приводим данные к нижнему регистру, группируем и подсчитываем общий объем продаж для каждого препарата, 
--ранжируем по убыванию объема продаж и подсчитываем долю продаж каждого лекарства в общем объеме.

WITH filtered_orders AS (
    SELECT 
        LOWER(drug) AS drug,  -- Приводим название препарата к нижнему регистру
        SUM(price * count) AS total_sales  -- Считаем общий объем продаж для каждого препарата
    FROM 
        pharma_orders
    WHERE 
        LOWER(drug) LIKE 'аква%'  -- Фильтруем препараты, начинающиеся со слова "аква"
    GROUP BY 
        LOWER(drug)  -- Группируем по названию препарата в нижнем регистре
),
total_sales_sum AS (
    SELECT 
        SUM(total_sales) AS overall_sales  -- Считаем общий объем продаж всех препаратов
    FROM 
        filtered_orders
)
SELECT 
    f.drug, 
    f.total_sales,
    RANK() OVER(ORDER BY f.total_sales DESC) AS sales_rank,  -- Ранжируем по убыванию объема продаж
    ROUND((f.total_sales / t.overall_sales) * 100, 2) AS sales_percentage  -- Считаем долю продаж в общем объеме
FROM 
    filtered_orders f
CROSS JOIN 
    total_sales_sum t
ORDER BY 
    f.total_sales DESC;