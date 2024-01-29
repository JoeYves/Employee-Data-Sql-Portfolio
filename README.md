# Employee-Data-Sql-Portfolio
<hr>
This repository was created to do data exploration on the dataset 'Employee Data'. The source of this dataset is unclear, and it was downloaded at random from the internet. 
The layout consists of 276 rows and 9 columns.

*9 Columns* :
- Emp_ID as Text                           
- Name as Text
- Gender as Text 
- Department as Text
- Salary as Text
- Start_Date Text 
- FTE as Double
- Employee_type as Text
- Work_location* as Text

*276 Rows* : Emlpoyye dataset has also 276 as rows and each field tells a crucial reflection on how this dataset behaves.
<hr>

These columns behave differently, where there are some of the emptiness/missing values, some inconsistencies especially in start_Date columns, dates are not in one common format. some of the duplicates also are found, In Name column also, this column holds both first and last names which need to be separated. all of these should be ckecked before diving into data analysis phase.

## Cleaning Tasks :

1. Check the inconsistent data 
2. Check the duplicates, and delete them as they are unwanted from dataset
3. Replace blank fields with 'unknown'
4. Removing some spaces and renaming table columns after some updates and other modifications
5. Separating columns and do some concatenations 
6. Changing columns datatype for a better data integrity.
<hr>

I have been using SQL queries to do some EDA and cleaning to try to understand the concept of this unkowncompany's Employees, especially to see how employyes earn their incomes based on how salaries range varry, based on their Gender or their Departments.
<hr>

After Some EDA, I tried to do some short analysis on a tidy data so that I can get some insights to draw a meaningful conlusion.
Here are some Questions I imposed to do my analysis :

1. what are Gender breaktdown of employee ?
2. what are Employee_type's breakdown ?
3. How many Male and female that work permanently in the company ?
4. where do many employees come from ?  
5. What is the Salary distribution in the company ? 
<hr>

Down here are some findings that were reflected to draw a better conclusion.

## Insights :

* A company has almost an equal number of male and female.
* There is a higher number of employees that work permanently, and most of them are female.
* In acordance with the number of employees from different countries, it seems that many Employees hired are form India.
* Employee who get higher salary get 119022.49$ and 28160.79 vice-versa.
* 12 salary groups were created ( 90000-99000,80000-89000,70000-79000,60000-69000,50000-59000,
                                  40000-49000,30000-39000,20000-29000,120000-129000,110000-119000,100000-109000 ).
and the higher salary given are between 60000-70000,and 20000-30000 vice-versa.
* Most of male employees are in accounting and female in training.

