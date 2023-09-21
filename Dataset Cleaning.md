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
Select * from Project_Practice.No_Duplicates ;          -- save this table as 'no_duplicates' table
```
OUT:

<img width="800" alt="2duplicates removed" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/c92060ad-603d-4f2c-b86d-1658198501de">

<hr>

* *split Name column into separately 2 columns.*

WE can see that the column name has both first and second names joined together, so, it's better to separate them in different columns 'F_Name' and 'S_Name'.

```sql
SELECT   substring_index(Name,' ',1) AS First_Name,
		 substring_index(Name,' ',-1) AS Last_Name              4,3
FROM  Project_Practice.no_duplicates; 
```
OUT:

<img width="207" alt="3Renaming Name" src="https://github.com/JoeYves/Employee-Data-Sql-Portfolio/assets/128157898/410868b0-7ccb-4002-8ad7-aa59b925c103">
 Now we have 2 separate column names,then let join them to form a new table, and save changes.

```sql
select  Dist_Emp_ID, substring_index(Name,' ',1) AS First_Name, 
                     substring_index(Name,' ',-1) AS Last_Name,  
                     Gender, Department, Salary, Start_Date, FTE,
                     Employee_type,
                     /* .*/                                         
					 trim(substring_index(Work_location,',',1)) AS  City_Location, 
                     trim(substring_index(Work_location,',',-1)) AS Country_Location
from Project_Practice.No_Duplicates
order by  Dist_Emp_ID;                                                 5,4
```
OUT:



<hr>

* *NULL replacement with 'UNKNOWN 'and BLANK with '0'.*

We can see that in our Gender column, there exist some empty fields and we need to replace those filed with 'Unknown' string.
Also in salary column, there exist some emptness, Unless we remove/replace them, these could lead us to wrong insights in EDA phase.

```sql
SELECT Dist_Emp_ID, First_Name, Last_Name,  
      CASE 
	      WHEN Gender='' THEN 'Unknown' 
	      ELSE Gender
	      END AS Gender_NoBlank,  /* Blanks are removed in Gender field */          6,5
		coalesce( Department,'Unknown') AS Department_noNULL, 
	  CASE 
		  WHEN Salary='' THEN '$0' 
		  ELSE Salary
          END AS Salary_NoBlank, /* Blanks are removed in salary field */
        Start_Date, FTE, Employee_type, City_Location, Country_Location
from  Project_Practice.No_Duplicates ;                                              -- save changes again as 'no_duplicates' table
```
OUT:




<hr>

* *DATATYPES Convertion/Standardization.*

* We can see that in our salary column, then values are started with a $ sign, and this could lead us to face the issues when doing some statistical calcurations with. we have to make this column to hold values only, and our EDA calculation might be done without any issue.

```sql
update Project_Practice.no_duplicates
set Salary_NoBlank=replace(Salary_NoBlank,'$',' ')                                  7,6
where Salary_NoBlank like '%$%'                             /* you can even use this "
                                                                                   select replace( Salary_NoBlank,'$','') as New_salary
                                                                                   from Project_Practice.split_names_date1 " 
                                                                                   then delete the original column to remain whith the new one
                                                            /*  
```
OUT:



* *Removing spaces and comma in salary_noblank column.*

This column has to be holding only values and as it is of currencies, we would rename it later with 'Salary $' colomn name again.
we have also to change its data type from text to double as well.

```sql
set sql_safe_updates=0;

update  Project_Practice.no_duplicates 
set Salary_NoBlank =trim(replace(Salary_NoBlank,',',''));        -- save changes again as 'no_duplicates' table.
```
OUT:



<hr>

### *cleaning Continues...*


* *Change 'Salary_NoBlank' type from text to decimal.*

```sql
alter table Project_Practice.no_duplicates modify column Salary_NoBlank decimal(10,2); 
select * from   Project_Practice.no_duplicates;
```
<hr>

* *Replacing 'FTE' column to 'FTE_New' with varchar datatype.*

We have to create a new column so that it has to hold all data from original FTE column as characters.

```sql
alter table Project_Practice.no_duplicates add column FTE_New integer; 
alter table Project_Practice.no_duplicates MODIFY column FTE VARCHAR(10);

alter table Project_Practice.no_duplicates MODIFY column FTE_New VARCHAR(10);
update  Project_Practice.no_duplicates
    set FTE_New = 
                  CASE
                      when FTE <1 then 'Half time'
                      when FTE =1 then 'Full time'
                      else FTE
                  END;

/* this means, if full-Time Equivalent is equal to 1, an employee works full-time.
else if it is less than 1 then it's a half-time employee. */

/*we can then delete the old FTE and then rename FTE_New as FTE.*/
alter table Project_Practice.no_duplicates drop column FTE;

/* To ake sure the added FTE_New  column is a varchar() type.*/
alter table Project_Practice.no_duplicates change column FTE_New FTE Varchar(10); 

/* Now then this is our new table. save changes again.*/
select Dist_Emp_ID, First_Name, Last_Name, Gender_NoBlank, 
       Department_noNULL, Salary_NoBlank, Start_Date, FTE, 
       Employee_type, City_Location, Country_Location
from   Project_Practice.no_duplicates;										
```
<hr>

* *Date column standardization.*

In this column, most of the dates are in different format as inconsistant date, and they must be of the same date format.
```sql
select Start_Date from Project_Practice.no_duplicates;    
```
let's create new column 'Str_Date' with date type, putting all given date formats in one date type, and delete the original 'start_date' column.      
after, we rename 'str_date' to 'Start_Date again for our new table.

```sql
SET SQL_SAFE_UPDATES=0;
                                 
alter table Project_Practice.no_duplicates add column Str_Date date;    

update  Project_Practice.no_duplicates
set str_date =
              CASE
                  WHEN Start_Date REGEXP '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$' THEN STR_TO_DATE(Start_Date, '%d-%b-%y' ) 
                  WHEN Start_Date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN STR_TO_DATE(Start_Date, '%d/%m/%Y')
                  WHEN Start_Date REGEXP '^[A-Za-z]{3} [0-9], [0-9]{4}$' THEN STR_TO_DATE(Start_Date, '%b %d, %Y')
                  WHEN Start_Date REGEXP '^[A-Za-z]{3} [0-9]{2}, [0-9]{4}$' THEN STR_TO_DATE(Start_Date, '%b %d, %Y')  
                  ELSE NULL
              END ;
 
alter table Project_Practice.no_duplicates drop column start_date ; 
```
Now we have a new date column, and we can seve changes again.
```sql
select Dist_Emp_ID, First_Name, Last_Name, Gender_NoBlank,
       Department_noNULL, Salary_NoBlank, Str_Date, Employee_type, 
       City_Location, Country_Location, FTE
from  Project_Practice.no_duplicates;
```







  






