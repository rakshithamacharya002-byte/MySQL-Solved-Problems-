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

INSERT INTO employee  VALUES
(101, 'Amit', 50000, '2020-01-15',"IT"),
(102, 'Riya', 60000, '2019-03-20',"Sales"),
(103, 'Karan', 55000, '2020-07-10',"IT"),
(104, 'Sneha', 70000, '2021-02-18',"Finance"),
(105, 'Arjun', 65000, '2020-11-25',"Sales");

--  How to write a query to find all employees who joined in the year 2020? 

select emp_name,hire_date from employee
where year(hire_date) = 2020;

--  Write a query to find employees whose name starts with 'A'. 

select emp_name from employees
where emp_name like 'A%';

-- Alter table add new colum department

alter table employee
add column department varchar(20) not null;

-- How to update the value for department column 

update employee
set department = "IT"
where emp_name = "Arjun";

-- 14. How to find the department with the highest number of employees? 

select department ,count(*) as number_employees from employee
group by department
having count(*) >1 ;

--  How to get the count of employees in each department? 

select department,count(*) as  number_employee
from employee
group by department;

-- Write a query to fetch employees having the highest salary in each department. 

select * from (
select * , dense_rank() over(partition by department order by salary desc) as rk
from employee ) as temp
where rk =1;

--  How to write a query to update the salary of all employees by 10%?

set sql_safe_updates = 0;

update employee
set salary = salary * 0.1;

--  How can you find employees whose salary is between 5000 and 6000?

select * from employee 
where salary between 5000 and 6000;

-- How to fetch the first and last record from a table?

(select * from employee limit 1)
union
(select * from employee order by emp_id desc limit 1);

--  How can you find the total number of departments in the company? 

select count(distinct department) as `Total Employees`
from employee;

-- How to find the department with the lowest average salary?

select department , avg(salary) as `Average Salary`
from employee
group by department
order by `Average Salary`
limit 1 ;

--  How to display all employees who have been in the company for more than 5 years?

select * from (select * ,TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) as year_experience
from employee) as temp
where year_experience > 5;

--  How to write a query to remove all records from a table but keep the table structure?

truncate table employee;

--  How to get the current month’s name from ?

select monthname(current_date()) as "Month_name";

 -- How to convert a string to lowercase in  :
 
select emp_name, lower(emp_name) as lower_case
from employee;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);


INSERT INTO sales VALUES
(1, 101, 'Laptop', 50000, '2024-01-10'),
(2, 102, 'Mobile', 20000, '2024-01-15'),
(3, 101, 'Keyboard', 1500, '2024-02-01'),
(4, 103, 'Monitor', 12000, '2024-02-10'),
(5, 102, 'Mouse', 800, '2024-02-15'),
(6, 101, 'Headphones', 2500, '2024-03-01');

select * from sales;

-- Write a query to calculate the total sales per customer in a sales table. 

select customer_id, sum(sale_amount) as total_sales
from sales
group  by customer_id;

--  How to find the second highest salary for each department?

select * from (
select *,dense_rank() over(partition by department order by salary desc) as rk
from employee) as temp
where rk = 2;

--  Write a query to fetch all employees whose names end with ‘n’. 

select * from employee
where emp_name like "%n";

--  How to find all employees who work in both departments IT and Sales?

select * from employee 
where department in ("IT","Sales");

-- Write a query to fetch the details of employees with the same salary. 

select * from employee;


--  How to write a query to list all employees without a department?

select * from employee
where department is null;

--  Write a query to find the maximum salary and minimum salary in each department

select department , max(salary), min(salary) 
from employee
group by department;

--  Write a query to display department-wise total and average salary.

select department , sum(salary), avg(salary)
from employee
group by department ;


CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    join_date DATE
);

INSERT INTO emp VALUES
(1,'Ravi',NULL,'2020-01-10'),
(2,'Amit',1,'2020-01-15'),
(3,'Sneha',1,'2021-03-20'),
(4,'Kiran',2,'2020-01-25'),
(5,'Neha',2,'2022-05-10');


-- How to find employees who joined the company in the same month and year as their manager?
 
 select * from emp;
 
 
 select e1.emp_name
 from emp e1
 join emp e2
 on e1.manager_id =e2.emp_id
 where month(e2.join_date) = month(e1.join_date) and year(e2.join_date) = year(e1.join_date);
 
 -- Write a query to count the number of employees whose names start and end with the same letter.

