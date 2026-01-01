"""
  Q.List products that were never sold.
"""

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, category) VALUES 
(1, 'Laptop', 'Electronics'),
(2, 'Phone', 'Electronics'),
(3, 'Monitor', 'Electronics'), 
(4, 'Keyboard', 'Accessories');

INSERT INTO orders (order_id, product_id, order_date) VALUES 
(101, 1, '2025-01-10'),
(102, 2, '2025-01-12'),
(103, 1, '2025-01-15');

select * from products;
select * from orders ;

with cte1 as (
  select 
    a.product_id,
    a.product_name,
    a.category,
    b.order_id as order_id,
    b.order_date as order_date
  from 
    products as a 
  left join 
    orders as b 
  on a.product_id = b.product_id
  -- where  b.order_id is null  -- this condition will be also work
)



select 
  product_name as "Product Name",
  count(order_id) as "Total Quntity Sold"
from
  cte1
where
  order_id is null
group by
  product_name ;

"""
Output =>

+--------------+--------------------+
| Product Name | Total Quntity Sold |
+--------------+--------------------+
| Monitor      |                  0 |
| Keyboard     |                  0 |
+--------------+--------------------+
  
  """




