CREATE DATABASE salman;
use salman;
CREATE TABLE Employee(
	Emp_id INT PRIMARY KEY,
    Emp_name CHAR(20),
    Dept_name CHAR(10),
    Slary INT
);
INSERT INTO Employee VALUES(1000,'Basi','HR',40000),
						   (1001,'Salman','IT',60000),
                           (1002,'Jhony','Admin',50000),
						   (1003,'Raji','Finance',40000),
                           (1004,'Arjun','Admin',50000),
                           (1005,'Fayis','IT',60000),
                           (1006,'Adhil','HR',40000),
                           (1007,'Hari','Finance',50000);
SELECT * FROM Employee;
ALTER TABLE Employee RENAME Column Slary TO Salary;
SELECT MAX(Salary) AS MaximumSalary FROM Employee;
SELECT * FROM Employee WHERE Salary IN (SELECT MAX(Salary) AS MaximumSalary FROM Employee);
SELECT Dept_name, MAX(Salary) Max_Salary FROM Employee GROUP BY Dept_name;

#WINDOW FUNCTIONS
SELECT e.*, MAX(Salary) OVER() AS max_sal FROM Employee e;
SELECT e.*, MAX(Salary) OVER(PARTITION BY Dept_name) AS max_salary FROM Employee e;
SELECT *, MAX(Salary) OVER(PARTITION BY Dept_name) AS max_salary FROM Employee;

#ROW_NUMBER, RANK, DENSE_RANK, LEAD, LAG
SELECT e.*, row_number() OVER() as rn FROM Employee e;
SELECT e.*, row_number() OVER(PARTITION BY Dept_name) as rn FROM Employee e;
SELECT *, row_number() OVER(PARTITION BY Dept_name) as rn FROM Employee;
INSERT INTO Employee VALUES(1008,'Jyothi','Finance',50000),
						   (1009,'Ashwathi','HR',40000),
						   (1010,'Laila','HR',40000),
						   (1011,'Athul','IT',60000),
						   (1012,'Abhijith','Admin',55000),
						   (1013,'Sudu','IT',65000);
SELECT * FROM Employee;
# for sorting we were used to order by emp_id
SELECT e.*, row_number() OVER(PARTITION BY Dept_name  ORDER BY Emp_id) as rn FROM Employee e;

#Q. Fethch the first 2 employees from each department to join the copmany.---> 2 employee from each department

SELECT * FROM (
	SELECT e.*, row_number() OVER(PARTITION BY Dept_name  ORDER BY Emp_id) as rn 
    FROM Employee e) x
WHERE x.rn < 3;

# RANK
#Q.Fetch the top 3 employees in each department earning the max salary.

SELECT * FROM(
	SELECT e.*, RANK() OVER(PARTITION BY Dept_name ORDER BY Salary DESC) as rnk 
    FROM Employee e) X
WHERE X.rnk < 4;

#DENSE_RANK
SELECT e.*, RANK() OVER(PARTITION BY Dept_name ORDER BY Salary DESC) as rnk,
DENSE_RANK() OVER(PARTITION BY Dept_name ORDER BY Salary DESC) as Drnk,
ROW_NUMBER() OVER(PARTITION BY Dept_name ORDER BY Salary DESC) as rn
FROM Employee e;


# LEAD & LAG	
# fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee.
SELECT e.*, 
LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as prev_emp_sal,
LAG(Salary, 2, 0) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as 2_prev_emp_sal,
LEAD(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as next_emp_sal,
LAG(Salary, 2, 0) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as 2_next_emp_sal
FROM Employee e;

SELECT e.*, LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as prev_emp_sal FROM Employee e;
SELECT e.*, 
LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as prev_emp_sal,
CASE WHEN e.Salary > LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Higher than previous employee'
	 WHEN e.Salary < LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Lower than previous employee'
     WHEN e.Salary = LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Same as the previous employee'
     end sal_range
FROM Employee e;

SELECT e.*, 
LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) as prev_emp_sal,
CASE WHEN e.Salary > LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Higher than previous employee'
	 WHEN e.Salary < LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Lower than previous employee'
     WHEN e.Salary = LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Same as the previous employee'
     end sal_range
