<h1 style🥶 color ="green" > EMPLOYEE-DATA-PORTFOLIO </h1>
<hr color:'red'>

![employee-data-Picture](https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/3579d4c1-a00d-47b0-aa0f-f4a41ded7b52)
<hr>


# PHASE 1: Data Cleaning 
<hr color:'red'>



## The following are all the processes to clean the dataset using Sql queries.

<p><span style="font-size:12px;"font-color:green";">First, saved the original copy of data as 'data_cleaning1.csv' </span></p>

```sql
select * from Project_Practice.data_cleaning1;
```
OUT:
<img width="1098" alt="0data cleaning1" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/4130e1df-97b4-4324-af33-8968b39d363e">



*Duplicates checking:*

<p><span style="font-size:12px;"font-color:green";">We have to make sure that our dataset does not contain some repeatings data in its columns.</p>

```sql
SELECt  Emp_ID,Name,count(Name) from Project_Practice.data_cleaning1
group by  Emp_ID,Name
having count(Name)>1 ; 
```
OUT:

<img width="800" alt="2duplicates removed" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/c92060ad-603d-4f2c-b86d-1658198501de">

<p><span style="font-size:12px;"font-color:green";">they are 35 duplicates. they should be removed and save table.</span></p>

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

<img width="207" alt="3Renaming Name" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/410868b0-7ccb-4002-8ad7-aa59b925c103">

<hr>

<p> </p>

```sql

```
OUT:

<hr>




<hr>

<p> </p>

```sql

```
OUT:

<hr>









<img width="207" alt="3Renaming Name" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/410868b0-7ccb-4002-8ad7-aa59b925c103">

<img width="1024" alt="5Ren City$Country" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/d0b08e79-3b3e-4f05-a83e-35bc52bddd73">

<img width="912" alt="6Null Replace" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/e4809bfe-2f49-447d-8180-050d9a518482">

<img width="911" alt="7no $ in salary" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/5634deb9-2950-412a-b304-acc5dd33f440">

<img width="911" alt="8 no space in salary" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/67e8ee91-ed32-4408-88aa-a03248245e6b">








  






