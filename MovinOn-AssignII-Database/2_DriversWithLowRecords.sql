/* Purpose: List the drivers with low driving records, and sort the list .*/

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- it need info from Driving Record, Driving ID, Driving First and Last Name, Driver Start Date, Driver End Date
-- sort by Driving Record

 select  
	D.DriverID as `Driver ID`,
	concat(D.DriverFirst, ' ', D.DriverLast) as `Driver Name`,
	D.DrivingRecord as `Driver Recording`,
    D.StartDate as `Job Started Date`,
    D.EndDate as `Job end Date`
 from Drivers as D
 where D.DrivingRecord = "C" or D.DrivingRecord = "D" or D.DrivingRecord = "F"
 order by D.DrivingRecord asc
 ;