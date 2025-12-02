--Q1. Which department has the most employees?
SELECT TOP 1 department, COUNT(*) AS emp_count
FROM employees
GROUP BY department
ORDER BY emp_count DESC;

--Q2. Which department has the highest average salary?
SELECT TOP 1 department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

--Q3. Show total salary spend per department.
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;

--Q4. Which department spends more than 200,000 on salaries?
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 200000;

--Q5. Find the highest-paid employee in each department.
SELECT emp_id, first_name, last_name, department, salary
FROM (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn = 1;

--🔹 Q6. Which department has employees earning below the company-wide average salary?
-- Step 1: Find company average
WITH company_avg AS (
    SELECT AVG(salary) AS avg_salary FROM employees
)
-- Step 2: Compare dept averages
SELECT department, AVG(salary) AS dept_avg_salary
FROM employees, company_avg
GROUP BY department, avg_salary
HAVING AVG(salary) < avg_salary;



