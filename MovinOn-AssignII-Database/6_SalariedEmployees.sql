/* Purpose: Define Who makes the highest salary.*/

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- it needs Employee ID, Name and Salary --> sort by desc or max

 select  
	E.EmpID as `Employee ID`, 
	concat_ws(' ', E.EmpFirst, E.EmpLast) as `Employee Name`,
	E.Salary as `Salary`
 from Employees as E
 where E.Salary = (select max(Salary) from Employees)
 ;



--  select  
-- 	E.EmpID as `Employee ID`, 
-- 	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
-- 	E.Salary as `Salary`
--  from Employees as E
--  where salary <> 0  -- or where salary > 1 --> to eliminate the null/0 values
--  order by E.Salary desc
--  ;

--  select  
-- 	E.EmpID as `Employee ID`, 
-- 	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
-- 	E.Salary as `Salary`
--  from Employees as E
--  order by E.Salary desc
-- limit 1
--  ;