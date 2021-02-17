/* 
Purpose: apply data integrity on AragonPharmacy database
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


/* schemas
1. Sales (tables Customer, HouseHold, HealthPlan)
2. Pharmacy (tables Prescription, Reffil, Doctor, Clinic)
3. HumanResources (tables Employee, JobTitle, EmployeeTraining, Class)
4. Inventory (table Drug) */

/* apply data integrity */

/* -------------------------------- Table No. 1 - Sales.HealthPlan -------------------------------- */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/* -------------------------------- Table No. 2 - Sales.HouseHold -------------------------------- */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/*-------------------------------- Table No. 3 - Sales.Customer -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between Sales.Customers and Sales.HealthPlan //
	-- 2) set constraint FK between Sales.Customers and Sales.Houselholds //
-- constraints default:
	-- set default 0 to Balance
-- no constraints check


/* -------------------------------- Table No. 4 - Pharmacy.Clinic -------------------------------- */
-- no extras foreign keys
-- constraints default:
	-- set default province QC
-- no constraints check

/* -------------------------------- Table No. 5 - Pharmacy.Doctor -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between Pharmacy.Doctor and Pharmacy.Clinic //
-- no constraints default
-- no constraints check

/*-------------------------------- Table No. 6 - Pharmacy.Prescription -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between Pharmacy.Prescription and Inventory.Drug //
	-- 2) set constraint FK between Pharmacy.Prescription and Sales.Customer //
	-- 3) set constraint FK between Pharmacy.Prescription and Pharmacy.Doctor //
-- constraints default:
	-- constraint default 'no autorefill' for autorefill
	-- constraint default date --> getdate()
-- no constraints check

/* -------------------------------- Table No. 7 - Pharmacy.Refill -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between Pharmacy.Refill and Pharmacy.Prescription //
	-- 2) set constraint FK between Pharmacy.Refill and HumanResources.Employee //
-- no constraints default
-- constraints check:
	-- check constraint expiredate > date

/* -------------------------------- Table No. 8 - Inventory.Drug -------------------------------- */
-- no extras foreign keys
-- no constraints default
-- constraints check:
	-- check constraint cost < price
-- constraint unique:
	-- constraintunique DIN

/* -------------------------------- Table No. 9 - HumanResources.JobTitle ------------------------ */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/* -------------------------------- Table No. 10 - HumanResources.Employee -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between  HumanResources.Employee and HumanResources.JobTitle //
-- no constraints default
-- constraints check:
	-- check constraint employee review > start date

/* -------------------------------- Table No. 11 - HumanResources.Class -------------------------------- */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/*-------------------------------- Table No. 12 - HumanResources.EmployeeTraining -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK HumanResources.EmployeeTraining and HumanResources.Employee //
	-- 2) set constraint FK HumanResources.EmployeeTraining and HumanResources.Class //
-- no constraints default
-- no constraints check




-- ====================================================================================================================





/* -------------------------------- Table No. 1 - Sales.HealthPlan -------------------------------- */
-- no extras foreign keys
-- constraints default
-- set the default constraint value to 'QC' for Province
alter table Sales.HealthPlan
	add constraint df_Province_HealthPlan
		default ('QC') for Province
;
go

-- constraints check:
--  check that postal code appears in the following format:
-- uppercase letter, number, uppercase letter, space, number, uppercase letter, number
-- (for example, T6H 8U7)
alter table Sales.HealthPlan 
	add constraint ck_PostalCode_HealthPlan 
		check (PostalCode like ('[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'))
;
go

