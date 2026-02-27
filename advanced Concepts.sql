create database interview_ques;

use interview_ques;

CREATE TABLE transactions (
    customer_id INT,
    amount DECIMAL(10,2),
    txn_date DATE
);

INSERT INTO transactions (customer_id, amount, txn_date) VALUES
(101, 500, '2025-01-05'),
(102, 300, '2025-01-10'),
(103, 700, '2025-01-15'),
(101, 200, '2025-01-20'),
(104, 900, '2025-01-25'),
(105, 100, '2025-01-28'),

(101, 800, '2025-02-02'),
(102, 1000, '2025-02-05'),
(103, 200, '2025-02-18'),
(104, 400, '2025-02-20'),
(105, 300, '2025-02-27'),

(101, 600, '2025-03-04'),
(102, 1100, '2025-03-10'),
(103, 500, '2025-03-12'),
(104, 200, '2025-03-15'),
(105, 900, '2025-03-28');

select * from transactions where customer_id = 101;

select count(*) as total_number_transaction 
from transactions;

select customer_id, sum(amount) as total_amount
from transactions
group by customer_id;

select customer_id,count(*) as no_transactions
from transactions
group by customer_id
having count(*) > 2 ;

select max(amount) as highest_transaction
from transactions;

select amount
from transactions
order by amount desc
limit 1;

select * from transactions
where year(txn_date) = 2025 and month(txn_date) = 1;

with monthly_data as (select *,monthname(txn_date) as m from transactions)

select m,count(*) as no_traransactions from monthly_data
group by m;

select monthname(txn_date) as m, count(*) as no_trans from transactions
group by m;

select customer_id, monthname(txn_date) as m, sum(amount) as total_spent from transactions
group by customer_id,m;

with month_data as (select * , monthname(txn_date) as m from transactions)
select customer_id, m , sum(amount) as total from month_data
group by customer_id,m;

select * from transactions;

insert into transactions values
(101,500,'2025-01-06');


select customer_id, avg(amount) as avg_amt
from transactions
group by customer_id;

select monthname(txn_date) as `month` , sum(amount) as total_amount
from transactions
group by `month`;































with monthly_data as (select customer_id, amount,monthname(txn_date) as month_name from transactions),
total_revenue as (select *, sum(amount) over(partition by month_name,customer_id order by amount desc) as total_revenue from monthly_data),
rnk as (select *, dense_rank() over(partition by month_name order by total_revenue desc) as rk from total_revenue)

select customer_id, month_name, total_revenue from rnk
where rk <4;

WITH monthly_revenue AS (
    SELECT 
        customer_id,monthname(txn_date) month,
        SUM(amount) AS total_spent
    FROM transactions
    GROUP BY customer_id, monthname(txn_date)
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY total_spent DESC) AS rnk
    FROM monthly_revenue
)
SELECT month, customer_id, total_spent
FROM ranked
WHERE rnk <= 3
ORDER BY month, total_spent DESC;

with month_revenue as (
select customer_id , monthname(txn_date) as month_name, sum(amount) as s
from transactions
group by customer_id,monthname(txn_date)),
ranking as
( select *, dense_rank() over(partition by month_name order by s desc) as rk
from month_revenue 
)
select customer_id,month_name , s from ranking 
where rk <4;



CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    manager_id INT
);


INSERT INTO employees (emp_id, emp_name, salary, manager_id) VALUES
(1, 'John', 120000, NULL),     -- CEO
(2, 'Emma', 90000, 1),         -- Manager under John
(3, 'Raj', 85000, 2),          -- Employee under Emma
(4, 'Chris', 95000, 2),        -- Employee under Emma (earns more than manager)
(5, 'Priya', 70000, 2),        -- Employee
(6, 'Arun', 65000, 3),         -- Employee under Raj
(7, 'Neha', 90000, 3),         -- Employee under Raj (earns more than manager)
(8, 'Sam', 60000, 4),          -- Employee under Chris
(9, 'Kiran', 92000, 4); 

select * from employees;

select  e1.emp_name, e1.salary as employee_sal , e2.salary as manager_sal from employees e1
join employees e2
on e1.manager_id = e2.emp_id 
where e1.salary > e2.salary ;






CREATE TABLE sales (
    txn_id INT,
    product_id VARCHAR(10),
    txn_date DATE,
    amount INT
);

INSERT INTO sales VALUES
(1, 'P1', '2024-01-15', 500),
(2, 'P1', '2024-02-10', 450),
(3, 'P1', '2024-05-18', 600),
(4, 'P1', '2024-06-11', 430),
(5, 'P2', '2024-01-07', 200),
(6, 'P2', '2024-04-14', 220),
(7, 'P2', '2024-05-21', 250),
(8, 'P3', '2024-03-10', 300),
(9, 'P3', '2024-07-25', 350);

select * ,lead(txn_date) over() as leadd, lag (txn_date) over() as lagg from sales;

with month_data as (
select product_id ,amount, month(txn_date) as month_num 
from sales),
previous as
(select * , ifnull(lag(month_num) over (partition by product_id),0) as lg 
from month_data),
difference as 
(select *, month_num-lg as month_difference from previous)

select * from difference
where month_difference <> 1;










