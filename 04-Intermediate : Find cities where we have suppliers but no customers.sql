"""
    Q.Find cities where we have suppliers but no customers.
"""
  
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO suppliers (supplier_id, supplier_name, city) VALUES 
(1, 'Global Tech', 'London'),
(2, 'Alpha Parts', 'Tokyo'),
(3, 'Berlin Manufacturing', 'Berlin'),
(4, 'Westside Goods', 'New York');

INSERT INTO customers (customer_id, customer_name, city) VALUES 
(101, 'Alice Smith', 'London'),
(102, 'Bob Johnson', 'New York'),
(103, 'Charlie Brown', 'Mumbai'); 

select * from suppliers ;
select * from customers ;

with cte1 as (
  select 
    a.supplier_id,
    a.supplier_name,
    a.city,
    b.customer_id
  from 
    suppliers as a 
  left join 
    customers as b
  on 
    a.city = b.city
  where 
    b.customer_id is null
)

select 
  * 
from cte1 ; 


"""
  Output => 
  
+-------------+----------------------+--------+-------------+
| supplier_id | supplier_name        | city   | customer_id |
+-------------+----------------------+--------+-------------+
|           2 | Alpha Parts          | Tokyo  |        NULL |
|           3 | Berlin Manufacturing | Berlin |        NULL |
+-------------+----------------------+--------+-------------+

"""

