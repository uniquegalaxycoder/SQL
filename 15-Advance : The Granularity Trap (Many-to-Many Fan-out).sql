""" 
   The Granularity Trap (Many-to-Many Fan-out)
   Question: You join a Sales table (daily grain) with a Marketing_Spend table (monthly grain)
   on Month_Year. Your total sales figure suddenly triples. Why did this happen, and how do you fix it?
"""


CREATE TABLE daily_sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    amount DECIMAL(10,2)
);

CREATE TABLE monthly_marketing (
    spend_id INT PRIMARY KEY,
    month_year DATE, 
    spend_amount DECIMAL(10,2)
);


INSERT INTO daily_sales VALUES 
(1, '2026-01-05', 100.00),
(2, '2026-01-15', 200.00),
(3, '2026-01-20', 300.00);


INSERT INTO monthly_marketing VALUES 
(101, '2026-01-01', 1000.00);

select * from daily_sales;
select * from monthly_marketing ;

with cte1 as (
  select 
    sales_month,
    sum(amount) as total_sales
  from (
        select 
          date_format(sale_date, '%Y-%m') as sales_month,
          amount 
        from daily_sales
      ) as x 
  group by sales_month
),

cte2 as (
  select  
    date_format(Month_year, '%Y-%m') as Month_year,
    spend_amount
  from monthly_marketing
)

select 
  cte1.*,
  cte2.*
from
  cte1 
left join 
  cte2 
on 
  cte1.sales_month = cte2.Month_year;

"""
  Output =>

+-------------+-------------+------------+--------------+
| sales_month | total_sales | Month_year | spend_amount |
+-------------+-------------+------------+--------------+
| 2026-01     |      600.00 | 2026-01    |      1000.00 |
+-------------+-------------+------------+--------------+

"""



