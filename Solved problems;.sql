create database e;
use e;

-- Senario based questions:
 
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (emp_id, emp_name, department, salary, hire_date) VALUES
(101, 'Rahul', 'HR', 25000.00, '2023-01-15'),
(102, 'Anita', 'Finance', 30000.00, '2022-11-20'),
(103, 'Vikram', 'IT', 45000.00, '2021-06-10'),
(104, 'Sneha', 'Marketing', 28000.00, '2023-03-05'),
(105, 'Arjun', 'IT', 50000.00, '2020-09-18');

select * from employees;

-- Find second highest salary from employee table.
select salary 
from employees
order by salary desc
limit 1;

-- Find employees earning more than average salary.

select salary from employees
where salary>
(select avg(salary) from employees);

-- Count number of employees in each department.

select department, count(*) as no_employees
from employees
group by department;

-- Find duplicate records in a table.

select emp_name from employees
group by emp_name,department,salary
having count(*)>1;

-- OR

select emp_name from (
select *,row_number() over(partition by emp_name) as row_num
from employees) e
where row_num >1;

-- Delete duplicate records but keep one

delete from employees
where emp_id = (
select emp_id from (
select *,row_number() over(partition by emp_name) as row_num
from employees) e
where row_num >1);

-- Find employees hired in last 30 days.

select * from employees
where hire_date >= curdate() - interval 30 day;

-- Get highest salary department-wise.

select department , max(salary)
from employees
group by department;

-- Find employees whose name starts with 'A'

select * from employees
where emp_name like 'A%' ;

-- Find total salary expense of company.

select sum(salary) as `Total monthly expenses`
from employees;

-- Find 3rd highest salary using:

select * from
(
select *,dense_rank() over(order by salary desc) as rk
from employees) e 
where rk = 3;

-- Get department having more than 1 employees.

select department from employees
group by department 
having count(*) >1;

-- Find employees working in either HR or IT.

select * from employees
where department in ('Hr','IT');

-- Delete employees from Marketing department.

set sql_safe_updates=0;

delete from employees
where department = "Marketing";

-- Without using LIMIT / TOP, find highest salary.

select max(salary) as highest_salary from employees
order by salary;

-- OR

select salary from (select *,dense_rank() over(order by salary) as rk
from employees) e
where rk = 1;






