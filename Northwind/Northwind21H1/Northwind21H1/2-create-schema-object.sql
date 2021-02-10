/* 
Purpose: create schema object in the database Northwind
Script Date: February 5th, 2021
Developed by Fabiola Faria
*/

/*
Add a statement that specifies the script runs in the context of the master databse
*/

-- swictch to the master database
-- use database_name
use Northwind21H1
;
go

/*
Partial Syntax:
create schema schema_name authorization owner_name
*/

/* create schema objects and set the owner to each of them
1. Sales
2. Production
3. Human Resources
4. Person
*/

-- 1) Create Person Schema
create schema Person authorization dbo
;
go

-- 2) Create Production Schema
create schema Production authorization dbo
;
go

-- 3) Create Human Resource Schema
create schema HumanResources authorization dbo
;
go

-- 4) Create Sales Schema
create schema Sales authorization dbo
;
go
