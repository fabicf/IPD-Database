/*/* Purpose: Insert data into tables of officemachine database  
 	Script Date: January 27, 2021
    Developed By: Fabiola Faria
*/

use OfficeMachine
;

show variables like "secure_file_priv";
show variables like "local_infile";
set global local_infile = 1;


SHOW VARIABLES LIKE 'secure_file_priv';

SELECT @@GLOBAL.secure_file_priv;


/* load data from external csv file */
-- load data infile 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\Participant_Roles.csv'
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ff-office-machine-data-departments.csv'
into table Departments
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;

select *
from Departments
; 
