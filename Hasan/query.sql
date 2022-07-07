-- 1. Preport:
--  How many rows do we have in each table in the employees database?

SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;


SELECT TABLE_NAME, table_rows FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_SCHEMA = 'employees';

result: 
-- TABLE_NAME	
-- table_rows	
-- departments
-- 9
-- dept_emp
-- 331143
-- dept_manager
-- 24
-- employees
-- 299246
-- salaries
-- 2838736
-- titles
-- 443080



-- 2. Report:
-- How many employees with the first name "Mark" do we have in our company?

SELECT count(employees.first_name) FROM employees WHERE first_name = "Mark";

-- result: 230



-- 3. Report:
-- How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?

SELECT COUNT(*) 
FROM employees 
WHERE employees.last_name LIKE "A%" AND employees.first_name = "Eric";

-- COUNT(*)
-- 13


-- 4.Report
--  How many employees do we have that are working for us since 1985 and who are they?

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees 
WHERE YEAR(employees.hire_date) > "1985";

SELECT COUNT(employees.first_name)
FROM employees 
WHERE YEAR(employees.hire_date) > "1985";



-- 5.Report
--  How many employees got hired from 1990 until 1997 and who are they?

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees 
WHERE YEAR(employees.hire_date) >= "1990" AND YEAR(employees.hire_date) <= "1997";






-- 6.Report
--  How many employees have salaries higher than EUR 70 000,00 and who are they? 

SELECT employees.first_name, employees.last_name
FROM employees 
WHERE employees.emp_no IN (SELECT salaries.salary FROM salaries WHERE salaries.salary > 70000);


SELECT employees.first_name, employees.last_name
FROM employees
where employees.emp_no IN (SELECT salaries.emp_no from salaries where salary > 70000);


SELECT emp_no from salaries where salary > 70000;


SELECT employees.first_name, employees.last_name
FROM employees 
WHERE employees.emp_no IN (SELECT DISTINCT salaries.emp_no FROM salaries WHERE salaries.salary > 70000);


--  7. Report:
--  How many employees do we have in the Research Department, who are working for us since 1992 and who are they?


SELECT employees.first_name, employees.last_name
FROM employees 
WHERE employees.emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.from_date >= "1992-01-01" AND dept_emp.dept_no = "d008" AND dept_emp.to_date > CURRENT_DATE)


--  8. Report:

--  How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?

SELECT employees.first_name, employees.last_name FROM `employees` WHERE emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no = "d002" ) AND hire_date > "1985-01-01" and  employees.emp_no IN (SELECT emp_no FROM salaries WHERE salary >= 75000);


-- count

SELECT count(`emp_no`) FROM `employees` WHERE emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no = "d002" ) AND hire_date > "1985-01-01" and  employees.emp_no IN (SELECT emp_no FROM salaries WHERE salary >= 75000);




--  9. Report:

--  We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.

SELECT employees.first_name, employees.last_name, employees.birth_date, employees.gender, employees.hire_date, titles.title, salaries.salary
FROM employees 
JOIN titles on titles.emp_no = employees.emp_no
JOIN salaries on salaries.emp_no = employees.emp_no

WHERE employees.emp_no IN (SELECT DISTINCT dept_emp.emp_no FROM dept_emp WHERE dept_emp.to_date > CURRENT_DATE)


-- no repeat entries

SELECT employees.first_name, employees.last_name, employees.birth_date, employees.gender, employees.hire_date, titles.title, salaries.salary
FROM employees 
JOIN titles on titles.emp_no = employees.emp_no
JOIN salaries on salaries.emp_no = employees.emp_no

WHERE employees.emp_no IN (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.to_date > CURRENT_DATE) GROUP BY employees.emp_no



--  10. Report:

--  We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.

SELECT employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, employees.gender, employees.hire_date, titles.title, departments.dept_name, departments.dept_no, salaries.salary
  FROM `employees` 
  INNER JOIN `titles` ON titles.emp_no = employees.emp_no
  INNER JOIN `salaries` ON salaries.emp_no = employees.emp_no 
  INNER JOIN `dept_manager` ON dept_manager.emp_no = employees.emp_no
  INNER JOIN `departments` ON departments.dept_no = dept_manager.dept_no
  INNER JOIN `dept_emp` ON dept_emp.emp_no = dept_emp.emp_no
  WHERE salaries.to_date >= CURRENT_DATE  
  ORDER BY `employees`.`emp_no` ASC


