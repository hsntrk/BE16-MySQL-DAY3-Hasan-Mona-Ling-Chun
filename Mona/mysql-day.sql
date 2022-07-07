--  1. Report: 
-- How many rows do we have in each table in the employees database?
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;

-- 2. Report:
-- How many employees with the first name "Mark" do we have in our company?
SELECT COUNT(employees.first_name) FROM employees WHERE employees.first_name="Mark";
-- or 
SELECT COUNT(*) FROM employees WHERE first_name="Mark";

-- 3. Report:
-- How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company?
-- step1:
SELECT * FROM employees WHERE employees.first_name="Eric";
SELECT COUNT(*) FROM employees WHERE employees.first_name="Eric";
-- step2:
SELECT * FROM employees WHERE employees.last_name like "A%";
SELECT COUNT(*) FROM employees WHERE employees.last_name like "A%";
-- step3:
SELECT * FROM employees WHERE employees.first_name="Eric" AND employees.last_name like "A%";

SELECT COUNT(*) FROM employees WHERE employees.first_name="Eric" AND employees.last_name like "A%";

-- 4. Report:
--  How many employees do we have that are working for us since 1985 and who are they?
SELECT *
FROM employees
WHERE hire_date>('1985-1-1');

SELECT first_name,last_name
FROM employees
WHERE hire_date>('1985-1-1');

--  5. Report:
--  How many employees got hired from 1990 until 1997 and who are they?
SELECT * FROM employees 
WHERE hire_date>('1990 -1-1') 
AND hire_date<('1997-1-1');

SELECT first_name,last_name
FROM employees 
WHERE hire_date>('1990 -1-1') 
AND hire_date<('1997-1-1');

-- 6. Report:
--  How many employees have salaries higher than EUR 70 000,00 and who are they? 
SELECT employees.first_name , employees.last_name
FROM employees
WHERE employees.emp_no IN (SELECT DISTINCT salaries.emp_no FROM salaries WHERE salaries.salary > 70000);
                          

--  7. Report:
--  How many employees do we have in the Research Department, who are working for us since 1992 and who are they?
-- TIP: You can use the CURRENT_DATE() FUNCTION to access today's date

-- step 1 
SELECT employees.first_name , employees.last_name
FROM employees
WHERE hire_date>('1992-1-1');

-- step 2 
SELECT * FROM departments
WHERE departments.dept_no = "d008";

-- step 3 
SELECT employees.first_name , employees.last_name
FROM employees
WHERE employees.emp_no IN (SELECT DISTINCT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no="d008") 
AND hire_date>('1992-1-1');


--  8. Report:
--  How many employees do we have in the Finance Department, who are working for us since 1985 until now and who have salaries higher than EUR 75 000,00 - who are they?
-- step 1 
SELECT * FROM dept_emp WHERE dept_emp.dept_no="d002";

-- step 2
SELECT first_name,last_name
FROM employees
WHERE hire_date>('1985-1-1');

-- step 3
SELECT * FROM salaries 
WHERE salaries.to_date > CURRENT_DATE();

-- step 4 
SELECT DISTINCT salaries.emp_no FROM salaries WHERE salaries.salary > 75000;

-- step 5 (merge step3 and 4)
SELECT DISTINCT salaries.emp_no FROM salaries
WHERE salaries.to_date > CURRENT_DATE() AND salaries.salary > 75000 

-- step 6 
SELECT employees.first_name , employees.last_name
FROM employees
WHERE employees.emp_no In (SELECT DISTINCT salaries.emp_no FROM salaries
	WHERE salaries.to_date > CURRENT_DATE() AND salaries.salary > 75000 )

AND employees.emp_no In (SELECT dept_emp.emp_no FROM dept_emp WHERE dept_emp.dept_no="d002")

AND hire_date>('1985-1-1');