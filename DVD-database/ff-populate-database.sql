/* populate tables with data in the flix database */

/* Script Date: January 26, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/* 
1. insert a new record using insert clause
Partial syntax:
insert [into] table_name 
values ('val1', 'val2', ...)
;

insert [into] table_name [(column_name_1, column_name2, ...)]
values (val1, 'val2', ...)
;
*/
customers
employees

/*
2. using insert clause from another table
syntax:
insert [into] table_name [(column_name1, column_name2, ...)
select [(column_name_1, column_name2, ...)
from another_table_name
*/

suppliers.csv

/*
3. using load data from external file
load data infile 'D:/data_source/suppliers.csv'
into table supplers
fields terminated by ','
lines terminate by '\r\n'
ignore 1 rows
*/






