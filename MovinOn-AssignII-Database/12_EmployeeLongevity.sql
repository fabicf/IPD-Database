/* Purpose: Define ???. */

-- MovinOn knows that having a workforce of long-term employees improves customer service 
-- and avoids the high expense of training new employees. Darnell wants to know if one warehouse 
-- is more effective at retaining employees than another. Create an employee list that calculates 
-- the number of years each employee has worked for MovinOn. Organize the list by job title 
-- within each warehouse. Save the script as 12_EmployeeLongevity.

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- 1st: create a list with Employee Name, ID, Number of years working, Position title

    
 select  
	E.EmpID as `Employee ID`, 
	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
    W.WarehouseID as `Warehouse`,
    P.Title as `Position`,
	year(sysdate()) - year(E.StartDate) as `Years worked`
from Employees as E
	inner join Positions as P
		on E.PositionID = P.PositionID
	inner join Warehouses as W
		on E.WarehouseID = W.WarehouseID
order by W.WarehouseID, P.Title;
 
 
 
 
/*convert functions
cast(expression as data_type)
convert(expression, data_type)
*/

