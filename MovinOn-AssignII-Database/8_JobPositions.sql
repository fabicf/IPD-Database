/* Purpose: Define How many types of jobs are offered at MonivOn. */

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;


  Select 
	count(E.PositionID) as `Number of Types of job`
 From Employees as E
 ;
 
 -- different positions from Employees table
 Select 
	distinct E.PositionID as `Number of Types of job`
 From Employees as E
 ;
 

 
 
--  -- different positions from Positions table by positionID
--  select  distinct P.PositionID as `Positions`
--  from Positions as P
--  ;