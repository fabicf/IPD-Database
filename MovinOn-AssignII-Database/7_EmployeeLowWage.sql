/* Purpose: Define Who is paid the lowest hourly rate. */

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- it needs Employee ID, Name and Hourly Rate --> sort by asc or min

select  
	E.EmpID as `Employee ID`, 
	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
	E.HourlyRate as `Hourly Rate`
 from Employees as E
where E.HourlyRate = (select min(HourlyRate) from Employees)
 ;



--  select  
-- 	E.EmpID as `Employee ID`, 
-- 	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
-- 	E.HourlyRate as `Hourly Rate`
--  from Employees as E
--  where E.HourlyRate <> 0  -- or where salary > 1 --> to eliminate the null/0 values
--  order by E.HourlyRate asc
--  ;
--  
 
 