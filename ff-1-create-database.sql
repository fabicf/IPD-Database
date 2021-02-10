/* 
Purpose: create the database MyDB2
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

-- create MyDB2 database

create database MyDB2
on primary
(
	-- 1) rows data logical filename
	name = 'MyDB2',
	-- 2) rows data initial file size
	size = 12MB,
	-- 3) rows data auto growth size
	filegrowth = 10MB,
	-- 4) rows data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5) rows data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MyDB2.mdf'
)
log on
(
	-- 1 ) log logical filename
	name = 'MyDB2_log',
	-- 2) log initial file size (1/4 of data file size)
	size = 3MB,
	-- 3) log auto growth size
	filegrowth = 10%,
	-- 4) log data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5) log data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MyDB2_log.ldf'
)
;
go