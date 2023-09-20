<h1> EMPLOYEE-DATA-PORTFOLIO </h1>
<hr>

![employee-data-Picture](https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/3579d4c1-a00d-47b0-aa0f-f4a41ded7b52)
<hr>


# PHASE 1: Data Cleaning 
<hr>



## The following are all the processes to clean the dataset using Sql queries.

First, saved the original copy of data as 'data_cleaning1.csv'

```sql
select * from Project_Practice.data_cleaning1;      1,0
```
OUT:
<img width="1098" alt="0data cleaning1" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/4130e1df-97b4-4324-af33-8968b39d363e">



* *Duplicates checking:*

We have to make sure that our dataset does not contain some repeatings data in its columns.

```sql
SELECt  Emp_ID,Name,count(Name) from Project_Practice.data_cleaning1      2,1
group by  Emp_ID,Name
having count(Name)>1 ; 
```
OUT:



they are 35 duplicates. they should be removed and save table.

```sql
WITH No_Duplicates AS      
(select  distinct(Emp_ID)AS Dist_Emp_ID,TRIM(Name) AS Name,           3,2
Gender, Department,  Start_Date, FTE, 
Employee_type,Salary,Work_location 
from Project_Practice.data_cleaning1
order by  Dist_Emp_ID 
)
Select * from Project_Practice.No_Duplicates ; -- save this table as 'no_duplicates' table;
```
OUT:

<img width="800" alt="2duplicates removed" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/c92060ad-603d-4f2c-b86d-1658198501de">

<hr>

* * split Name column into separately 2 columns.*

WE can see that the column name has both first and second names joined together, so, it's better to separate them in different columns 'F_Name' and 'S_Name'.

```sql
SELECT   substring_index(Name,' ',1) AS First_Name,
		 substring_index(Name,' ',-1) AS Last_Name              4,3
FROM  Project_Practice.no_duplicates; 
```
OUT:

<img width="207" alt="3Renaming Name" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/410868b0-7ccb-4002-8ad7-aa59b925c103">


<hr>




<hr>

<p> </p>

```sql

```
OUT:

<hr>







<img width="1024" alt="5Ren City$Country" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/8f356b83-0272-4645-83ce-c1a8bdbf3698">

<img width="912" alt="6Null Replace" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/8b177d1e-c128-40db-9fb8-08ae4d8204a1">

<img width="911" alt="7no $ in salary" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/61a5810e-ee20-4755-93b4-cb0910186577">

<img width="911" alt="8 no space in salary" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/6866d6ee-ced6-453a-8cb4-9041ac08a862">





  






