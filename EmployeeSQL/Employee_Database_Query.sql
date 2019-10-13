CREATE TABLE departments (
	dept_no varchar(255),
	dept_name varchar(255)
);
CREATE TABLE dept_emp (
	emp_no int,
	dept_no varchar(255),
	from_date date,
	to_date date
);
CREATE TABLE dept_manager (
	dept_no varchar(255),
	emp_no int,
	from_date date,
	to_date date
);
CREATE TABLE employees (
	emp_no int,
	birth_date date,
	first_name varchar(255),
	last_name varchar(255),
	gender varchar(1),
	hire_date date
);
CREATE TABLE salaries (
	emp_no int,
	salary int,
	from_date date,
	to_date date
);
CREATE TABLE titles (
	emp_no int,
	title varchar(255),
	from_date date,
	to_date date
);

ALTER TABLE departments
ADD CONSTRAINT dept_no PRIMARY KEY (dept_no);
ALTER TABLE dept_emp
ADD CONSTRAINT dept_emp_PK PRIMARY KEY (emp_no, dept_no);
ALTER TABLE dept_manager
ADD CONSTRAINT dept_manager_pk PRIMARY KEY (dept_no, from_date);
ALTER TABLE employees
ADD CONSTRAINT emp_no PRIMARY KEY (emp_no);
ALTER TABLE salaries
ADD CONSTRAINT emp_no PRIMARY KEY (emp_no);
ALTER TABLE titles
ADD CONSTRAINT titles_pk PRIMARY KEY (emp_no, from_date);

ALTER TABLE dept_emp
ADD FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
ALTER TABLE dept_manager
ADD FOREIGN KEY (dept_no) REFERENCES departments(dept_no);
ALTER TABLE salaries
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);
ALTER TABLE titles
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);


-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, last_name, first_name, salary
FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.
SELECT *
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dept_manager.dept_no, dept_name, dept_manager.emp_no, first_name, last_name, from_date, hire_date
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE (first_name = 'Hercules') and (last_name LIKE 'B%');

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS last_name_count
FROM employees
GROUP BY last_name
ORDER BY last_name_count DESC;
