--Scalar Subquery (Returns ONE value)
--Find employees whose salary is above the average salary.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Subquery in SELECT (Inline Subquery)
--Add a calculated column using another table.
--Counts how many salary history entries the employee has.
SELECT 
    e.emp_id,
    e.first_name,
    (SELECT COUNT(*) FROM salaries s WHERE s.emp_id = e.emp_id) AS salary_records
FROM employees e;

--Subquery with IN
--Very common for filtering based on lists.
SELECT *
FROM employees
WHERE department IN (
    SELECT dept_name
    FROM departments
    WHERE location = 'New York'
);


--EXISTS Subquery (More efficient)
---Used to check if related rows exist.
SELECT e.*
FROM employees e
WHERE EXISTS (
    SELECT 1 
    FROM salaries s 
    WHERE s.emp_id = e.emp_id
);

--Correlated Subquery
--Find employees with the highest salary in each department.
SELECT e.*
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees e2
    WHERE e2.department = e.department
);

--Q1. Find employees who earn more than the average salary in their department.   
SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);
--Show employees who have at least 2 salary history records.
--Method 1: Using subquery in WHERE
SELECT *
FROM employees e
WHERE (
    SELECT COUNT(*)
    FROM salaries s
    WHERE s.emp_id = e.emp_id
) >= 2;

SELECT e.emp_id, e.first_name
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY e.emp_id, e.first_name
HAVING COUNT(*) >= 2;

--List departments where employee count is below the overall avg employee count per department

WITH dept_counts AS (
    SELECT department, COUNT(*) AS emp_count
    FROM employees
    GROUP BY department
),
avg_count AS (
    SELECT AVG(emp_count) AS avg_emp_count
    FROM dept_counts
)
SELECT d.department, d.emp_count
FROM dept_counts d, avg_count a
WHERE d.emp_count < a.avg_emp_count;

--Employees who don’t have a salary record
SELECT e.*
FROM employees e
WHERE NOT EXISTS (SELECT 1 FROM salaries s WHERE s.emp_id = e.emp_id);

--Find 2nd highest salary (no window function)

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

SELECT *
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);
