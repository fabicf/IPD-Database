/* Purpose: To create a database that manages employees, drivers, customers, and orders data. 
*/

/* Script Date: January 31, 2021
Developed by: Fabiola Faria
*/

create database movinOn
;

-- switch to the Flix database
-- Syntax: use database_name;
use movinOn
;

-- rename database movinOn to movinOn_FF;

-- One way to rename MySQL database is to follow the following steps:
-- 1. To rename Database or Schema in MySQL server, first of all you need to create a new database/ Schema that you can do by using below command

-- Create database/schema database_name;

-- 2. Once you have the database ready, now you can move the tables from old database to new database by using blow statement.

-- rename table old_database_name.table_name to new_database_name.table_name;

-- 3. Repeat above for all the tables in database, Then you can remove the old database by using below statement

-- drop database/Schema database_name;