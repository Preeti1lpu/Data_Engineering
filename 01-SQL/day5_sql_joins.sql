--departments table
IF OBJECT_ID('departments', 'U') IS NOT NULL
    DROP TABLE departments;
GO

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'IT', 'Bangalore'),
(2, 'Sales', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'HR', 'Pune');

--salaries table
IF OBJECT_ID('salaries', 'U') IS NOT NULL
    DROP TABLE salaries;
GO

CREATE TABLE salaries (
    emp_id INT,
    salary INT,
    effective_date DATE
);

INSERT INTO salaries VALUES
(1, 75000, '2023-01-01'),
(1, 80000, '2024-01-01'),
(2, 65000, '2024-01-01'),
(3, 80000, '2024-01-01'),
(5, 85000, '2023-01-01'),
(5, 90000, '2024-01-01');

--INNER JOIN
-- Only matching records.
SELECT e.emp_id, e.first_name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.department = d.dept_name;

--LEFT JOIN
--→ All employees + matching departments.
SELECT e.emp_id, e.first_name, d.location
FROM employees e
LEFT JOIN departments d
ON e.department = d.dept_name;

--RIGHT JOIN
--→ All departments even if no employees.
SELECT e.emp_id, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.department = d.dept_name;

--FULL JOIN
--→ All rows from both sides.
SELECT e.emp_id, e.first_name, d.dept_name
FROM employees e
FULL JOIN departments d
ON e.department = d.dept_name;

--CROSS JOIN
--→ Creates combinations (NOT used often).
SELECT e.first_name, d.dept_name
FROM employees e
CROSS JOIN departments d;

--SELF JOIN
--→ Employee reports to manager.
--Add a column temporarily:
ALTER TABLE employees ADD manager_id INT NULL;
UPDATE employees SET manager_id = 5 WHERE emp_id IN (1, 2, 3);
UPDATE employees SET manager_id = NULL WHERE emp_id = 5;

SELECT e.first_name AS Employee,
       m.first_name AS Manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;

--Exercise 1
--List employees and their department location.
--For each employee, show their name + department location.
SELECT e.first_name AS employee, d.location
FROM employees e
INNER JOIN departments d
    ON e.department = d.dept_name;

--Exercise 2
--Show employees who have salary history (join employees + salaries).
--Show the highest salary each employee ever had (from salary history table).
SELECT e.first_name, s.salary
FROM employees e
INNER JOIN salaries s
    ON e.emp_id = s.emp_id;


--Exercise 3
--Show all departments and number of employees in each.
--(Hint: LEFT JOIN + GROUP BY)
--Show departments with no employees.
SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON e.department = d.dept_name
GROUP BY d.dept_name;


--Exercise 4
--Find employees whose department does NOT match any department table entry.
--(LEFT JOIN + WHERE dept is NULL)
--Show employees whose manager belongs to a different department.
SELECT e.first_name, e.department
FROM employees e
LEFT JOIN departments d
    ON e.department = d.dept_name
WHERE d.dept_name IS NULL;


--Exercise 5 – INTERVIEW LEVEL
--Find latest salary for each employee using JOIN + window function.
SELECT t.emp_id, t.first_name, t.salary
FROM (
    SELECT e.emp_id,
           e.first_name,
           s.salary,
           s.effective_date,
           ROW_NUMBER() OVER (
               PARTITION BY e.emp_id
               ORDER BY s.effective_date DESC
           ) AS rn
    FROM employees e
    JOIN salaries s
        ON e.emp_id = s.emp_id
) t
WHERE t.rn = 1;
