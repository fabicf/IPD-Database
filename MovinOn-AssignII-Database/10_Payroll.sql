/* Purpose: Create a list with employee info (salary, hourly wage, ssn, name, employee id) for HR */

-- To prepare for a payroll, Darnell must provide a list of list of employees that includes their 
-- salary or hourly pay rate. The list must also include Social Security Numbers and employee IDs 
-- so that an outside firm can properly process the payroll. Produce an employee list that provides 
-- this information, and sort it so that it’s easy to find an employee by name. for those employees 
-- who are on a salary, the list should show their monthly wage. Save this script as 10_Payroll.

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */


-- EmployeeID, Employee Name, Employee Salary --> Monthly Rage, Employee HourlY Rate, SSN, 
-- order by name

use movinOn
;

 select  
	E.EmpID as `Employee ID`,
	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
	E.SSN as `Employee SSN`,
	cast(E.Salary/12 as decimal(8,2)) as `Salary per Month`, -- use cast to prevent more than 2 decimals because of the division
    E.HourlyRate as `Hourly Rate`
 from Employees as E
 order by `Employee Name` asc
 ;