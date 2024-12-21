--Сравнение динамики продаж между Москвой и Санкт-Петербургом. 
--а. посчитать продажи лекарств по аптекам и месяцам для Москвы
--b. посчитать продажи лекарств по аптекам и месяцам для Санкт-Петербурга, 
--с. соединяем таблицы по месяцам и аптекам и вычисляем разницу по месяцам в процентах. 
WITH converted_orders AS (
    SELECT
        pharmacy_name,
        order_id,
        drug,
        price,
        count,
        city,
        TO_DATE(report_date, 'YYYY-MM-DD') AS report_date,
        customer_id
    FROM
        pharma_orders
),
moscow_sales AS (
    SELECT
        pharmacy_name,
        DATE_TRUNC('month', report_date) AS month,
        SUM(price * count) AS total_sales
    FROM
        converted_orders
    WHERE
        city = 'Москва'
    GROUP BY
        pharmacy_name, month
),
spb_sales AS (
    SELECT
        pharmacy_name,
        DATE_TRUNC('month', report_date) AS month,
        SUM(price * count) AS total_sales
    FROM
        converted_orders
    WHERE
        city = 'Санкт-Петербург'
    GROUP BY
        pharmacy_name, month
)
SELECT
    moscow_sales.pharmacy_name,
    moscow_sales.month,
    moscow_sales.total_sales AS moscow_total_sales,
    spb_sales.total_sales AS spb_total_sales,
    CASE
        WHEN spb_sales.total_sales IS NULL THEN NULL
        WHEN moscow_sales.total_sales = 0 THEN NULL
        ELSE ((spb_sales.total_sales - moscow_sales.total_sales)* 100 / moscow_sales.total_sales) 
    END AS sales_difference_percentage
FROM
    moscow_sales
FULL OUTER JOIN
    spb_sales
ON
    moscow_sales.pharmacy_name = spb_sales.pharmacy_name
    AND moscow_sales.month = spb_sales.month
ORDER BY
    moscow_sales.pharmacy_name, moscow_sales.month;
