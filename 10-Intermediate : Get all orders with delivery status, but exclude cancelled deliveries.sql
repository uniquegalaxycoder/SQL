"""
  Q.Get all orders with delivery status, but exclude cancelled deliveries.
"""

CREATE TABLE orders (
    orders_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_amount DECIMAL(10,2)
);

CREATE TABLE delivery_status (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    order_date DATETIME,
    Invoice_id BIGINT,
    Transaction_id INT,
    Transaction_status VARCHAR(20),
    delivery_date DATETIME,
    order_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(orders_id)
);

INSERT INTO orders (orders_id, customer_name, order_amount) VALUES 
(1, 'Alice Smith', 120.50),
(2, 'Bob Johnson', 45.00),
(3, 'Charlie Brown', 300.00),
(4, 'Diana Prince', 15.75),
(5, 'Edward Norton', 89.00);


INSERT INTO delivery_status 
(delivery_id, order_id, order_date, Invoice_id, Transaction_id, Transaction_status, delivery_date, order_status) 
VALUES 

(101, 1, '2026-01-01 10:00:00', 9001, 501, 'Success', '2026-01-03 14:00:00', 'Delivered'),
(102, 2, '2026-01-01 11:30:00', 9002, 502, 'Success', NULL, 'Shipped'),
(103, 3, '2026-01-02 09:15:00', 9003, 503, 'Refunded', NULL, 'Cancelled'),
(104, 4, '2026-01-02 15:45:00', 9004, 504, 'Pending', NULL, 'Processing'),
(105, 5, '2026-01-02 16:00:00', 9005, 505, 'Success', '2026-01-04 10:00:00', 'Delivered');

select * from orders ;
select * from delivery_status ;

with cte1 as (
  select 
    a.orders_id,
    a.customer_name,
    a.order_amount,
    b.Transaction_status,
    b.order_status
  from orders as a 
  left join 
    delivery_status as b 
  on 
    a.orders_id = b.order_id
  where 
    b.order_status <> 'Cancelled'
)

select * from cte1

"""
    Output => 
      +-----------+---------------+--------------+--------------------+--------------+
      | orders_id | customer_name | order_amount | Transaction_status | order_status |
      +-----------+---------------+--------------+--------------------+--------------+
      |         1 | Alice Smith   |       120.50 | Success            | Delivered    |
      |         2 | Bob Johnson   |        45.00 | Success            | Shipped      |
      |         4 | Diana Prince  |        15.75 | Pending            | Processing   |
      |         5 | Edward Norton |        89.00 | Success            | Delivered    |
      +-----------+---------------+--------------+--------------------+--------------+
  
  """


















