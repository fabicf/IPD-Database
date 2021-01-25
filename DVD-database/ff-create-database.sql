/* Purpose: To create a database that tracks the inventory of DVDs,
provides information about the DvDs, records rental transactions, 
and stores the names of the store's customers and employees 
*/

/* Script Date: January 21, 2021
Developed by: Fabiola Faria
*/

/* Partial syntax:
create object_type object_name
where object type: database, table, view, index, etc.
*/

create database FCFlix
;

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/* using the schema command to create a new database.
Create schema in SQL Server has different meaning
*/
create schema myDB1;

/* check if the database exists. If o, 
delete it (Onlu on he development environment, and
not on the production server) 
*/

create database if not exists myDB1
; 



