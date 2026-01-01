"""
    Q.Show students and their exam scores; if a student didn’t attempt the exam, show score as NULL.
"""
  
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

CREATE TABLE exam_scores (
    exam_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, student_name) VALUES 
(1, 'Liam Wilson'),
(2, 'Sophia Chen'),
(3, 'Noah Garcia'),
(4, 'Emma Brown');

INSERT INTO exam_scores (exam_id, student_id, subject, score) VALUES 
(101, 1, 'Mathematics', 85),
(102, 2, 'Mathematics', 92),
(103, 1, 'Physics', 78);

select * from students;
select * from exam_scores ;

with cte1 as (
  select 
    a.student_id,
    a.student_name,
    b.exam_id,
    b.subject,
    coalesce(b.score, NULL) as "Score"
  from 
    students as a 
  left join 
    exam_scores as b 
  on a.student_id = b.student_id
)

select 
  student_name,
  subject,
  Score
from cte1 ;

"""
  Output => 
+--------------+-------------+-------+
| student_name | subject     | Score |
+--------------+-------------+-------+
| Liam Wilson  | Mathematics |    85 |
| Liam Wilson  | Physics     |    78 |
| Sophia Chen  | Mathematics |    92 |
| Noah Garcia  | NULL        |  NULL |
| Emma Brown   | NULL        |  NULL |
+--------------+-------------+-------+
  
  """

