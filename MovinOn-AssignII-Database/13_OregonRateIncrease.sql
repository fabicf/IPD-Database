/* Purpose: Define ???. */

-- Darnell learns that the manager of the Oregon warehouse has decided to give 
-- his hourly employees a 10% raise. He asks you to list all the employees who work 
-- in the Oregon warehouse, and show the old rate along the new rate after a 10% increase 
-- to their hourly pay rate. The increase applies only to hourly employees. 
-- Save the script as 13_OregonRateIncrease.

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- do not forget eliminate the employees that dont work at movinOn anymore


 select  
	E.EmpID as `Employee ID`, 
	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
	E.HourlyRate as `Old Hourly Rate`,
    cast(E.HourlyRate*1.10 as decimal(4,2)) as `New Hourly Rate`
 from Employees as E
 where 
	E.HourlyRate <> 0  and -- to eliminate the null/0 values 
    E.EndDate is null -- to eliminate old employees 
 order by E.EmpID asc
 ;