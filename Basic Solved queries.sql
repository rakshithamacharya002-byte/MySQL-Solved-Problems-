create database e_database ;
use e_database ;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);

INSERT INTO employees (emp_id, emp_name, salary) VALUES
(101, 'Rahul', 50000),
(102, 'Sneha', 75000),
(103, 'Amit', 60000),
(104, 'Priya', 75000),
(105, 'Kiran', 45000);

select * from employees;

--  How to retrieve the second-highest salary of an employee? 

select max(salary) as  `Second Highest salary`
from employees
where salary < (select max(salary) from employees);


--  How to get the nth highest salary in   ? 

select salary from (
select * , dense_rank() over(order by salary desc) as rk
from employees ) as Emp
where rk = 3;

-- How do you fetch all employees whose salary is greater than the average salary? 

select * from employees
where salary > (select avg(salary) from employees);

-- Write a query to display the current date and time in 

select curdate(); --  for date
select current_timestamp(); -- for date and time

--  How to find duplicate records in a table? 

select emp_name from employees
group by emp_name, salary
having count(*) >1;

-- How can you delete duplicate rows in   ?

delete from employees
where emp_name in (select emp_name from(select emp_name from employees
group by emp_name, salary
having count(*) >1) as temp);

--  How to retrieve the last 2 records from a table?

select * from employees
order by emp_id desc
limit 2;

-- How do you fetch the top 2 employees with the highest salaries? 

select emp_name from employees
order by salary desc
limit 2;

-- How to calculate the total salary of all employees? 

select sum(salary) as total_salary
from employees;

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employee (emp_id, emp_name, salary, hire_date) VALUES
(101, 'Amit', 50000, '2020-01-15'),
(102, 'Riya', 60000, '2019-03-20'),
(103, 'Karan', 55000, '2020-07-10'),
(104, 'Sneha', 70000, '2021-02-18'),
(105, 'Arjun', 65000, '2020-11-25');

--  How to write a query to find all employees who joined in the year 2020? 

select emp_name,hire_date from employee
where year(hire_date) = 2020;

--  Write a query to find employees whose name starts with 'A'. 

select emp_name from employees
where emp_name like 'A%';

