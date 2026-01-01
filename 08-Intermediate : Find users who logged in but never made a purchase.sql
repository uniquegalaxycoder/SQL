"""
    Q.Find users who logged in but never made a purchase.
"""


CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

CREATE TABLE logins (
    login_id INT PRIMARY KEY,
    user_id INT,
    login_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'), (4, 'David');

INSERT INTO logins (login_id, user_id, login_date) VALUES 
(1, 1, '2025-01-01'),
(2, 2, '2025-01-02'),
(3, 3, '2025-01-03'), 
(4, 3, '2025-01-04'); 

INSERT INTO orders (order_id, user_id, order_date, amount) VALUES 
(101, 1, '2025-01-05', 50.00),
(102, 2, '2025-01-06', 30.00);

select * from users ;
select * from logins;
select * from orders ;

with cte1 as (
  select 
    a.user_id,
    a.user_name,
    b.login_id,
    b.login_date,
    c.order_id,
    c.order_date,
    c.amount
  from 
    users as a 
  left join 
    logins as b 
  on a.user_id = b.user_id
  left join 
    orders as c 
  on 
    b.user_id = c.user_id
  where 
      b.login_date is not null
  and c.order_id is null 
)

select 
  user_id,
  user_name,
  login_date,
  case 
    when login_date is not null and order_id is null then "Login But Didn't Ordered" 
  end as order_status 
from cte1 ;

"""
  Output =>

    +---------+-----------+------------+--------------------------+
    | user_id | user_name | login_date | order_status             |
    +---------+-----------+------------+--------------------------+
    |       3 | Charlie   | 2025-01-03 | Login But Didn't Ordered |
    |       3 | Charlie   | 2025-01-04 | Login But Didn't Ordered |
    +---------+-----------+------------+--------------------------+

  """


