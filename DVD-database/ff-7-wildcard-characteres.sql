/* using wildcard characters in the flix database */

/* Script Date: February 1st, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/* SQL Like Operator

There are two wildcards often used in conjunction with the like operator:
% - the percent sign represents zero, one or multiple characters
_ - the underscore represents a single caracter
*/

/*
Like Operator 		Description
WHERE DVDName Like 'a%'		Finds any values that start with "a"
WHERE DVDName Like '%a'		Finds any values that end with "a"
WHERE DVDName Like '%up%'		Finds any values that have "up" in any position
WHERE DVDName Like '_h%'		Finds any values that have "h" in second position
WHERE DVDName Like 'a_%'		Finds any values that have start with  "a" and are at lease 2 characters in length
WHERE DVDName Like 'a__%'		Finds any values that have start with  "a" and are at lease 3 characters in length
WHERE DVDName Like 'a%s'		Finds any values that have start with  "a" and end with s


*/

select *
from DVDs
where DVDName like 'a__%'
;



