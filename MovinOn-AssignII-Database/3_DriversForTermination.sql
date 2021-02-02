/* Purpose: Create a additional list, and include all relevant employment information for Drivers. .*/

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- all employment information?? = All the info for Drivers D and F?



 select  *
 from Drivers as D
 where D.DrivingRecord = "D" or D.DrivingRecord = "F"
 ;