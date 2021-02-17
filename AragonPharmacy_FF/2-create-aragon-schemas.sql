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

use AragonPharmacy_FF
;
go

/*
Partial Syntax:
create schema schema_name authorization owner_name
*/

/* create schema objects and set the owner to each of them
1. Sales (tables Customer, HouseHold, HealthPlan)
2. Pharmacy (tables Prescription, Refill, Doctor, Clinic)
3. HumanResources (tables Employee, JobTitle)
4. Inventory (tables Clinic, Doctor)
5. Classes (tables EmployeeTraining, Class
*/

/* create schema objects and set the owner to each of them
1. Sales (tables Customer, HouseHold, HealthPlan)
2. Pharmacy (tables Prescription, Reffil, Doctor, Clinic)
3. HumanResources (tables Employee, JobTitle, EmployeeTraining, Class)
4. Inventory (table Drug)

*/


-- 1) Create Sales Schema
create schema Sales authorization dbo
;
go

-- 2) Create Pharmacy Schema
create schema Pharmacy authorization dbo
;
go

-- 3) Create HumanResources Schema
create schema HumanResources authorization dbo
;
go

-- 4) Create Inventory Schema
create schema Inventory
go