select count(*) from emp
where left(emp_name,1) = right(emp_name ,1);

-- How to retrieve employee names and salaries in a single string?

select concat(emp_name, " Earns: " ,salary) as Emp_salary
from employee;

CREATE TABLE e (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

INSERT INTO e VALUES
(101,'Amit','HR',35000,'2021-01-10'),
(102,'Ravi','IT',50000,'2020-03-15'),
(103,'Sneha','Finance',45000,'2019-07-20'),
(104,'Kiran','IT',52000,'2022-02-11'),
(105,'Neha','Marketing',40000,'2023-05-12'),
(106,'Arjun','Finance',48000,'2021-08-19'),
(107,'Pooja','IT',55000,'2018-11-25'),
(108,'Rahul','HR',37000,'2022-06-10'),
(109,'Vikram','Sales',42000,'2020-09-05'),
(110,'Anjali','Marketing',39000,'2023-01-14'),
(111,'Suresh','Admin',30000,'2021-04-18'),
(112,'Meena','IT',53000,'2019-10-22'),
(113,'Deepak','Finance',47000,'2022-07-07'),
(114,'Kavya','Sales',41000,'2023-03-03'),
(115,'Rohit','Legal',60000,'2021-12-12'),
(116,'Priya','Legal',62000,'2022-08-09'),
(117,'Manoj','Research',65000,'2018-05-16'),
(118,'Divya','Research',64000,'2019-06-30'),
(119,'Harish','Support',32000,'2020-11-21'),
(120,'Nisha','Support',33000,'2021-02-14');

--  Write a query to get employees who belong to departments with less than 3 employees.

select department, count(*) as number_emp
from e
group by department
having number_emp < 3;

--  How to write a query to delete employees who have been in the company for more than 3 years? 

select * ,timestampdiff(year,hire_date,curdate()) as years_experience
from e
where timestampdiff(year,hire_date,curdate()) >3;


-- Nth Highest salary using User defined Functions

set global log_bin_trust_function_creators = 1;

CREATE FUNCTION `Nth_highest_salary`(n int)
RETURNS int
BEGIN
RETURN (select salary from employees
order by salary desc limit n);
END;

-- Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. 
-- Note that after a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no "holes" between ranks.

CREATE TABLE scores (
    student_id INT,
    student_name VARCHAR(50),
    subject VARCHAR(50),
    score INT
);

INSERT INTO scores VALUES
(1,'Arjun','Math',95),
(2,'Rahul','Math',88),
(3,'Sneha','Math',95),
(4,'Kiran','Math',80),
(5,'Anita','Math',88),
(6,'Ravi','Math',76),
(7,'Priya','Math',95),
(8,'Manoj','Math',70),
(9,'Deepa','Math',80),
(10,'Suresh','Math',65),
(11,'Asha','Math',88),
(12,'Vikram','Math',92),
(13,'Nisha','Math',92),
(14,'Rohit','Math',85),
(15,'Pooja','Math',70),
(16,'Ajay','Math',76),
(17,'Divya','Math',95),
(18,'Karthik','Math',88),
(19,'Meena','Math',80),
(20,'Tarun','Math',65),
(21,'Neha','Math',92),
(22,'Varun','Math',70),
(23,'Lakshmi','Math',76),
(24,'Harish','Math',85),
(25,'Swathi','Math',92);


select * , dense_rank() over(order by score desc) as `rank`
from scores;

-- Employee more than manager

CREATE TABLE em (
    emp_id INT,
    emp_name VARCHAR(50),
    salary INT,
    manager_id INT
);

INSERT INTO em VALUES
(1,'Arjun',90000,NULL),
(2,'Rahul',60000,1),
(3,'Sneha',95000,1),
(4,'Kiran',50000,2),
(5,'Anita',65000,2),
(6,'Ravi',70000,3),
(7,'Priya',98000,3),
(8,'Manoj',45000,4),
(9,'Deepa',55000,4),
(10,'Suresh',62000,5),
(11,'Asha',75000,5),
(12,'Vikram',80000,6),
(13,'Nisha',72000,6),
(14,'Rohit',88000,7),
(15,'Pooja',93000,7);

select * from em;

select e1.emp_name,e1.salary as 'employee salary', e2.emp_name  as 'Manager name', e2.salary as 'manager salary'
from em e1
join em e2
on e1.manager_id = e2.emp_id
where e1.salary> e2.salary;

-- How to Find out duplicate emails 

CREATE TABLE person (
    id INT,
    email VARCHAR(100)
);

INSERT INTO person VALUES
(1,'a@gmail.com'),
(2,'b@gmail.com'),
(3,'a@gmail.com'),
(4,'c@gmail.com'),
(5,'b@gmail.com'),
(6,'d@gmail.com'),
(7,'a@gmail.com'),
(8,'e@gmail.com');

select * from person;

select email
from person
group by email
having count(*) > 1;
 
-- or

select distinct email from
(select *, row_number() over(partition by email) as rw
from person) as temp
where rw >1;

-- WAQTD Customers who have never ordered anything

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT
);

