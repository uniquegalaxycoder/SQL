"""
  Find the missing data ( Anti Join )

 Remember : 
    - An Anti-Join is a specific type of join used to find rows in one table that have no matching records in another table. 
    While 'Anti-Join' is the conceptual name used in database theory, it is typically implemented in SQL using a LEFT JOIN
    combined with a WHERE clause or the NOT EXISTS operator.
    
    -Think of it as the opposite of an INNER JOIN. Instead of finding the intersection, you are finding the 'leftovers.'
  
  """
  
create table campaign (
  campaign_id bigint,
  campain_name varchar(40),
  campaign_start_date date,
  campaign_end_date date
);

create table leads (
  lead_id bigint,
  lead_date date,
  campaign_id bigint
);

INSERT INTO campaign (campaign_id, campain_name, campaign_start_date, campaign_end_date) VALUES 
(1, 'New Year Kickoff', '2026-01-01', '2026-01-15'),
(2, 'Winter Clearance', '2026-01-10', '2026-01-31'),
(3, 'Spring Preview', '2026-03-01', '2026-03-15');

INSERT INTO leads (lead_id, lead_date, campaign_id) VALUES 
(101, '2026-01-02', 1), 
(102, '2026-01-15', 1), 
(103, '2025-12-31', 1), 
(201, '2026-01-12', 2), 
(202, '2026-02-05', 2);

select * from campaign;
select * from leads ;

"Solution Type - I"
  
select 
  a.*
from 
    campaign as a 
left join
    leads as b 
on 
  a.campaign_id = b.campaign_id
where
  b.campaign_id is null ; 


"Solution Type - II"

select 
  *
from 
  campaign as a 
where 
  not exists (
              select 
                *
              from 
                  leads as b 
              where 
                  b.campaign_id = a.campaign_id
            ) ;


"""
  Output => 

  +-------------+----------------+---------------------+-------------------+
  | campaign_id | campain_name   | campaign_start_date | campaign_end_date |
  +-------------+----------------+---------------------+-------------------+
  |           3 | Spring Preview | 2026-03-01          | 2026-03-15        |
  +-------------+----------------+---------------------+-------------------+
  """
  
  
  
  
