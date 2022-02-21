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

In order to understand the magnitude of the "silver" tsunami a series of SQL statements were executed to identify the impacted employees, their current title, and a count of roles.

**_SQL Query # 1_**
```python
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


## Summary: 
Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."
How many roles will need to be filled as the "silver tsunami" begins to make an impact?
Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
