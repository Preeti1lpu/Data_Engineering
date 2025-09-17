-- Sort employees by salary (lowest first)
SELECT * FROM employees
ORDER BY salary ASC;

-- Sort employees by salary (highest first)
SELECT * FROM employees
ORDER BY salary DESC;

-- Sort employees by department, then salary
SELECT * FROM employees
ORDER BY department ASC, salary DESC;

-- Top 3 highest paid employees
SELECT TOP 3 * FROM employees
ORDER BY salary DESC;

-- 2nd highest paid employee (skip 1, then take 1)
SELECT * FROM employees
ORDER BY salary DESC
OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY;

--List the top 2 employees with the highest salary.     
SELECT TOP 2 * 
FROM employees
ORDER BY salary DESC;

--Find the lowest paid employee.
SELECT TOP 1 * 
FROM employees
ORDER BY salary ASC;

--Show employees sorted by last name (A → Z).
SELECT * 
FROM employees
ORDER BY last_name ASC;

--Find the 3rd highest paid employee.
SELECT * 
FROM employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;

--List all employees in HR department, sorted by salary (highest first).
SELECT * 
FROM employees
WHERE department = 'HR'
ORDER BY salary DESC;

--Show the top 5 employees ordered by department, then salary descending.
SELECT TOP 5 * 
FROM employees
ORDER BY department ASC, salary DESC;

---Case Study Questions*****

---Find the top 3 highest paid employees across the company.
SELECT TOP 3 * 
FROM employees
ORDER BY salary DESC;

--List employees working in Sales, sorted by salary (highest first).
SELECT * 
FROM employees 
WHERE department = 'Sales' 
ORDER BY salary DESC;

--Get the 2nd lowest paid employee in Finance.
SELECT * 
FROM employees 
WHERE department = 'Finance'
ORDER BY salary ASC
OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY;


--Show all IT employees, sorted by last name.
SELECT * 
FROM employees 
WHERE department = 'IT'
ORDER BY last_name ASC;


--Find the department-wise top paid employee.
--(Hint: use ROW_NUMBER() with PARTITION BY)
SELECT emp_id, first_name, last_name, department, salary 
FROM ( SELECT *, ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn FROM employees ) 
t WHERE rn = 1;

--Retrieve the 3rd, 4th, and 5th highest paid employees overall.
SELECT emp_id, first_name, last_name, department, salary
FROM employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;


--Show all employees earning between 60,000 and 80,000, sorted by salary.
SELECT * 
FROM employees 
WHERE salary BETWEEN 60000 AND 80000
ORDER BY salary ASC;


--Find the employee with the longest last name.
SELECT TOP 1 * 
FROM employees
ORDER BY LEN(last_name) DESC;
