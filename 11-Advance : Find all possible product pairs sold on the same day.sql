"""
    Q.Find all possible product pairs sold on the same day (Self JOIN).
"""
  
create table product (
  product_id bigint,
  product_name varchar(30)
);

create table orders (
  order_id bigint,
  order_date date,
  product_id bigint
);

insert into product ( product_id, product_name)
values 
(1, "Smart Watch"),
(2, "I-phone"),
(3, "I-Tablet"),
(4, "Laptop"),
(5, "Phone Charger") ;

insert into orders ( order_id, order_date, product_id)
values 
(1002, '2024-01-13', 1),
(1003, '2024-01-13', 2),
(1014, '2024-01-13', 3),
(1056, '2024-01-14', 5),
(1005, '2024-01-14', 3),
(1006, '2024-01-15', 4),
(1007, '2024-01-15', 1),
(1008, '2024-01-17', 5),
(1009, '2024-01-17', 4),
(1011, '2024-01-23', 3),
(1010, '2024-01-23', 1);

select * from product;
select * from orders;

with cte1 as (
  select 
    a.product_id,
    a.product_name,
    b.order_id,
    b.order_date
  from product as a 
  left join 
    orders as b 
  on 
    a.product_id = b.product_id
)

select
  x.order_date,
  x.product_name as product_1,
  y.product_name as product_2
from 
    cte1 as x 
join 
    cte1 as y 
on 
    x.order_date = y.order_date
and 
    x.product_id < y.product_id
order by 
    x.order_date ;

"""
  Output => 
+------------+-------------+---------------+
| order_date | product_1   | product_2     |
+------------+-------------+---------------+
| 2024-01-13 | Smart Watch | I-phone       |
| 2024-01-13 | Smart Watch | I-Tablet      |
| 2024-01-13 | I-phone     | I-Tablet      |
| 2024-01-14 | I-Tablet    | Phone Charger |
| 2024-01-15 | Smart Watch | Laptop        |
| 2024-01-17 | Laptop      | Phone Charger |
| 2024-01-23 | Smart Watch | I-Tablet      |
+------------+-------------+---------------+
 
  """

























