/*Rename database objects
Script Date: February 11, 2021
Developed by: Fabiola Faria
*/

use master -- be in master to ccreate a new databse
;
go 

-- create a new database
create database tessst
on primary
(
	-- 1) rows data logical filename
	name = 'tessst',
	-- 2) rows data initial file size
	size = 12MB,
	-- 3) rows data auto growth size
	filegrowth = 10MB,
	-- 4) rows data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5) rows data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\tessst.mdf'
)
log on
(
	-- 1 ) log logical filename
	name = 'tessst_log',
	-- 2) log initial file size (1/4 of data file size)
	size = 3MB,
	-- 3) log auto growth size
	filegrowth = 10%,
	-- 4) log data maximum file size
	maxsize = 500MB, -- unlimited
	-- 5) log data path and file name
	filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\tessst_log.ldf'
)
;
go

-- =============================================================
create table Contactssss
(
	ContacIDdddd int, -- rename this column
	ContactName nvarchar(25)
)
;
go

-- 1. rename the database name
-- execute sp_renamedb 'old_database_name', 'new_database_name'
execute sp_renamedb 'tessst', 'Test'
;
go


-- switch to Test database
use test -- be in master to ccreate a new databse
;
go

-- 2. rename a table
/* execute sp_rename 'schema_name.old_table_name', 'new_table_name' */
execute sp_rename 'dbo.Contactssss', 'Contacts'
;
go

-- 3. rename a column
/* execute sp_rename 'schema_name.table_name.old_column.name', 'new_column_name', 'Column' */
execute sp_rename 'dbo.Contacts.ContacIDdddd', 'ContactID', 'Column'
;
go