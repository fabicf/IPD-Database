/* Purpose: Define what states or provinces do the employees reside .*/

/*Scripts Date: February 2nd, 2021
Developed by: Fabiola Faria */

use movinOn
;

-- it Employee States in general - not repeated


 select  distinct E.State as `Employees states`
 from Employees as E
 ;
 