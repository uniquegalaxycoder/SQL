"""
    Q.Get customers who placed orders, along with total order count per customer.
"""
  
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name, email) VALUES 
(1, 'Alice Smith', 'alice@example.com'),
(2, 'Bob Johnson', 'bob@example.com'),
(3, 'Charlie Brown', 'charlie@example.com'),
(4, 'David Miller', 'david@example.com');

INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES 
(101, 1, '2025-01-05', 150.00),
(102, 1, '2025-01-10', 200.00),
(103, 2, '2025-01-12', 50.00),
(104, 2, '2025-01-15', 300.00),
(105, 2, '2025-01-20', 120.00),
(106, 3, '2025-01-22', 450.00);

select * from customers ;
select * from orders ;

with cte1 as (
  select 
    a.customer_id,
    a.customer_name,
    count( b.order_id) as total_orders
  from
    customers as a 
  inner join 
    orders as b 
  on a.customer_id = b.customer_id
  group by
    a.customer_id,
    a.customer_name
)

select 
  *
from cte1 ;

"""
  Output=>

+-------------+---------------+--------------+
| customer_id | customer_name | total_orders |
+-------------+---------------+--------------+
|           1 | Alice Smith   |            2 |
|           2 | Bob Johnson   |            3 |
|           3 | Charlie Brown |            1 |
+-------------+---------------+--------------+
  
  """





