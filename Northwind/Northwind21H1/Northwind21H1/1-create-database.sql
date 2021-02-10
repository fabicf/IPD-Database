/* 
Purpose: create the database Northwind
Script Date: February 5th, 2021
Developed by Fabiola Faria
*/

/*
Add a statement that specifies the script runs in the context of the master databse
*/

-- swictch to the master database
-- use database_name
use master
;

go -- include end of the batch marker
;

/* Partial syntax to create a database
create object_type object_name
create database database_name
*/

-- create Northwind21H1 database

create database Northwind21H1
on primary
(
	-- 1) rows data logical filename
	name = 'Northwind21H1',
	-- 2) rows data initial file size
	size = 12MB,
	-- 3) rows data auto growth size
	filegrowth = 10MB,
	-- 4) rows data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5) rows data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Northwind21H1.mdf'
)
log on
(
	-- 1 ) log logical filename
	name = 'Northwind21H1_log',
	-- 2) log initial file size (1/4 of data file size)
	size = 3MB,
	-- 3) log auto growth size
	filegrowth = 10%,
	-- 4) log data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5) log data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Northwind21H1_log.ldf'
)
;
go

/* return information about the NorthWind database using system sored procedure.
Syntax:
exec(ute) procedure_name
*/

execute sp_helpdb 'Northwind21H1'
;
go

/* increase the maxsize of the Northwind21h1_log to 100MB */

-- switch to the master database
use master;
go

alter database Northwind21h1
	modify file
	(
		name = 'Northwind21h1_log',
		maxsize = 100mb
	)
;
go

/* return the SQL Server version we are running */
select @@version;
go

/* using some of system function */

-- return the connection, database context and server information

select
	USER_NAME () as 'User Name',
	DB_NAME() as 'Database Name',
	@@SERVERNAME as 'Server Name'
;
go

-- switch to Northwind21h1
use Northwind21H1
;
go

/* delete MyDB1 and MYDB2 database */
drop database MyDB1, MyDB2
;
go