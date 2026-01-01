"""
    Q.Find mismatched records between two tables.
"""

  
CREATE TABLE products_prod (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE products_backup (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

-- Production Data
INSERT INTO products_prod VALUES 
(1, 'Laptop', 1200.00),
(2, 'Phone', 800.00),
(3, 'Tablet', 500.00);

-- Backup Data
INSERT INTO products_backup VALUES 
(1, 'Laptop', 1200.00),
(2, 'Phone', 750.00), 
(4, 'Monitor', 300.00);

select * from products_prod;
select * from products_backup;

""" Solution Type-I  """

with cte1 as (
    select 
      a.product_id as old_product_id,
      a.product_name as old_product_name,
      a.price as old_proce,
      b.product_id,
      b.product_name,
      b.price
    from
      products_prod as a 
    inner join 
      products_backup as b 
    on 
      a.product_id = b.product_id
    where( a.product_name <> b.product_name
    or a.price <> b.price)
)

select * from cte1;


""" Solution Type II """ 


select * from products_prod 
except
select * from products_backup 
union 
select * from products_backup
except
select * from products_prod ;


"""
  Output => 

+----------------+------------------+-----------+------------+--------------+--------+
| old_product_id | old_product_name | old_proce | product_id | product_name | price  |
+----------------+------------------+-----------+------------+--------------+--------+
|              2 | Phone            |    800.00 |          2 | Phone        | 750.00 |
+----------------+------------------+-----------+------------+--------------+--------+
 
"""






  

