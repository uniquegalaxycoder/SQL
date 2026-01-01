"""
  Q. Find all employees and their project names (including employees not assigned to any project).
"""

  
CREATE TABLE PROJECTS (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50)
);

CREATE TABLE EMPLOYEES (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    project_id INT,
    FOREIGN KEY (project_id) REFERENCES PROJECTS(project_id)
);

INSERT INTO PROJECTS (project_id, project_name) VALUES 
(1, 'Website Redesign'),
(2, 'Mobile App'),
(3, 'Data Migration');

INSERT INTO EMPLOYEES (emp_id, emp_name, project_id) VALUES 
(101, 'John Doe', 1),
(102, 'Riya Gupta', 2),
(103, 'Amit Sharma', NULL), 
(104, 'Vikram Singh', 1),
(105, 'Sana Khan', NULL);   

select * from PROJECTS;
select * from EMPLOYEES ;


with cte1 as (
  select 
    a.emp_id,
    a.emp_name,
    b.project_name
  from 
    EMPLOYEES as a 
  left join PROJECTS as b 
  on 
    a.project_id = a.project_id 
)

select * from cte1


"""
Output =>

+--------+--------------+------------------+
| emp_id | emp_name     | project_name     |
+--------+--------------+------------------+
|    101 | John Doe     | Data Migration   |
|    101 | John Doe     | Mobile App       |
|    101 | John Doe     | Website Redesign |
|    102 | Riya Gupta   | Data Migration   |
|    102 | Riya Gupta   | Mobile App       |
|    102 | Riya Gupta   | Website Redesign |
|    103 | Amit Sharma  | NULL             |
|    104 | Vikram Singh | Data Migration   |
|    104 | Vikram Singh | Mobile App       |
|    104 | Vikram Singh | Website Redesign |
|    105 | Sana Khan    | NULL             |
+--------+--------------+------------------+
"""