FROM Employee e;

SELECT e.*, 
LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) AS prev_emp_sal,
CASE WHEN e.Salary > LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Higher than previouse employee'
	 WHEN e.Salary < LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Less than previouse employee'
	 WHEN e.Salary = LAG(Salary) OVER(PARTITION BY Dept_name ORDER BY Emp_id) THEN 'Less than previouse employee'
     ELSE 0
END sal_range
FROM Employee e;


----------------------------
#CTE(Common Table Expression)
#WITH CLAUSE
SELECT * FROM Employee;
WITH cte AS(SELECT Emp_id, Salary FROM Employee) SELECT * FROM cte;

SELECT Emp_id, MAX(Salary) AS max_sal FROM Employee GROUP BY Emp_id;
WITH cte2 AS (SELECT Emp_id, MAX(Salary) max_sal FROM Employee GROUP BY Emp_id)
SELECT * FROM cte2;

WITH cte3 AS(SELECT Dept_name, ROUND(AVG(Salary)) AS avg_sal FROM Employee GROUP BY Dept_name)
SELECT * FROM cte3;
WITH cte3 AS(SELECT Dept_name, AVG(Salary) AS avg_sal FROM Employee GROUP BY Dept_name)
SELECT MAX(avg_sal)  FROM cte3;

SELECT AVG(Salary) AS avg_sal FROM Employee;
SELECT Emp_id, AVG(Salary) AS avg_sal FROM Employee GROUP BY Emp_id;

#Q. Fetch employees who earn more than average salary of all employees
WITH avg_salary(avg_sal) AS(SELECT AVG(Salary) FROM Employee)
SELECT * 
FROM Employee e, avg_salary av
WHERE e.Salary > av.avg_sal;

WITH cte(avg_sal) AS (SELECT ROUND(AVG(Salary)) FROM Employee)
SELECT * FROM Employee e, cte s
WHERE e.Salary > s.avg_sal;
-- QUERY 2 :
create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);
insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;
# Q.Find stores who's sales where better than the average sales across all stores
1.----total sales per store;
SELECT store_id, SUM(cost) as total_sales_per_store FROM sales GROUP BY store_id;
2.----average sales per store;
SELECT AVG(total_sales_per_store) AS avg_sales_per_store
FROM (SELECT store_id, SUM(cost) as total_sales_per_store FROM sales GROUP BY store_id) x;
3.----better than average store

# USING SUBQUERIES
SELECT * FROM 
	(SELECT store_id, SUM(cost) as total_sales_per_store FROM sales GROUP BY store_id) AS total_sales
join
	(SELECT AVG(total_sales_per_store) AS avg_sales_per_store
    FROM (SELECT store_id, SUM(cost) as total_sales_per_store FROM sales GROUP BY store_id)x) avg_total_sales
ON total_sales.total_sales_per_store > avg_total_sales.avg_sales_per_store;



# USING WITH CLAUSE
WITH total_sales(store_id, total_sales_per_store)
	AS (SELECT store_id, SUM(cost) as total_sales_per_store FROM sales GROUP BY store_id),
    avg_total_sales(avg_sales_per_store) 
    AS(SELECT AVG(total_sales_per_store) AS avg_sales_per_store
    FROM total_sales)
SELECT * FROM total_sales ts
JOIN avg_total_sales av
ON ts.total_sales_per_store > av.avg_sales_per_store;



WITH total_sales(store_id,total_sales_per_store) AS (SELECT store_id, SUM(cost) AS total_sales_per_store FROM sales GROUP BY store_id),
	avg_sales(avg_sales_cost) AS (SELECT AVG(total_sales_per_store) AS avg_sales_cost FROM total_sales) SELECT * FROM total_sales ts
join avg_sales avs
on ts.total_sales_per_store > avs.avg_sales_cost;

select * from sales;
# avg of each store
SELECT store_id, AVG(cost) sum_cost_per_store FROM sales GROUP BY store_id;
# avg of total
SELECT ROUND(AVG(cost)) AS total_avg FROM sales;







