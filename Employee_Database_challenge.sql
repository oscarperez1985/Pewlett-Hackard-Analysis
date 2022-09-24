___________________________________
---------- DELIVERABLE 1 ----------
___________________________________
-- DESCRIPTION: create a retirement titles table that holds the most recent title
-- of every employee born between January 1, 1952 and December 31, 1955.

----- PART 1: Get the titles of each employee born qualified for retirement.
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_title
FROM employees AS e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Verify Outcome:
SELECT * FROM retirement_title;
___________________________________

----- PART 2: Use Dictinct with Orderby to remove duplicate rows.
SELECT DISTINCT ON (rt.emp_no)
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_title
FROM retirement_title AS rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- Verify Outcome
SELECT * FROM unique_title;
___________________________________

----- PART 3: Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_title_table
FROM unique_title as ut
GROUP BY ut.title
ORDER BY count DESC;

-- Verify Outcome
SELECT * FROM retiring_title_table;


___________________________________
---------- DELIVERABLE 2 ----------
___________________________________
-- DESCRIPTION: create a mentorship-eligibility table that holds the current
-- employees who were born between January 1, 1965 and December 31, 1965.

----- PART 1: Create a Mentorship Eligibility table.
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Verify Outcome
SELECT * FROM mentorship_eligibility;