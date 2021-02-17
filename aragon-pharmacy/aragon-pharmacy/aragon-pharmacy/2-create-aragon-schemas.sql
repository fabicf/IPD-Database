/* 
Purpose: create schema object in the database AragonPharmacy to track customers, prescriptions, 
drugs, employees, training classes, health insurance companies, doctors, and clinics
Script Date: February 10th, 2021
Developed by Fabiola Faria
*/

/*
Add a statement that specifies the script runs in the context of the master databse
*/

-- swictch to the master database
-- use database_name
use AragonPharmacy
;
go

/*
Partial Syntax:
create schema schema_name authorization owner_name
*/

/* create schema objects and set the owner to each of them
1. Customers (tables Customer, HouseHold, HealthPlan)
2. Prescriptions (tables Rx, Drug, Reffil)
3. Employees (tables Employee, JobTitle)
4. Doctors (tables Clinic, Doctor)
5. Classes (tables EmployeeTraining, Class
*/

-- 1) Create Customers Schema
create schema Customers authorization dbo
;
go

-- 2) Create Customers Schema
create schema Prescriptions authorization dbo
;
go

-- 3) Create Employees Schema
create schema Employees authorization dbo
;
go

-- 4) Create Doctors Schema
create schema Doctors authorization dbo
;
go

-- 5) Create Classes Schema
create schema Classes authorization dbo
;
go