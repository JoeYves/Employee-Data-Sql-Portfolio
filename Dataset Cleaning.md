<h1 style🥶 color ="green" > EMPLOYEE-DATA-PORTFOLIO </h1>
<hr color:'red'>

![employee-data-Picture](https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/3579d4c1-a00d-47b0-aa0f-f4a41ded7b52)
<hr>


# PHASE 1: Data Cleaning 
<hr color:'red'>



## The following are all the processes to clean the dataset using Sql queries.

First, saved the original copy of data as 'data_cleaning1.csv'

```sql
select * from Project_Practice.data_cleaning1;
```
OUT:
<img width="1098" alt="0data cleaning1" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/4130e1df-97b4-4324-af33-8968b39d363e">



*Duplicates checking:*

We have to make sure that our dataset does not contain some repeatings data in its columns.

```sql
SELECt  Emp_ID,Name,count(Name) from Project_Practice.data_cleaning1
group by  Emp_ID,Name
having count(Name)>1 ; 
```
OUT:

they are 35 duplicates. they should be removed and save table.

```sql
WITH No_Duplicates AS      
(select  distinct(Emp_ID)AS Dist_Emp_ID,TRIM(Name) AS Name,  
Gender, Department,  Start_Date, FTE, 
Employee_type,Salary,Work_location 
from Project_Practice.data_cleaning1
order by  Dist_Emp_ID 
)
Select * from Project_Practice.No_Duplicates ; -- save this table as 'no_duplicates' table;
```


OUT:


<hr>







  






