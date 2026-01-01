"""
    Q.Get the latest transaction for each user using JOIN + window function.
"""

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

CREATE TABLE transactions (
    tran_id INT PRIMARY KEY,
    user_id INT,
    tran_date DATETIME,
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, user_name) VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie'),
(4, 'Meli'), (5, 'Rexa'), (6, 'Eathan');

INSERT INTO transactions (tran_id, user_id, tran_date, amount) VALUES 
(101, 1, '2025-01-01 10:00:00', 50.00),
(102, 1, '2025-01-05 14:30:00', 75.00), 
(103, 2, '2025-01-02 09:00:00', 100.00),
(104, 2, '2025-01-08 11:15:00', 20.00),  
(105, 3, '2025-01-07 16:00:00', 300.00),
(106, 4, '2025-01-09 16:00:00', 432.00),
(107, 4, '2025-02-07 16:00:00', 400.00),
(108, 5, '2025-01-23 16:00:00', 300.00),
(109, 6, '2025-01-07 16:00:00', 370.00),
(110, 6, '2025-01-18 16:00:00', 232.00),
(111, 5, '2025-03-07 16:00:00', 700.00);

select * from users ;
select * from transactions;

""" Solution Type-1  """

with cte1 as (
  select 
    a.user_id,
    a.user_name,
    b.tran_id,
    b.tran_date,
    b.amount
  from 
    users as a 
  left join 
    ( select 
        *,
        row_number()over(partition by user_id order by tran_date desc) as tran_rank
      from
        transactions) as b 
  on a.user_id = b.user_id
  where b.tran_rank =  1
)

select 
  * 
from cte1 ;


""" Solution Type-2 """

with cte1 as (
  select 
    a.user_id,
    a.user_name,
    b.tran_id,
    b.tran_date,
    b.amount
  from 
    users as a 
  left join 
    transactions as b 
  on 
    a.user_id = b.user_id
)

select 
  user_id,
  user_name,
  tran_id,
  tran_date,
  amount
from (
      select 
        *,
        dense_rank()over(partition by user_id order by tran_date desc ) as latest_rank
      from cte1 
    ) as x 
where latest_rank = 1 ;

"""
  Output => 

+---------+-----------+---------+---------------------+--------+
| user_id | user_name | tran_id | tran_date           | amount |
+---------+-----------+---------+---------------------+--------+
|       1 | Alice     |     102 | 2025-01-05 14:30:00 |  75.00 |
|       2 | Bob       |     104 | 2025-01-08 11:15:00 |  20.00 |
|       3 | Charlie   |     105 | 2025-01-07 16:00:00 | 300.00 |
|       4 | Meli      |     107 | 2025-02-07 16:00:00 | 400.00 |
|       5 | Rexa      |     111 | 2025-03-07 16:00:00 | 700.00 |
|       6 | Eathan    |     110 | 2025-01-18 16:00:00 | 232.00 |
+---------+-----------+---------+---------------------+--------+
  
"""














