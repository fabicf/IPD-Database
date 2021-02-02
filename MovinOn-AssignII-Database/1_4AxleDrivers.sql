/* Purpose: to identify the drivers qualified (A or B) to drive the four-axle trucks */

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- Info found in table Drivers_DrivingRecord and table Vehicles_Axle --> NO
-- Just need the Driver's Name, Driver's Last Name, Driver's Phone and Driver's Driving Record
-- concat driver first and last name

 
 select  
	D.DriverID as `Driver ID`,
	concat(D.DriverFirst, ' ', D.DriverLast) as `Driver Name`,
	D.Phone as `Driver Phone`, 
    D.DrivingRecord as `Driver Recording`
 from Drivers as D
 where D.DrivingRecord = "A" or D.DrivingRecord = "B"
 ;