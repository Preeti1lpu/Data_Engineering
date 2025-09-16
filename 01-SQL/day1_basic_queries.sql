 CREATE DATABASE company_db;
 CREATE TABLE employees (
    emp_id NUMERIC(10,3) PRIMARY KEY ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10,2)
);

INSERT INTO employees (emp_id,first_name, last_name, department, salary) VALUES
(1,'Alice', 'Johnson', 'HR', 55000),
(2,'Bob', 'Smith', 'IT', 75000),
(3,'Charlie', 'Williams', 'Finance', 60000),
(4,'David', 'Brown', 'IT', 80000),
(5,'Eva', 'Davis', 'HR', 52000);

SELECT * FROM employees;