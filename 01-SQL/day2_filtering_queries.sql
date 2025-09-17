-- Employees in IT department
SELECT * FROM employees
WHERE department = 'IT';

-- Employees with salary > 60000
SELECT * FROM employees
WHERE salary > 60000;

-- Employees NOT in HR
SELECT * FROM employees
WHERE department != 'HR';

-- Employees in IT with salary >= 75000
SELECT * FROM employees
WHERE department = 'IT' AND salary >= 75000;

-- Employees whose name starts with 'A'
SELECT * FROM employees
WHERE first_name LIKE 'A%';
