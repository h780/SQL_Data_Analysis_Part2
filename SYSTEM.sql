select * from DEPARTMENTS;
select * from JOB_HISTORY;
select * from LOCATIONS;
select * from JOBS;
select * from REGIONS;
select * from EMPLOYEES;
select * from COUNTRIES; 
select * from NON_FUNCTIONAL_LOCATIONS;

SELECT distinct DEPARTMENT_ID from employees;

---------Here we will join different tables and get the employee details--------

---------------------------------INNER JOIN-------------------------------------

SELECT *
FROM EMPLOYEES, DEPARTMENTS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
AND DEPARTMENTS.DEPARTMENT_NAME = 'Marketing';

--This query will join the employee and department table and fetch all the det--
--ails for the Marketing department employees as mentioned in the query. If th--
--ere are two columns with same name in both the tables, then the database wil--
--l create an another column.

--Now we will only fetch tha necessary details as the above gives lot of info---

SELECT EMPLOYEES.EMPLOYEE_ID,
EMPLOYEES.FIRST_NAME ||' '|| EMPLOYEES.LAST_NAME,
EMPLOYEES.EMAIL,
LOCATIONS.CITY
FROM EMPLOYEES, DEPARTMENTS, LOCATIONS
WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
AND DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
AND DEPARTMENTS.DEPARTMENT_NAME = 'Marketing';

--The above query only gives us the employee_id, name, email and city of emplo--

    -------------------------ANSI SQL INNER JOIN----------------------------

-----This has bit different structure than mysql, but basic output is same------

--ANSI Join

SELECT EMPLOYEES.EMPLOYEE_ID,
EMPLOYEES.FIRST_NAME ||' '|| EMPLOYEES.LAST_NAME,
EMPLOYEES.EMAIL,
LOCATIONS.CITY
FROM EMPLOYEES INNER JOIN DEPARTMENTS
ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
AND DEPARTMENTS.DEPARTMENT_NAME = 'Marketing'
INNER JOIN LOCATIONS
ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID;

--Basically inner join matches the specifies columns of table_1 with table_2 if-
--there is a match then it will fetch that as a result, or else nothing will be-
--fetched. It will not join the null values, as two null values are not same----

----------------------------Column Ambiguity Error------------------------------

--One of the most common error faced in query in real time scenario is column---
--ambiguity error.

SELECT *
FROM EMPLOYEES, DEPARTMENTS
WHERE DEPARTMENT_ID = DEPARTMENT_ID
AND DEPARTMENT_NAME = 'Marketing';

-----So, if we don't provide the table name we get column ambiguity error as---- 
--shown below.

--ORA-00918: column ambiguously defined
--00918. 00000 -  "column ambiguously defined"
--*Cause:    
--*Action:
--Error at Line: 63 Column: 23

--We get this error because our database is not able to identify which column---
--to get from which table. This error occurs when there is same column in diff--
--erent tables. To solve this error we use alias with the table name.

SELECT *
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND d.DEPARTMENT_NAME = 'Marketing';

----The above query will give us the correct results as we're using the alias---

SELECT e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME,
e.EMAIL,
l.CITY
FROM EMPLOYEES e INNER JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
AND d.DEPARTMENT_NAME = 'Marketing'
INNER JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID;

-------------------------------Left Outer Join----------------------------------

--Here we will list down all departments along with employees working under it--

--First we will fing the number of department we have and also the departments--
--available under the employee table.

SELECT DISTINCT DEPARTMENT_ID FROM DEPARTMENTS;

--This query results into 27 different departments under the department table---

SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

----This query results into 12 different departments under the employee table---

--Incorrect query.
SELECT d.DEPARTMENT_ID,
d.DEPARTMENT_NAME, 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME,
e.EMAIL
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

--The above query only results in the departments which has employee under it,--
--but it will not give us the department which do not have employees. Hence, we-
--use left outer join. Left outer join take the all the entries from left table-
--and matches it with the entries from right table and gives the result.

SELECT d.DEPARTMENT_ID,
d.DEPARTMENT_NAME, 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME,
e.EMAIL
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID(+)
ORDER BY d.DEPARTMENT_ID;

--In tradition mysql, we use + sign for left outer join, it gives null values---
--to the departments which do not have employees under it. This give all the re-
--cords from left table along with matching records from right table. If there--
--is no matching record it will give us null value.

    ------------------------ANSI LEFT OUTER JOIN----------------------------

