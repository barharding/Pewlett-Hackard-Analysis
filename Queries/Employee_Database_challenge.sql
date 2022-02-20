


--Challenge

--DELIVERABLE #1  The number of Retiring employees

--Part 1

-- Create a Retirement_titles table containing emp_no, first_name, Last_name from the Employees Table
--left join with titles  - data add title, from_date, to_date 
--into table called retirement_titles
-- use where to filer on birthdate 
--order by emp #
--export to data folder as retirement_titles.csv

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no

--DELIVERABLE # 1 Part 2
--Retrieve emp_no, first name, last name & titles from retirement titels table

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
					rt.first_name,
					rt.last_name,
					rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date ='9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

select * from unique_titles

--retrieve the number of employees by their most recent job title who are about to retire.
SElECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

--Deliverable # 2

--write a query to create a Mentorship eligibility table that holds the employees
--who are eligible to participate in a mentorship program
--retreive emp_no, first_name, last_name and birth_date from Employees Table
--retreive from_date and to_date from the Department Employee table
-- retreive title from te Titles table
--Distict ON emp_no
--INTO mentorship_eligibility
-- Filter WHERE to_date ='9999-01-01' and birth_date between January 1, 1965 and December 31, 1965
--orderby emp_no

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_emp AS de
		on (e.emp_no = de.emp_no)
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date ='9999-01-01');
ORDER BY e.emp_no;
