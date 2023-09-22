
 -- With tidy Data Analysis
 
select * from Project_Practice.final_cleaned;
 
 
select F_Name,L_Name,Salary,count(*) from Project_Practice.final_cleaned
group by F_Name,L_Name,Salary
having Count(F_Name) >1 ;   /* Before we do our analysis, there are 6 entries seems to be duplicated but not, because they have different Emp_ID and dates of different years.
                               May be these employees may have been recruited tuice in a company and got to have a new ID.
                               But as I mentioned that this data set is one I collect somewhere on google,I decided to better involve both records.
                               But as an analyst, sometime let's suppose you have a such data, and you encounter a such situation, 
                               it's always better to know what is the purpose of the data and what is the main objective do company want to achieve from the data.
                               in that case, you may know whether to keep or delete those duplicates of employees.*/


-- ANALYSIS 


-- Q1.  what are Gender breaktdown of employee ?
select Gender, count(*) as count
from Project_Practice.final_cleaned
group by Gender;


-- Q2.what are Employee_type's breakdown ?
select Employee_type, count(*) as count
from Project_Practice.final_cleaned
group by Employee_type;

select Employee_type,gender, count(*) as count
from Project_Practice.final_cleaned
group by Employee_type,gender;


-- Q3. How many Male and female that work permanently in the company ?
select Gender,count(*) as count
from Project_Practice.final_cleaned
where Employee_type = 'Permanent'
group by Gender;


-- Q4.  where do many employees come from ?  
SELECT Country, count(*) FROM Project_Practice.final_cleaned
group by Country ;  # India holds many employees.        ---- 4 ???  not saved ---


-- Q5.  What is the Salary distribution in the company ? 
select max(Salary) as high_salary, min(Salary) as low_salary
from Project_Practice.final_cleaned
where Salary !='0' ;

				              /* Salary in categories */   
SELECT  floor(Salary/10)*10 as salary_group,count(*)FROM Project_Practice.final_cleaned
where salary !=0
group by floor(Salary/10)*10
order by floor(Salary/10)*10 ;
					            

select 
    CASE 
        when salary >=10000 and salary <20000 then '10000-20000'
		    when salary >=20000 and salary <30000 then '20000-30000'
        when salary >=30000 and salary <40000 then '30000-40000'
        when salary >=40000 and salary <50000 then '40000-50000'          -- Salary Group
		    when salary >=50000 and salary <60000 then '50000-60000'
        when salary >=60000 and salary <70000 then '60000-70000'
		    when salary >=70000 and salary <80000 then '70000-80000'
		    when salary >=80000 and salary <90000 then '80000-90000'
		    when salary >=90000 and salary <100000 then '90000-100000'
		    when salary >=100000 and salary <110000 then '100000-110000'
	      when salary >=110000 and salary <120000 then '110000-120000'
	END Salary_group ,
       count(*) as count
from Project_Practice.final_cleaned
where salary !=0
group by Salary_group
ORDER BY CAST(SUBSTRING_INDEX(Salary_group, '-', 1) AS SIGNED) ASC;     



select 
    CASE 
        when salary >=10000 and salary <=19000 then '10000-19000'
		    when salary >=20000 and salary <=29000 then '20000-29000'
        when salary >=30000 and salary <=39000 then '30000-39000'
        when salary >=40000 and salary <=49000 then '40000-49000'
		    when salary >=50000 and salary <=59000 then '50000-59000'           -- Salary Group based on Gender
        when salary >=60000 and salary <=69000 then '60000-69000'
		    when salary >=70000 and salary <=79000 then '70000-79000'
		    when salary >=80000 and salary <=89000 then '80000-89000'
		    when salary >=90000 and salary <=99000 then '90000-99000'
		    when salary >=100000 and salary <=109000 then '100000-109000'
	      when salary >=110000 and salary < 119000 then '110000-119000'
                 else '120000-129000' 
	 END Salary_group , 
       gender,count(*) as count
from Project_Practice.final_cleaned
where salary !=0
group by Salary_group, gender
ORDER BY CAST(SUBSTRING_INDEX(Salary_group, '-', 1) AS SIGNED) ASC;



-- Q6. HOW DOES THE GENDER DISTRIBUTION VARY ACROSS DEPARTMENTS ?
select gender,department, count(*) as count from Project_Practice.final_cleaned
group by gender,department
order by count(*);                     -- most of male are in Accounting, and most of female are in Training...


