"""
    Q.DOD Category wise sales growth ( Using Self join )
"""

create table category (
  category_id bigint primary key,
  category varchar(30)
);

create table orders(
  order_id BIGINT primary key,
  order_date DATE,
  invoice_amount decimal(10,2),
  category_id bigint,
  foreign key(category_id) references category(category_id)
) ;

insert into category( category_id, category)
values 
(1, "Electronic"),
(2, "Home-Kitchen"),
(3, "Cloths");

insert into orders(order_id, order_date, invoice_amount, category_id)
values
(101, '2026-01-01', 500.00, 1), (102, '2026-01-01', 900.00, 2), (103, '2026-01-01', 150.00, 3),
(104, '2026-01-01', 450.00, 1), (105, '2026-01-01', 200.00, 2), (201, '2026-01-02', 600.00, 1),
(202, '2026-01-02', 600.00, 2), (203, '2026-01-02', 250.00, 3), (204, '2026-01-02', 700.00, 1),
(205, '2026-01-02', 100.00, 2), (206, '2026-01-02', 300.00, 3), (301, '2026-01-03', 400.00, 1),
(302, '2026-01-03', 800.00, 2), (303, '2026-01-03', 500.00, 3), (304, '2026-01-03', 200.00, 1), 
(305, '2026-01-03', 150.00, 2), (306, '2026-01-03', 60.00, 3),  (307, '2026-01-03', 300.00, 1),
(308, '2026-01-03', 600.00, 2), (401, '2026-01-04', 1000.00, 1), (402, '2026-01-04', 200.00, 2), 
(403, '2026-01-04', 800.00, 3), (404, '2026-01-04', 590.00, 1), (405, '2026-01-04', 120.00, 2),
(406, '2026-01-04', 800.00, 3), (407, '2026-01-04', 480.00, 1);

select * from category ;
select * from orders;

with cte1 as (
select 
  a.category_id,
  a.category,
  b.order_date,
  sum(b.invoice_amount) as total_amount
from 
  category as a 
left join 
  orders as b 
on 
  a.category_id = b.category_id
group by a.category_id, a.category, b.order_date
),

cte2 as (
select 
  x.category_id,
  x.category,
  x.order_date,
  x.total_amount as current_amount,
  y.total_amount as last_day_amount
from 
  cte1 as x 
left join 
  cte1 as y 
on  x.category_id = y.category_id
and x.order_date = y.order_date  + interval 1 day
order by category, order_date
)
  
select 
  * ,
  concat( round( ((current_amount - last_day_amount)*100 / last_day_amount) ), '%' ) as sales_growth
from cte2 ;
  
  
 """
   => Output 
        +-------------+--------------+------------+----------------+-----------------+--------------+
        | category_id | category     | order_date | current_amount | last_day_amount | sales_growth |
        +-------------+--------------+------------+----------------+-----------------+--------------+
        |           3 | Cloths       | 2026-01-01 |         150.00 |            NULL | NULL         |
        |           3 | Cloths       | 2026-01-02 |         550.00 |          150.00 | 267%         |
        |           3 | Cloths       | 2026-01-03 |         560.00 |          550.00 | 2%           |
        |           3 | Cloths       | 2026-01-04 |        1600.00 |          560.00 | 186%         |
        |           1 | Electronic   | 2026-01-01 |         950.00 |            NULL | NULL         |
        |           1 | Electronic   | 2026-01-02 |        1300.00 |          950.00 | 37%          |
        |           1 | Electronic   | 2026-01-03 |         900.00 |         1300.00 | -31%         |
        |           1 | Electronic   | 2026-01-04 |        2070.00 |          900.00 | 130%         |
        |           2 | Home-Kitchen | 2026-01-01 |        1100.00 |            NULL | NULL         |
        |           2 | Home-Kitchen | 2026-01-02 |         700.00 |         1100.00 | -36%         |
        |           2 | Home-Kitchen | 2026-01-03 |        1550.00 |          700.00 | 121%         |
        |           2 | Home-Kitchen | 2026-01-04 |         320.00 |         1550.00 | -79%         |
        +-------------+--------------+------------+----------------+-----------------+--------------+
   
   """ 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
