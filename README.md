# Pewlett-Hackard-Analysis

## Overview of the analysis: 
Pewlett-Hackard is facing a large wave of vacancies due to mass retirements.  This analysis is to research who will be retiring in the next few years and how many positions will need filled so that a mentorship program can be implemented minimize the impact.  In order to perform this analysis six CSV files have been supplied to be loaded into the PH-EmployeeDB:

- employees.csv
- departments.csv
- dept_emp.csv
- dept_manager.csv
- salaries.csv
- titles.csv

**_Figure 1: PH EmployeeDB Schema_**

![PH-EmployeeDB Schema](EmployeeDB.png)


## Results: 
Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.

In order to understand the magnitude of the "silver" tsunami a series of SQL statements were executed to identify the impacted employees, their current title, and a count of roles.  The final query is used to identify a list of employees who can help in a mentorship program.

**_SQL Query # 1: Identifying All eligible employees and their titles from the employees table_**
```sql
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
```
This query returns 133776 rows of employee names and titles who were born between Jan 1, 1952 and Dec 31, 1955.  Because this the employee table is joined with the titles table an employee can appear move than once in the list if they have held more than one title at PH.  The other important thing to note is that this data set includes employees who may no longer work at the company.  The results were written to the retirement_titles table and exported to a similarily named CSV.

**_SQL Query # 2: Filter on retirement_titles table for active retirees and the current titles_**
```sql
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
			rt.first_name,
			rt.last_name,
			rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date ='9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;
```
This query filters data in the retirement_titles table by selecting employees with a to_date of 9999-01-01 date in their current role.  The ORDER BY and DISTINCT ON key words in the SQL query causes the query to drop duplicate employee records (aka rows) and because of the order by on the to_date column the row with the current title will be the first row which is retained.    The query returns 72458 rows of data and the results are written to the unique_titles table and exported to a similarily named CSV.

**_SQL Query # 3: Count the number of titles (roles) retiring_**
```sql
SElECT COUNT(ut.emp_no),ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;
```
**_SQL Query # 4: Count the number of titles (roles) retiring_**
```sql
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
```
This query selects from the employee table current employees who were born in 1965 who would be eligible for a mentorship program.  There are 1549 eligible mentors.  The results were written to the mentorship_eligibility table and exported to a similarily named CSV.


## Summary: 
Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."
How many roles will need to be filled as the "silver tsunami" begins to make an impact?
Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
