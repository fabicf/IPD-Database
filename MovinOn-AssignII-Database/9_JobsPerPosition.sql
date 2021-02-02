/* Purpose: Define How many people are employed in each type of job. */

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- Employeed by Positions
 select  count(E.EmpID) as `Number of Employees`, E.PositionID as `Position ID`
 from Employees as E
 group by E.PositionID
 ; 


-- trying to show Employees by positionID and by position title
 select  
	count(E.EmpID) as `Number of Employees`, 
    E.PositionID as `Position ID`, 
    P.Title as `Position Title`
 from Employees as E
 inner join Positions as P
on E.PositionID = P.PositionID
group by E.PositionID
; 