SELECT d.DEPARTMENT_ID,
d.DEPARTMENT_NAME, 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME NAME,
e.EMAIL
FROM DEPARTMENTS d LEFT OUTER JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

-----We always use ON keyword with any join method we're using in our queyr-----

SELECT d.DEPARTMENT_ID,
d.DEPARTMENT_NAME, 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME NAME,
e.EMAIL
FROM DEPARTMENTS d LEFT JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

--If we don't use the OUTER keword with the join method, it will work the same--

-------------------------------Right Outer Join---------------------------------

--Here we will show the usecase of fetching all the employee details along with-
--their department details. We can join employee and dept table with dept_id as-
--a joining key. But, for some of the employees there is no department available
--Inner join will not work in this case, because it only catches matching id's--
--This can be done using left outer join, with employee table as left table.----
--Alternate solution is to use the Right outer join.

SELECT 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME,
e.EMAIL,
d.DEPARTMENT_ID,
e.DEPARTMENT_ID,
d.DEPARTMENT_NAME
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID(+) = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

    ------------------------ANSI RIGHT OUTER JOIN---------------------------

SELECT 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME,
e.EMAIL,
d.DEPARTMENT_ID,
e.DEPARTMENT_ID,
d.DEPARTMENT_NAME
FROM DEPARTMENTS d RIGHT OUTER JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

-------------------------------Full Outer Join----------------------------------

--Now, if the stakeholders ask for the data of all departments and all employees
--with thier missing values, i.e. data where employees do not have department an
--d vice versa, in that case we should use Full Outer Join, as it will give us t
--he reult as the full outer join of the data with the null values. 

    ------------------------ANSI FULL OUTER JOIN----------------------------
--Tradition full outer join with + sign will not work in this case.

SELECT d.DEPARTMENT_ID,
d.DEPARTMENT_NAME,
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME,
e.EMAIL
FROM DEPARTMENTS d FULL OUTER JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

--This gives us the result with null values for employees as weel as departments

----------------------------------SELF Join-------------------------------------

--Now, if the stakeholders want the details of employees with their managers. 
--Then we will use self join. This is because managers are also employee and the
--ir details also reside in the same table as employees. So, we join employee 
--table with employee table based on manager_id column.

SELECT 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME as EMPLOYEE_NAME,
e.EMAIL as EMP_EMAIL,
m.EMPLOYEE_ID as MGR_EMPLOYEE_ID,
m.FIRST_NAME ||' '|| m.LAST_NAME as EMP_MGR_NAME,
m.EMAIL as MGR_EMAIL
FROM EMPLOYEES e, EMPLOYEES m
WHERE e.MANAGER_ID = m.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;

--The above query will not give the results of the employees who do not have mgr
--In that case we can use Left join as below.

SELECT 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME as EMPLOYEE_NAME,
e.EMAIL as EMP_EMAIL,
m.EMPLOYEE_ID as MGR_EMPLOYEE_ID,
m.FIRST_NAME ||' '|| m.LAST_NAME as EMP_MGR_NAME,
m.EMAIL as MGR_EMAIL
FROM EMPLOYEES e, EMPLOYEES m
WHERE e.MANAGER_ID = m.EMPLOYEE_ID(+)
ORDER BY e.EMPLOYEE_ID;

--There will be the blank space for manager name column for employees with no 
--manager because we're doing concatenation, and as there is no manager so blank

    ------------------------ANSI SELF JOIN------------------------------

SELECT 
e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME as EMPLOYEE_NAME,
e.EMAIL as EMP_EMAIL,
m.EMPLOYEE_ID as MGR_EMPLOYEE_ID,
m.FIRST_NAME ||' '|| m.LAST_NAME as EMP_MGR_NAME,
m.EMAIL as MGR_EMAIL
FROM EMPLOYEES e JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID(+)
ORDER BY e.EMPLOYEE_ID;

------------------------------UNION & UNION ALL---------------------------------

--The UNION keyword will merge or combine all the results of the datasets which 
--we're passing. UNION ALL command is same as UNION command, except UNION ALL
--selects all the values, it will not eliminate duplicate values, it fetches all
--the rows from the table and combines them into one result.

--We're trying to combine the locations and non_functional_locations 

SELECT * FROM LOCATIONS; --Here we have 23 locations in all
SELECT * FROM NON_FUNCTIONAL_LOCATIONS; --Here we have 6 locations