INSERT INTO customers VALUES
(1,'Arjun'),
(2,'Sneha'),
(3,'Rahul'),
(4,'Priya'),
(5,'Kiran'),
(6,'Anita');

INSERT INTO orders VALUES
(101,1),
(102,3),
(103,3),
(104,4);

select c.customer_name 
from customers   c
left join orders o
on c.customer_id = o.customer_id
where o.customer_id is null;

CREATE TABLE empp (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
 
INSERT INTO empp VALUES
(101, 'Rahul', 'IT', 70000),
(102, 'Sneha', 'IT', 90000),
(103, 'Amit', 'IT', 85000),
(104, 'John', 'HR', 60000),
(105, 'Priya', 'HR', 75000),
(106, 'David', 'HR', 75000),
(107, 'Karan', 'Sales', 65000),
(108, 'Neha', 'Sales', 72000),
(109, 'Ravi', 'Sales', 72000),
(110, 'Anjali', 'Finance', 80000),
(111, 'Vikram', 'Finance', 95000),
(112, 'Sara', 'Finance', 90000);

select * from empp;

-- 	Department wise Highest salary

select department ,max(salary) as Highest_salary
from empp
group by department ;


select emp_name,salary,department
from(select *,dense_rank() over(partition by department order by salary desc) as rk
from empp) temp
where rk = 1;


CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Department VALUES
(1, 'IT'),
(2, 'Sales'),
(3, 'HR'),
(4, 'Finance');

CREATE TABLE Emp_data(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT
);

INSERT INTO Emp_data VALUES
(1, 'Joe', 70000, 1),
(2, 'Jim', 90000, 1),
(3, 'Henry', 80000, 2),
(4, 'Sam', 60000, 2),
(5, 'Max', 90000, 1),
(6, 'Ravi', 75000, 3),
(7, 'Anjali', 85000, 4),
(8, 'Kiran', 85000, 4);

select * from emp_data;
select * from department;

-- Fetch Employee_name with higest salary in each department

select e.name as emp_name, d.name as dept_name, e.salary
from emp_data e
join department d
on e.departmentid = d.id
where (e.departmentid ,e.salary) in(
select departmentid , max(salary) 
from emp_data
group by departmentid);


with combined_data as (select e.name as emp_name, d.name as dept_name, e.salary as salary
from emp_data e
join department d
on e.departmentid = d.id),
ranked as (select *,dense_rank() over(partition by dept_name order by salary desc) as rk
from combined_data)

select emp_name,dept_name,salary from ranked
where rk = 1;


INSERT INTO Emp_data VALUES
(9, 'Abhi', 75000, 1),
(10, 'Jhon', 98000, 1),
(11, 'Harry', 86000, 2),
(12, 'Sam', 58000, 2),
(13, 'Maxy', 86000, 2),
(14, 'Roy', 78000, 3),
(15, 'Anju', 81000, 3),
(16, 'Kavya', 78000, 3),
(17,'Bhavish',96000,4),
(18,'Suresh',72000,4);

-- Department wise Top 3 Salary

select * from emp_data;

with joined_data as (
	select e.name as employee_name, d.name as department_name, e.salary
	from emp_data e
	join department d
	on e.departmentid = d.id),
ranked_data as (select *, dense_rank() over(partition by department_name order by salary desc) as rk
				from joined_data)
                
select employee_name,department_name,salary from ranked_data
where rk <= 3;

set sql_safe_updates= 0;

-- How to update the Records

update emp_data
set salary = 82000
where name = "Kiran";

-- how to delete duplicates from tables

delete from person
where id in (select id from 
(select *,roW_number() over(partition by email) as rw
from person) as temp
where rw <> 1);

select * from person;

