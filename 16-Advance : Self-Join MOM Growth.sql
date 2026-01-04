""" # 3. The Self-Join for Period-over-Period (PoP) Growth """
"""
     Question: Given a table Monthly_Revenue with columns YearMonth and Revenue, write a query to calculate the Month-over-Month
               (MoM) growth percentage.
"""

create table Monthly_Revenue (
  YearMonth DATE, -- date format is 'YYYY-MM-01'
  revenue float(10,2)
);

insert into Monthly_Revenue ( YearMonth, revenue)
values 
('2024-01-01', 43560.90),
('2024-02-01', 34569.78),
('2024-03-01', 67890.24),
('2024-04-01', 88760.88),
('2024-05-01', 91450.91),
('2024-06-01', 81890.90);

select * from Monthly_Revenue ;

with cte1 as (
  select 
    a.YearMonth,
    a.revenue as current_revenue,
    b.revenue as last_month_revenue
  from Monthly_Revenue as a 
  left join 
    Monthly_Revenue as b 
  on  
    a.YearMonth = b.YearMonth + interval 1 month
)

select 
    YearMonth ,
    current_revenue,
    last_month_revenue,
    round(((current_revenue - last_month_revenue)*100 /last_month_revenue),2) growth 
from cte1;

"""
  Output => 
      +------------+-----------------+--------------------+--------+
      | YearMonth  | current_revenue | last_month_revenue | growth |
      +------------+-----------------+--------------------+--------+
      | 2024-01-01 |        43560.90 |               NULL |   NULL |
      | 2024-02-01 |        34569.78 |           43560.90 | -20.64 |
      | 2024-03-01 |        67890.24 |           34569.78 |  96.39 |
      | 2024-04-01 |        88760.88 |           67890.24 |  30.74 |
      | 2024-05-01 |        91450.91 |           88760.88 |   3.03 |
      | 2024-06-01 |        81890.90 |           91450.91 | -10.45 |
      +------------+-----------------+--------------------+--------+
  """