SELECT 'FUNCTIONAL' LOC_TYPE, CITY, POSTAL_CODE FROM LOCATIONS 
UNION 
SELECT 'NON_FUNCTIONAL' LOC_TYPE, CITY, TO_CHAR(POSTAL_CODE) 
FROM NON_FUNCTIONAL_LOCATIONS;

--We use TO_CHAR to match the datatype of postal code columns of both tables.
--Also, we create one column to specify which city is functional and which is not

--Conditions for using UNION
--1. Number of column should be same in all the combined tables
--2. Data types of columns should be same in all the tables

--We can use UNION all to show the duplicate records also.

SELECT CITY, POSTAL_CODE FROM LOCATIONS 
UNION ALL
SELECT CITY, TO_CHAR(POSTAL_CODE) FROM NON_FUNCTIONAL_LOCATIONS
ORDER BY CITY;

--This query will also give us the duplicate results.

    --------------------FULL OUTER JOIN USING UNION-------------------------   

SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME, e.EMAIL
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID(+)
UNION
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME, e.EMPLOYEE_ID,
e.FIRST_NAME ||' '|| e.LAST_NAME, e.EMAIL
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID(+) = e.DEPARTMENT_ID;

--This is traditional way of writing full outer join using union operator.

------------------------------MINUS & INTERSECT---------------------------------

--This operation will perform minus operation on specified tables. For example,
--we want the unique records from location and non_functional_location tables.
--That means we want all the records from locations table and all records from
--non_functional_location which are not there in locations. If we have a demand
--to give such unique records of cities from both the tables, we can use minus.

SELECT CITY, POSTAL_CODE FROM LOCATIONS
MINUS
SELECT CITY, TO_CHAR(POSTAL_CODE) FROM NON_FUNCTIONAL_LOCATIONS;

--Number of columns and type of datatype should be same here

--We can use INTERSECT to find out the common values between two tables

SELECT CITY FROM LOCATIONS
INTERSECT
SELECT CITY FROM NON_FUNCTIONAL_LOCATIONS;

--Number of columns and type of datatype should be same here

----------------------------JOINING MULTIPLE TABLE------------------------------

--Sometimes, we don't give the actual ID's, but we need to give the description.
--So, we do joins on multiple tables as below.

--We will join Employees, Departments and Jobs table

SELECT e.FIRST_NAME ||' '|| e.LAST_NAME AS EMPLOYEE_NAME,
e.EMAIL AS EMPLOYEE_EMAIL,
m.FIRST_NAME ||' '|| m.LAST_NAME AS MANAGER_NAME,
m.EMAIL AS MANAGER_EMAIL,
d.DEPARTMENT_NAME,
j.JOB_TITLE,
l.CITY,
c.COUNTRY_NAME,
r.REGION_NAME
FROM EMPLOYEES e, EMPLOYEES m, DEPARTMENTS d, 
JOBS j, LOCATIONS l, REGIONS r, COUNTRIES c
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
AND e.JOB_ID = j.JOB_ID(+)
AND e.MANAGER_ID = m.EMPLOYEE_ID(+)
AND d.LOCATION_ID = l.LOCATION_ID(+)
AND l.COUNTRY_ID = c.COUNTRY_ID(+)
AND c.REGION_ID = r.REGION_ID(+);

--Here, we join all the tables using traditional mysql method with where and and 
--conditions. We use left outer join on each condition to get all the employee
--records, one with null values also.

    ----------------------ANSI MULTIPLE TABLE JOIN--------------------------    

SELECT e.FIRST_NAME ||' '|| e.LAST_NAME AS EMPLOYEE_NAME,
e.EMAIL AS EMPLOYEE_EMAIL,
m.FIRST_NAME ||' '|| m.LAST_NAME AS MANAGER_NAME,
m.EMAIL AS MANAGER_EMAIL,
d.DEPARTMENT_NAME,
j.JOB_TITLE,
l.CITY,
c.COUNTRY_NAME,
r.REGION_NAME
FROM EMPLOYEES e LEFT JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
LEFT JOIN JOBS j 
ON e.JOB_ID = j.JOB_ID
LEFT JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID
LEFT JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID
LEFT JOIN COUNTRIES c
ON l.COUNTRY_ID = c.COUNTRY_ID
LEFT JOIN REGIONS r
ON c.REGION_ID = r.REGION_ID;

--We just use the left join on two tables at a time with the on condtions and go
--joining all the tables. This is how we can join multiple tables using ansi sql
    
-----------------------------------********-------------------------------------
