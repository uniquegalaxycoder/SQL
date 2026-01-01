"""
  Q.Find duplicate customer entries stored in a backup table.
"""
  
CREATE TABLE customers (
    backup_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    backup_date DATETIME
);

INSERT INTO customers (backup_id, customer_name, email, backup_date) VALUES 
(1, 'Alice Smith', 'alice@example.com', '2025-12-01 10:00:00'),
(2, 'Bob Johnson', 'bob@example.com', '2025-12-01 10:05:00'),
(3, 'Charlie Brown', 'charlie@example.com', '2025-12-01 10:10:00'),
(4, 'Charlie B.', 'charlie@example.com', '2025-12-02 09:00:00'),
(5, 'David Miller', 'david@example.com', '2025-12-01 11:00:00'),
(6, 'David Miller', 'david@example.com', '2025-12-02 11:00:00'),
(7, 'D. Miller', 'david@example.com', '2025-12-03 11:00:00');

with cte1 as (
select 
  *,
  row_number()over(partition by email order by backup_date asc) as duplicate_rank
from customers
)

select 
  customer_name,
  email,
  backup_date
from cte1 
where duplicate_rank > 1 ;

"""
  => Output 
+---------------+---------------------+---------------------+
| customer_name | email               | backup_date         |
+---------------+---------------------+---------------------+
| Charlie B.    | charlie@example.com | 2025-12-02 09:00:00 |
| David Miller  | david@example.com   | 2025-12-02 11:00:00 |
| D. Miller     | david@example.com   | 2025-12-03 11:00:00 |
+---------------+---------------------+---------------------+
  
  """

