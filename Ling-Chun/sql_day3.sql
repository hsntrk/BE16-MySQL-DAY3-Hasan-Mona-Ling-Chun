-- 1. Report:
select count(*) FROM departments; --9
select COUNT(*) FROM dept_emp; --331603
select COUNT(*) FROM dept_manager; --24
select COUNT(*) FROM employees; --300024
select COUNT(*) FROM salaries; --2844047
select COUNT(*) FROM titles; --443308

--2. Report:
SELECT COUNT(*) FROM employees WHERE first_name = "Mark"; --230


--3. Report:
SELECT COUNT(*) FROM employees where first_name = "Eric" AND last_name like "A%"; --13


-- 4. Report:
SELECT first_name, last_name
FROM `employees` 
WHERE hire_date > ('1985-1-1');

SELECT count(*)
FROM `employees` 
WHERE hire_date > ('1985-1-1');

-- 5. Report:
-- How many employees got hired from 1990 until 1997 and who are they?
SELECT first_name, last_name
FROM employees 
WHERE employees.hire_date > ('1990-1-1')
AND employees.hire_date < ('1997-12-31');

SELECT count(*) 
FROM employees 
WHERE employees.hire_date > ('1990-1-1')
AND employees.hire_date < ('1997-12-31');

--  6. Report:
-- How many employees have salaries higher than EUR 70 000,00 and who are they? 
SELECT employees.first_name, employees.last_name 
FROM employees
WHERE emp_no IN (SELECT DISTINCT emp_no FROM salaries WHERE salaries.salary > 70000);

SELECT count(*)  
FROM employees
WHERE emp_no IN (SELECT DISTINCT emp_no FROM salaries WHERE salaries.salary > 70000);

--  7. Report: 
-- How many employees do we have in the Research Department, who are working for us since 1992 and who are they?
SELECT first_name, last_name
FROM employees
WHERE employees.emp_no IN( 
	SELECT dept_emp.emp_no
	FROM dept_emp 
	WHERE dept_no = 'd008')
AND employees.hire_date > ('1992-1-1');

SELECT count(*)
FROM employees
WHERE employees.emp_no IN( 
	SELECT dept_emp.emp_no
	FROM dept_emp 
	WHERE dept_no = 'd008')
AND employees.hire_date > ('1992-1-1');

-- 8. Report:
-- How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?
SELECT employees.first_name , employees.last_name
FROM employees
WHERE employees.emp_no IN (
    SELECT DISTINCT salaries.emp_no FROM salaries
	WHERE salaries.to_date > CURRENT_DATE() 
    AND salaries.salary > 75000 )
AND employees.emp_no In (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no="d002")
AND hire_date > ('1985-1-1');

SELECT count(*)
FROM employees
WHERE employees.emp_no IN (
    SELECT DISTINCT salaries.emp_no FROM salaries
	WHERE salaries.to_date > CURRENT_DATE() 
    AND salaries.salary > 75000 )
AND employees.emp_no In (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no="d002")
AND hire_date > ('1985-1-1');

-- 9. Report:
-- We need a table with employees, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title and salary.
SELECT employees.first_name, employees.last_name, employees.birth_date, employees.gender, employees.hire_date, titles.title, salaries.salary
FROM employees
JOIN titles on employees.emp_no = titles.emp_no
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE titles.to_date > CURRENT_DATE();

 -- 10. Report:

 -- We need a table with managers, who are working for us at this moment: first and last name, date of birth, gender, hire_date, title, department name and salary.
SELECT  employees.first_name, employees.last_name, employees.birth_date,  employees.gender, employees.hire_date, titles.title, salaries.salary, dept_emp.to_date, departments.dept_name, dept_emp.to_date
FROM dept_manager
JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN titles ON employees.emp_no = titles.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_emp.to_date > CURRENT_DATE();

-- Bonus query:
-- Create a query that will join all tables and show all data from all tables.
SELECT * 
FROM employees 
JOIN dept_emp on dept_emp.emp_no = employees.emp_no
JOIN departments on departments.dept_no = dept_emp.dept_no
JOIN dept_manager on dept_manager.emp_no = employees.emp_no
JOIN salaries on salaries.emp_no = employees.emp_no
JOIN titles on titles.emp_no = employees.emp_no