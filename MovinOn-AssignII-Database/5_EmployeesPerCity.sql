/* Purpose: Define How many employees in each city .*/

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- it needs city and number of employees = count

 select  count(EmpID) as `Number of Employees`, E.City as `City`
 from Employees as E
 group by city
 ; 	-- 9 seattle + 4 spokane + 10 jackson hole + 10 portland = 33
 
 
 
 
 
 /*
 -- to confirm count all employees
 select  count(EmpID) as `total number of employees`
 from Employees as E
 ; -- total of 33 Employees
 
 
  select  E.EmpID, E.City
 from Employees as E
 ; -- total of 33 Employees
 */