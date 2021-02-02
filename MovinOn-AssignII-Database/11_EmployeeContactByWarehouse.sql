/* Purpose: Create a list to access employees via warehouse */

-- Darnell sometimes needs to contact the warehouse managers, accountants, administrative assistants, 
-- and other employees at the warehouse where they work. Create a contact list that he can use to phone 
-- employees, and that contains enough information to identity employees, their positions, and their warehouses 
-- along with the warehouse phone number. Because Darnell might eventually use this list as the basis for a report, 
-- the employee’s name should appear as one full name, with the last name first. When you show this query to Darnell, 
-- he realizes that it would be more helpful if he could specify a particular warehouse before producing the list, 
-- and then see the contact information only for the employees who work in that warehouse. Create a script that meets 
-- these needs, saving it as 11_EmployeeContactByWarehouse.

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */


-- Employees Phone, Name, Employyee ID, Positions, Warehouse, warehouse phone,
-- order by warehouse
-- --> tables: Employee, Position (position title) and warehouse 

use movinOn
;

 select  
	E.EmpID as `Employee ID`, 
	concat(E.EmpFirst, ' ', E.EmpLast) as `Employee Name`,
	E.Phone as `Employee Phone`,
	P.Title as `Position`,
    W.WarehouseID as `Warehouse`,
    W.Phone as `Warehouse Phone`
 from Employees as E
	inner join Positions as P
		on E.PositionID = P.PositionID
	inner join Warehouses as W
		on E.WarehouseID = W.WarehouseID
order by E.WarehouseID asc
 ;

