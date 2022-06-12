In this project we show the efficient use of analysing data using joins and various other operations accessible through SQL.

Perform the below analysis:

1. Inner Join: This query will join the employee and department table and fetch all the details for the Marketing department employees as mentioned in the query. If 
there are two columns with same name in both the tables, then the database wil create an another column.

2. ANSI SQL Inner Join: This has bit different structure than mysql, but basic output is same.

3. Resolving column ambiguity defined error: Mostly seen when we don't use proper alias for two different tables joined using where or join keywords. We get this error
because our database is not able to identify which column to get from which table. This error occurs when there is same column in different tables. 
To solve this error we use alias with the table name.

4. Left Outer Join: We list down all the departments along with employees working under it using (+) sign.

5. ANSI SQL Left Join: This has bit different structure than mysql, but basic output is same. Using Left Join keyword.

6. Right Outer Joing: We list down all the employees along with department details using (+) sign.

7. ANSI SQL Right Join: This has bit different structure than mysql, but basic output is same. Using Right Join keyword.

8. ANSI SQL Full Outer Joing: We display all the employee and department records along with missing data. Tradition sql join with (+) will not work in this case.

9. Self Join: We display employee details along with manager details.

10. ANSI SQL Self Join: Using Join keyword. This has bit different structure than mysql, but basic output is same.

11. UNION and UNION ALL: We combine locations and non functional locations table. Union will not give duplicate records, but union all will give all the duplicate
records also. 

12. MINUS and INTERSECT: We find unique and common locations. Minus keyword gives us the unique values for the specified tables, and Intersect give use the common ones.

13. Join multiple tables to fetch employee details. We join multiple tables using traditional sql method of where and and conditions.

14. We join multiple tables using the join and on keywords, i.e. the ANSI SQL keywords.

Dataset Information:

This dataset contains various tables, but the below mentioned tables are the important ones, which holds most of the data.
1. Countries,
2. Departments,
3. Employees,
4. Job History,
5. Jobs,
6. Locations, 
7. Regions, &	
8. Non_Functional_Locations

This data was build using the file DDL.sql which is uploaded in the code section.

System.sql is the main file which holds the queries and the analysis performed on the data.
