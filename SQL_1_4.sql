--Накопленная сумма продаж по каждой аптеке" (OVER)
SELECT 
  pharmacy_name, 
  report_date, 
  SUM(price * count) OVER (
    PARTITION BY pharmacy_name 
    ORDER BY 
      report_date
  ) AS cumulative_sales 
FROM 
  pharma_orders 
ORDER BY 
  pharmacy_name, 
  report_date;