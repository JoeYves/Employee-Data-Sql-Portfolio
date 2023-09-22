# Employee-Data-Sql-Portfolio
<hr>

this repository is created to do data exploration on a dataset 'Employee Data'. As this is my first data exploration project, Here my emphasis is on actually cleaning dataset. This dataset is downloaded from the internet randomly and I got it from unknown resource. It contains:

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

## Cleaning Tasks:

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

Q1. 