--  check that phone number is in the format of (###) ###-####
alter table Sales.HealthPlan 
	add constraint ck_Phone_HealthPlan 
		check (Phone like ('([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
;
go 

/* -------------------------------- Table No. 2 - Sales.HouseHold -------------------------------- */
-- no extras foreign keys
-- constraints default:
--  set the default constraint value to 'QC' for Province
alter table Sales.Household
	add constraint df_Province_Household
		default ('QC') for Province
;
go

-- constraints check:
--  check that postal code appears in the following format:
-- uppercase letter, number, uppercase letter, space, number, uppercase letter, number
-- (for example, T6H 8U7)
alter table Sales.Household 
	add constraint ck_PostalCode_Household
		check (PostalCode like ('[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'))
;
go


/* -------------------------------- Table No. 3 - Sales.Customer -------------------------------- */
-- extras foreign keys:
-- 1) set constraint FK between Sales.Customers and Sales.HealthPlan //
alter table Sales.Customer
	add constraint fk_Customer_HealthPlan foreign key (PlanID)
		references Sales.HealthPlan (PlanID)
;
go

-- 2) set constraint FK between Sales.Customers and Sales.Houselholds //
alter table Sales.Customer
	add constraint fk_Customer_HouseHold foreign key (HouseID)
		references Sales.HouseHold (HouseID)
;
go

-- constraints default:
-- set default 0 to Balance
alter table Sales.Customer
	add constraint df_Balance_Customer default (0) for Balance
;
go

-- no constraints check


/* -------------------------------- Table No. 4 - Pharmacy.Clinic -------------------------------- */
-- no extras foreign keys
-- constraints default:
-- set default province QC
alter table Pharmacy.Clinic
	add constraint df_Procinve_Clinic default ('QC') for Province
;
go

-- constraints check:
-- check that postal code appears in the following format:
-- uppercase letter, number, uppercase letter, space, number, uppercase letter, number
-- (for example, T6H 8U7)
alter table Pharmacy.Clinic  
	add constraint ck_PostalCode_Clinic
		check (PostalCode like ('[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'))
;
go

--  check that phone number is in the format of (###) ###-####
alter table Pharmacy.Clinic 
	add constraint ck_Phone_Clinic 
		check (Phone like ('([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
;
go 

/* -------------------------------- Table No. 5 - Pharmacy.Doctor -------------------------------- */
-- extras foreign keys:
-- 1) set constraint FK between Pharmacy.Doctor and Pharmacy.Clinic //
alter table Pharmacy.Doctor
	add constraint fk_Doctor_Clinic foreign key (ClinicID)
		references Pharmacy.Clinic (ClinicID)
;
go

-- no constraints default
-- constraints check:
--  check that phone number is in the format of (###) ###-####
alter table Pharmacy.Doctor 
	add constraint ck_Phone_Doctor 
		check (Phone like ('([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
;
go 

--  check that cellphone number is in the format of (###) ###-####
alter table Pharmacy.Doctor 
	add constraint ck_Cell_Doctor 
		check (Cell like ('([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
;
go


/* -------------------------------- Table No. 6 - Pharmacy.Prescription -------------------------------- */
-- extras foreign keys:
-- 1) set constraint FK between Pharmacy.Prescription and Inventory.Drug //
alter table Pharmacy.Prescription
	add constraint fk_Precription_Drug foreign key (DIN)
		references Inventory.Drug (DIN)
;
go

-- 2) set constraint FK between Pharmacy.Prescription and Sales.Customer //
alter table Pharmacy.Prescription
	add constraint fk_Prescription_Customer foreign key (CustID)
		references Sales.Customer (CustID)
;
go

-- 3) set constraint FK between Pharmacy.Prescription and Pharmacy.Doctor //
alter table Pharmacy.Prescription
	add constraint fk_Prescription_Doctor foreign key (DoctorID)
		references Pharmacy.Doctor (DoctorID)
;
go

-- constraints default:
-- constraint default 'no autorefill' for autorefill --> executed, used 0 (zero) instead false as moha suggest.
alter table Pharmacy.Prescription
	add constraint df_AutoRefill_Prescription default (0) for AutoRefill
;
go

	-- constraint default date --> getdate()   ???????????????????????????????????? not executed yet
/*	alter table Pharmacy.Prescription
	add constraint df_Date_Prescription default (getdate()) for Date
	;
	go
*/

-- constraints check:
-- check constraint expiredate > date
alter table Pharmacy.Prescription
	add constraint ck_ExpireDate_Date_Prescription check (ExpireDate > Date)
;
go



/* -------------------------------- Table No. 7 - Pharmacy.Refill -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between Pharmacy.Refill and Pharmacy.Prescription //
alter table Pharmacy.Refill
	add constraint fk_Refill_Prescription foreign key (PrescriptionID)
		references Pharmacy.Prescription (PrescriptionID)
;
go

-- 2) set constraint FK between Pharmacy.Refill and HumanResources.Employee // 
alter table Pharmacy.Refill
	add constraint fk_Refill_Employee foreign key (EmpID)
		references HumanResources.Employee (EmpID )
;
go

-- no constraints default
-- no constraints check


/* -------------------------------- Table No. 8 - Inventory.Drug -------------------------------- */
-- no extras foreign keys
-- no constraints default
-- constraints check:
-- check constraint cost < price
alter table Inventory.Drug
	add constraint ck_Cost_Price_Drug check (Cost < Price)
;
go

-- constraint unique:
-- constraintunique DIN
alter table Inventory.Drug
	add constraint uq_DIN_Drug unique (DIN)
;
go


/* -------------------------------- Table No. 9 - HumanResources.JobTitle -------------------------------- */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/* -------------------------------- Table No. 10 - HumanResources.Employee -------------------------------- */
-- extras foreign keys:
	-- 1) set constraint FK between  HumanResources.Employee and HumanResources.JobTitle //
alter table HumanResources.Employee
	add constraint fk_Employee_JobTitle foreign key (JobID)
		references HumanResources.JobTitle (JobID)
;
go 

-- constraints default
-- set the default constraint value to 'QC' for Province
alter table HumanResources.Employee
	add constraint df_Province_Employee
		default ('QC') for Province
;
go 

-- constraints check:
-- check that EndDate > StartDate
alter table HumanResources.Employee
	add constraint ch_EndDate_Employee 
		check(EndDate > StartDate)
;
go

-- check that SIN is a nine-digit number displayed with the following format: ###-###-###
alter table HumanResources.Employee
	add constraint ck_SIN_Employee
		check (SIN like ('[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'))
;
go

-- check that postal code appears in the following format:
-- uppercase letter, number, uppercase letter, space, number, uppercase letter, number
-- (for example, T6H 8U7)
alter table HumanResources.Employee
	add constraint ck_PostalCode_Employee
		check (PostalCode like ('[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'))
;
go


-- check that phone number is in the format of (###) ###-####
alter table HumanResources.Employee
	add constraint ck_Phone_Employee 
		check (Phone like ('([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
;
go 

-- check that cellphone number is in the format of (###) ###-####
alter table HumanResources.Employee 
	add constraint ck_Cell_Employee
		check (Cell like ('([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
;
go

-- check that DOB date is in the format of ##/##/####
alter table HumanResources.Employee 
	add constraint ck_DOB_Employee
		check (DOB like ('[0,1][0-9]/[0,1][0-9]/[1,2][0,9][0-9][0-9]'))
;
go

-- check that StartDate date is in the format of ##/##/####
alter table HumanResources.Employee  
	add constraint ck_StartDate_Employee
		check (StartDate like ('[0,1][0-9]/[0,1][0-9]/[1,2][0,9][0-9][0-9]'))
;
go

--  check that EndDate date is in the format of ##/##/####
alter table HumanResources.Employee
	add constraint ck_EndDate_Employee
		check (EndDate like ('[0,1][0-9]/[0,1][0-9]/[1,2][0,9][0-9][0-9]'))
;
go

-- check constraint employee review > start date
alter table HumanResources.Employee
	add constraint ck_Review_StartDate_Employee check (Review > StartDate)
;
go

-- constraint unique
alter table HumanResources.Employee
	add constraint uq_SIN_Employee unique (SIN)
;
go

/* -------------------------------- Table No. 11 - HumanResources.Class -------------------------------- */
-- no extras foreign keys
-- constraints default:
alter table HumanResources.Class
	add constraint df_Renewal_Class
		default (0) for Renewal
;
go

-- no constraints check

/* -------------------------------- Table No. 12 - HumanResources.EmployeeTraining -------------------------------- */
-- extras foreign keys:
-- 1) set constraint FK HumanResources.EmployeeTraining and HumanResources.Employee //
alter table HumanResources.EmployeeTraining
	add constraint fk_EmployeeTraining_Employee foreign key (EmpID)
		references HumanResources.Employee (EmpID)
;
go

-- 2) set constraint FK HumanResources.EmployeeTraining and HumanResources.Class //
alter table HumanResources.EmployeeTraining
	add constraint fk_EmployeeTraining_Class foreign key (ClassID)
		references HumanResources.Class (ClassID)
;
go

-- no constraints default
-- no constraints check




-- ====================================================================================


/* convert provice column to uppercase */
/*
update Sales.HouseHold
set province = UPPER(province)
;
go
update Sales.HealthPlan
set province = UPPER(province)
;
go
update HumanResources.Employee
set province = UPPER(province)
;
go
update Pharmacy.Clinic
set province = UPPER(province)
;
go

*/


/* 1. check if indexes exist in the HR.Employee table */
execute sp_helpindex 'HumanResources.Employee'
;
go


/* 2. check if indexes exist in the HR.JobTitle table */
execute sp_helpindex 'HR.JobTitle'
;
go

/* 3. check if indexes exist in the HR.Class table */
execute sp_helpindex 'HR.Class'
;
go

/* 4. check if indexes exist in the HR.EmployeeTraining table */
execute sp_helpindex 'HR.EmployeeTraining'
;
go

/* 5. check if indexes exist in the Sales.Customer table */
execute sp_helpindex 'Sales.Customer'
;
go


/* 6. check if indexes exist in the Sales.HealthPlan table */
execute sp_helpindex 'Sales.HealthPlan'
;
go


/* 7. check if indexes exist in the Sales.Household table */
execute sp_helpindex 'Sales.Household'
;
go


/* 8. check if indexes exist in the Pharmacy.Doctor table */
execute sp_helpindex 'Pharmacy.Doctor'
;
go

/* 9. check if indexes exist in the Pharmacy.Refill table */
execute sp_helpindex 'Pharmacy.Refill'
;
go

/* 10. check if indexes exist in the Pharmacy.Prescription table */
execute sp_helpindex 'Pharmacy.Prescription'
;
go

/* 11. check if indexes exist in the Pharmacy.Clinic table */
execute sp_helpindex 'Pharmacy.Clinic'
;
go

/* 12. check if indexes exist in the Inventory.Drug table */
execute sp_helpindex 'Inventory.Drug'
;
go



select name,  -- name of the index. Name is unique
index_id, -- the ID of the index: 0 --> heap, 1 --> clustered
type,  -- type of index: 0 --> heap, 1 --> clustered, 2 --> non clustered, 3--> xml, 4 --> spatial
type_desc, --  description of the index
is_unique, -- 1 --> is unique, 0 --> index is not unique
is_primary_key -- 1 --> index is a part of the primary key
from sys.indexes
where object_id = OBJECT_ID('Pharmacy.Prescription')
;
go


select name,  -- name of the index. Name is unique
index_id, -- the ID of the index: 0 --> heap, 1 --> clustered
type,  -- type of index: 0 --> heap, 1 --> clustered, 2 --> non clustered, 3--> xml, 4 --> spatial
type_desc, --  description of the index
is_unique, -- 1 --> is unique, 0 --> index is not unique
is_primary_key -- 1 --> index is a part of the primary key
from sys.indexes
where object_id = OBJECT_ID('Sales.Customer')
;
go