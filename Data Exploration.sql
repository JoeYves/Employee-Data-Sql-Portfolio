
select * from Project_Practice;

-- Our dataset information
desc Project_Practice.data_cleaning1;  

 /*  Duplicates checking */
SELECT  Emp_ID,Name,count(Name) from Project_Practice.data_cleaning1
group by  Emp_ID,Name
having count(Name)>1 ;    

WITH No_Duplicates AS      
(select  distinct(Emp_ID)AS Dist_Emp_ID,TRIM(Name) AS Name,                    
Gender, Department,  Start_Date, FTE, 
Employee_type,Salary,Work_location 
from Project_Practice.data_cleaning1
order by  Dist_Emp_ID 
)

Select * from Project_Practice.No_Duplicates ; -- save this as 'no_duplicates' table.

/*---------------------------------------------------------*/

-- split Name column into separately 2 columns 
SELECT   substring_index(Name,' ',1) AS First_Name,
		 substring_index(Name,' ',-1) AS Last_Name
FROM  Project_Practice.no_duplicates;     

select  Dist_Emp_ID, substring_index(Name,' ',1) AS First_Name, 
                     substring_index(Name,' ',-1) AS Last_Name,  
                     Gender, Department, Salary, Start_Date, FTE,
                     Employee_type,
					 trim(substring_index(Work_location,',',1)) AS  City_Location, 
                     trim(substring_index(Work_location,',',-1)) AS Country_Location
from Project_Practice.No_Duplicates
order by  Dist_Emp_ID;/* a new table with the first and the last names separately,
                         and also we have 2 separate columns 'City'and 'Country' from work_location column.
                         save to 'No_Duplicates TABLE'
					  */ 
                      
/*---------------------------------------------------------*/

-- NULL replacement 
select * from  Project_Practice.No_Duplicates ;
                
SELECT Dist_Emp_ID, First_Name, Last_Name,  
      CASE 
	      WHEN Gender='' THEN 'Unknown' 
	      ELSE Gender
	      END AS Gender_NoBlank, 
		coalesce( Department,'Unknown') AS Department_noNULL, 
	  CASE 
		  WHEN Salary='' THEN '$0' 
		  ELSE Salary
          END AS Salary_NoBlank, 
        Start_Date, FTE, Employee_type, City_Location, Country_Location
from  Project_Practice.No_Duplicates ;     
                                                               -- SAVE CHANGES TO 'No_Duplicates'Table */
															
/*---------------------------------------------------------*/

-- DATATYPES Convertion/ Standardization 	

update Project_Practice.no_duplicates
set Salary_NoBlank=replace(Salary_NoBlank,'$',' ')  
where Salary_NoBlank like '%$%' ; 
                                                                                       
update  Project_Practice.no_duplicates 
set Salary_NoBlank =trim(replace(Salary_NoBlank,',',''));  

/*---------------------------------------------------------*/

 -- change 'Salary_NoBlank' type from text to decimal(10,2)
alter table Project_Practice.no_duplicates modify column Salary_NoBlank decimal(10,2);   
select * from  Project_Practice.no_duplicates;                                         -- save changes as 'no_duplicates' Table.       
                                       
/*---------------------------------------------------------*/

-- Replacing 'FTE' column to 'FTE_New' with varchar datatype.
alter table Project_Practice.no_duplicates add column FTE_New integer; 
alter table Project_Practice.no_duplicates MODIFY column FTE VARCHAR(10);

alter table Project_Practice.no_duplicates MODIFY column FTE_New VARCHAR(10);
update  Project_Practice.no_duplicates
    set FTE_New = 
            CASE when FTE <1 then 'Half time'
                 when FTE =1 then 'Full time'
				 else FTE
             END;                     
										
alter table Project_Practice.no_duplicates drop column FTE;  
alter table Project_Practice.no_duplicates change column FTE_New FTE Varchar(10); 
   
select Dist_Emp_ID, First_Name, Last_Name, Gender_NoBlank, 
       Department_noNULL, Salary_NoBlank, Start_Date, FTE, 
       Employee_type, City_Location, Country_Location
from   Project_Practice.no_duplicates;

/*---------------------------------------------------------*/
-- Date column consistancy
select Start_Date from Project_Practice.no_duplicates;
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

select Dist_Emp_ID, First_Name, Last_Name, Gender_NoBlank,
	   Department_noNULL, Salary_NoBlank, Str_Date, Employee_type, 
       City_Location, Country_Location, FTE
from  Project_Practice.no_duplicates;   -- save changes as 'no_duplicates' Table again.		
						
/*---------------------------------------------------------*/  

-- Validation again   
select count(Dist_Emp_ID),Dist_Emp_ID
from Project_Practice.no_duplicates
group by Dist_Emp_ID
having count(Dist_Emp_ID) > 1 ;  -- 4 duplicates are found 

select* from Project_Practice.no_duplicates;

select DISTINCT(Dist_Emp_ID) ,
        First_Name, Last_Name, Gender_NoBlank, 
        Department_noNULL,Salary_NoBlank,Str_Date,FTE, Employee_type, 
	    City_Location, Country_Location 
from Project_Practice.no_duplicates;                                               -- save changes

use  Project_Practice;

create table temporaryTable_delete_duplicates 
select distinct * from Project_Practice.no_duplicates;
drop table Project_Practice.no_duplicates;
alter table temporaryTable_delete_duplicates rename no_duplicates;  
             
/*---------------------------------------------------------*/  

-- Renaming columns
alter table Project_Practice.no_duplicates
change Dist_Emp_ID Emp_ID  Varchar(60) primary key,
change First_Name F_Name  Varchar(60),
change Last_Name L_Name  Varchar(60),
change Gender_NoBlank Gender Varchar(60),
change Department_noNULL Department Varchar(60),
change FTE FTE Varchar(60),
change Employee_type Employee_type Varchar(60),
change City_Location City Varchar(60),
change Country_Location Country Varchar(60),
change Str_Date Date date,
change Salary_NoBlank Salary double;

select * from Project_Practice.no_duplicates; 

/*---------------------------------------------------------*/  

-- Now we can put back $ sing to salary column. 
alter table Project_Practice.no_duplicates
change Salary `Salary $` double;

select * from Project_Practice.no_duplicates;   -- save  the data as 'Final_Cleaned' for analysis.
