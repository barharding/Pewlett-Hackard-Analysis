drop table retirement_info;

--Create new table for retiring employees
select emp_no, first_name, Last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
	  and (hire_date between '1985-01-01' and '1988-12-31')

-- Check the table

SELECT * from retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    	retirement_info.first_name,
		retirement_info.last_name,
    	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Left join for retirement_info and dept_emp
Select ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.to_date
Into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date = ('9999-01-01');

select * from current_emp

--Employee count by department number
select count(ce.emp_no), de.dept_no
from current_emp as ce
LEFT join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
ORDER BY de.dept_no;

--Employee count by department number
select count(ce.emp_no), de.dept_no
into retire_dept_count
from current_emp as ce
LEFT join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
ORDER BY de.dept_no;

select * from retire_dept_count

select * from salaries
order by to_date desc;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date ='9999-01-01');

Select * from emp_info

--List of managers per department
SELECT dm.dept_no,
	d.dept_name,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		on (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no)
		
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

select * FROM departments

-- List of employees retiring from the sale team
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO 
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE de.dept_no in ('d007', 'd005')


--Challenge

--DELIVERABLE #1

-- Create a Retirement_titles table containing emp_no, first_name, Last_name
--left join with titles data add title, from_date, to_date 
-- use where to filer on birthdate (CE table already has filtered by retirement date)
--order by emp #
--export to data folder

SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM current_emp as ce
LEFT JOIN titles as t
ON (ce.emp_no = t.emp_no)
ORDER BY ce.emp_no

--DELIVERABLE #2
--Retrieve emp_no, first name, last name & titles from retirement titels table

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
--WHERE??
ORDER BY rt.emp_no, rt.to_date DESC;

select * from unique_titles

--retrieve the number of employees by their most recent job title who are about to retire.
SElECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;



