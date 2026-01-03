"""
    Q.Find overlapping date ranges between two campaign tables.
"""

CREATE TABLE internal_campaigns (
    camp_id INT PRIMARY KEY,
    camp_name VARCHAR(50),
    start_date DATE,
    end_date DATE
);

CREATE TABLE partner_campaigns (
    partner_camp_id INT PRIMARY KEY,
    partner_name VARCHAR(50),
    start_date DATE,
    end_date DATE
);


INSERT INTO internal_campaigns VALUES 
(1, 'Summer Sale', '2026-06-01', '2026-06-15'),
(2, 'Winter Promo', '2026-12-01', '2026-12-31'),
(3, 'Tech Expo', '2026-03-01', '2026-03-10');


INSERT INTO partner_campaigns VALUES 
(101, 'Flash Deal', '2026-06-10', '2026-06-20'), 
(102, 'Holiday Special', '2026-12-15', '2026-12-20'), 
(103, 'Spring Fest', '2026-04-01', '2026-04-10'); 


select * from internal_campaigns;
select * from partner_campaigns ;

with cte1 as (
  select 
    a.camp_name,
    a.start_date as starts_date,
    a.end_date as camp_end_date,
    b.partner_name as partner_camp_name,
    b.start_date,
    b.end_date
  from 
    internal_campaigns as a 
  inner join 
    partner_campaigns as b 
  on 
    a.start_date <= b.end_date
  and
    b.start_date <= a.end_date
)

select * from cte1 ;

"""
    Output => 
    
        +--------------+-------------+---------------+-------------------+------------+------------+
        | camp_name    | starts_date | camp_end_date | partner_camp_name | start_date | end_date   |
        +--------------+-------------+---------------+-------------------+------------+------------+
        | Summer Sale  | 2026-06-01  | 2026-06-15    | Flash Deal        | 2026-06-10 | 2026-06-20 |
        | Winter Promo | 2026-12-01  | 2026-12-31    | Holiday Special   | 2026-12-15 | 2026-12-20 |
        +--------------+-------------+---------------+-------------------+------------+------------+
    """
