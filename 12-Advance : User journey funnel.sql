"""
    Q.Generate a user journey funnel using multiple LEFT JOINS (leads → signup → purchase → churn).
"""

CREATE TABLE leads (
    lead_id INT PRIMARY KEY,
    lead_source VARCHAR(50),
    created_at DATE
);

CREATE TABLE signups (
    signup_id INT PRIMARY KEY,
    lead_id INT,
    signup_date DATE,
    FOREIGN KEY (lead_id) REFERENCES leads(lead_id)
);

CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    lead_id INT,
    purchase_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (lead_id) REFERENCES leads(lead_id)
);

CREATE TABLE churned_users (
    churn_id INT PRIMARY KEY,
    lead_id INT,
    churn_date DATE,
    reason VARCHAR(50),
    FOREIGN KEY (lead_id) REFERENCES leads(lead_id)
);


INSERT INTO leads VALUES 
(1, 'Google', '2025-01-01'), (2, 'Meta', '2025-01-01'), (3, 'Organic', '2025-01-02'),
(4, 'Google', '2025-01-02'), (5, 'Meta', '2025-01-03'), (6, 'LinkedIn', '2025-01-03'),
(7, 'Organic', '2025-01-04'), (8, 'Google', '2025-01-04'), (9, 'LinkedIn', '2025-01-05'),
(10, 'Meta', '2025-01-05');


INSERT INTO signups VALUES 
(101, 1, '2025-01-02'), (102, 2, '2025-01-03'), (103, 3, '2025-01-04'),
(104, 4, '2025-01-05'), (105, 5, '2025-01-06'), (106, 7, '2025-01-07'),
(107, 8, '2025-01-08');


INSERT INTO purchases VALUES 
(501, 1, '2025-01-10', 99.00), (502, 2, '2025-01-11', 150.00),
(503, 4, '2025-01-12', 49.00), (504, 5, '2025-01-15', 199.00);


INSERT INTO churned_users VALUES 
(901, 4, '2025-02-01', 'Competitor'), (902, 5, '2025-02-05', 'Price');


select * from leads;
select * from signups;
select * from purchases;
select * from churned_users;

with cte1 as (
  select 
    a.lead_id,
    a.lead_source,
    a.created_at as lead_created,
    -- b.signup_id,
    b.signup_date,
    -- c.purchase_id,
    c.purchase_date,
    c.amount,
    -- d.churn_id,
    d.churn_date,
    d.reason
  from 
    leads as a 
  left join 
    signups as b 
  on 
    a.lead_id = b.lead_id
  left join 
    purchases as c
  on
    b.lead_id = c.lead_id
  left join 
    churned_users as d 
  on  
    c.lead_id = d.lead_id
)

select 
  * 
from cte1
order by lead_id ;

"""
  Output =>

+---------+-------------+--------------+-------------+---------------+--------+------------+------------+
| lead_id | lead_source | lead_created | signup_date | purchase_date | amount | churn_date | reason     |
+---------+-------------+--------------+-------------+---------------+--------+------------+------------+
|       1 | Google      | 2025-01-01   | 2025-01-02  | 2025-01-10    |  99.00 | NULL       | NULL       |
|       2 | Meta        | 2025-01-01   | 2025-01-03  | 2025-01-11    | 150.00 | NULL       | NULL       |
|       3 | Organic     | 2025-01-02   | 2025-01-04  | NULL          |   NULL | NULL       | NULL       |
|       4 | Google      | 2025-01-02   | 2025-01-05  | 2025-01-12    |  49.00 | 2025-02-01 | Competitor |
|       5 | Meta        | 2025-01-03   | 2025-01-06  | 2025-01-15    | 199.00 | 2025-02-05 | Price      |
|       6 | LinkedIn    | 2025-01-03   | NULL        | NULL          |   NULL | NULL       | NULL       |
|       7 | Organic     | 2025-01-04   | 2025-01-07  | NULL          |   NULL | NULL       | NULL       |
|       8 | Google      | 2025-01-04   | 2025-01-08  | NULL          |   NULL | NULL       | NULL       |
|       9 | LinkedIn    | 2025-01-05   | NULL        | NULL          |   NULL | NULL       | NULL       |
|      10 | Meta        | 2025-01-05   | NULL        | NULL          |   NULL | NULL       | NULL       |
+---------+-------------+--------------+-------------+---------------+--------+------------+------------+
  
  """







