/* 
Purpose: create table in AragonPharmacy database
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


select *
from sys.all_objects;
go

/* create schema objects and set the owner to each of them
1. Sales (tables Customer, HouseHold, HealthPlan)
2. Pharmacy (tables Prescription, Reffil, Doctor, Clinic)
3. HumanResources (tables Employee, JobTitle, EmployeeTraining, Class)
4. Inventory (table Drug) */

/* ******** Table No. 1 - Sales.HealthPlan ********** */
/* ******** Table No. 2 - Sales.HouseHold ********** */
/* ******** Table No. 3 - Sales.Customer ********** */
/* ******** Table No. 4 - Pharmacy.Clinic ********** */
/* ******** Table No. 5 - Pharmacy.Doctor ********** */
/* ******** Table No. 6 - Pharmacy.Prescription ********** */
/* ******** Table No. 7 - Pharmacy.Refill ********** */
/* ******** Table No. 8 - Inventory.Drug ********** */
/* ******** Table No. 9 - HumanResources.JobTitle ********** */
/* ******** Table No. 10 - HumanResources.Employee ********** */
/* ******** Table No. 11 - HumanResources.Class ********** */
/* ******** Table No. 12 - HumanResources.EmployeeTraining ********** */




/* ******** Table No. 1 - Sales.HealthPlan ********** */
if OBJECT_ID('Sales.HealthPlan', 'U') is not null
drop table Sales.HealthPlan
;
go

create table Sales.HealthPlan
(
	PlanID int identity (1,1) not null,
	PlanName nvarchar(30) not null,
	Address nvarchar(40) not null,
	City nvarchar(15) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	Phone nchar(14) not null, -- input mask to format (###) ###-####
	Days int not null,
	Website nvarchar(60) null,
	constraint pk_HealthPlan primary key clustered (PlanID asc)
)
;
go

create 

/* ******** Table No. 2 - Sales.HouseHold ********** */
if OBJECT_ID('Sales.HouseHold', 'U') is not null
drop table Sales.HouseHold
;
go

create table Sales.HouseHold
(
	HouseID int identity(1,1) not null,
	Address nvarchar(40) not null,
	City nvarchar(15) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	constraint pk_HouseHold primary key clustered (HouseID asc)
)
;
go



/* ******** Table No. 3 - Sales.Customer ********** */
if OBJECT_ID('Sales.Customer', 'U') is not null
drop table Sales.Customer
;
go

create table Sales.Customer
(
	CustID int identity(1,1) not null,
	CustFirst nvarchar(30) not null,
	CustLast nvarchar(30) not null,
	Phone nchar(14) not null, -- input mask to format (###) ###-####
	DOB datetime not null,
	Gender bit not null,
	Balance money null, -- set default 0,00
	ChildproofCap bit not null,
	PlanID int not null, -- FK lookup table HealthPlan | PlanID and PlanName
	HouseID int not null, -- FK HOuseHold
	HeadHH bit not null, -- yes or no
	Allergies nvarchar(40) null,
	constraint pk_Customer primary key clustered (CustID asc)
)
;
go



/* ******** Table No. 4 - Pharmacy.Clinic ********** */
if OBJECT_ID('Pharmacy.Clinic', 'U') is not null
drop table Pharmacy.Clinic
;
go

create table Pharmacy.Clinic
(
	ClinicID int identity(1,1) not null, 
	ClinicName nvarchar(30) not null,
	Address1 nvarchar(40) not null,
	Address2 nvarchar(40) null,
	City nvarchar(15) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	Phone nchar(14) not null, -- input mask to format (###) ###-####
	constraint pk_Clinic primary key clustered (ClinicID asc)
)
;
go



/* ******** Table No. 5 - Pharmacy.Doctor ********** */
if OBJECT_ID('Pharmacy.Doctor', 'U') is not null
drop table Pharmacy.Doctor
;
go

create table Pharmacy.Doctor
(
	DoctorID int identity(1,1) not null, 
	DoctorFirst nvarchar(30) not null,
	DoctorLast nvarchar(30) not null,
	Phone nchar(14) null, -- input mask to format (###) ###-####
	Cell nchar(14) null, -- input mask to format (###) ###-####
	ClinicID int  not null, -- FK Pharmacy.Clinic
	constraint pk_Doctor primary key clustered (DoctorID asc)
)
;
go



/* ******** Table No. 6 - Pharmacy.Prescription ********** */
if OBJECT_ID('Pharmacy.Prescription', 'U') is not null
drop table Pharmacy.Prescription
;
go

create table Pharmacy.Prescription
(
	PrescriptionID int identity(1,1) not null,
	DIN nchar(8) not null, -- FK Prescriptions.Drug
	Quantity decimal(5,2) not null,
	Unit nvarchar(10) not null,
	Date datetime not null, -- format mm/dd/yyyy
	ExpireDate datetime not null, -- format mm/dd/yyyy  -- apply constraint ck ExpireDate > Date
	Refills nvarchar(2) null,
	AutoRefill bit not null,
	RefillsUsed nvarchar(2) null,
	Instructions nvarchar(50) not null,
	CustID int not null,-- FK Sales.Customer
	DoctorID int not null, -- FK Pharmacy.Doctor
	constraint pk_Prescription primary key clustered (PrescriptionID asc )
)
;
go

-- drop table Pharmacy.Prescription;

/* ******** Table No. 7 - Pharmacy.Refill ********** */
if OBJECT_ID('Pharmacy.Refill', 'U') is not null
drop table Pharmacy.Refill
;
go

create table Pharmacy.Refill
(
	PrescriptionID int not null, -- FK Pharmacy.Prescriptions
	RefillDate datetime not null, -- format MM/DD/YYYY
	EmpID uniqueidentifier not null -- FK HumanResources.Employee
	constraint pk_Refill primary key clustered
		(
			PrescriptionID asc,
			RefillDate asc
		) -- composite PK
)
;
go

drop table Pharmacy.Refill;

/* ******** Table No. 8 - Inventory.Drug ********** */
if OBJECT_ID('Inventory.Drug', 'U') is not null
drop table Inventory.Drug
;
go

create table Inventory.Drug
(
	DIN nchar(8) not null,
	Name nvarchar(30) not null, -- add index
	Generic bit not null,
	Description nvarchar(300) not null,
	Unit nvarchar(10) not null,
	Dosage nvarchar(10) not null,
	DosageForm nvarchar(20) not null,
	Cost money not null,
	Price money not null,
	Interactions nvarchar(100) not null,
	Supplier nvarchar(50) not null,
	constraint pk_Drug primary key clustered (DIN asc)
)
;
go



/* ******** Table No. 9 - HumanResources.JobTitle ********** */
if OBJECT_ID('HumanResources.JobTitle', 'U') is not null
drop table HumanResources.JobTitle
;
go

create table HumanResources.JobTitle
(
	JobID int identity(1,1) not null,
	Title nvarchar(30) not null,
	constraint pk_JobTitle primary key clustered (JobID asc )
)
;
go



/* ******** Table No. 10 - HumanResources.Employee ********** */
if OBJECT_ID('HumanResources.Employee', 'U') is not null
drop table HumanResources.Employee
;
go

create table HumanResources.Employee
(
	EmpID int identity(1,1) not null,
	EmpFirst nvarchar(30) not null,
	EmpMI nchar(2) null,
	EmpLast nvarchar(30) not null,
	SIN nchar(11) not null, -- input mask to format ###-###-###
	DOB datetime not null, -- format MM/DD/YYYY
	StartDate datetime not null, -- format MM/DD/YYYY
	EndDate datetime null, -- format MM/DD/YYYY -- apply check EndDate > startDate
	Address nvarchar(40) not null,
	City nvarchar(15) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	JobID int not null, -- FK Employees.JobTiTle
	Memo nvarchar(255) null, 
	Phone nchar(14) null, -- input mask to format (###) ###-####
	Cell nchar(14) null, -- input mask to format (###) ###-####
	Salary money null,
	HourlyRate money null,
	Review datetime null, -- format MM/DD/YYYY
	constraint pk_Employee primary key clustered (EmpID asc )
)
;
Go


-- drop table HumanResources.Employee;


/* ******** Table No. 11 - HumanResources.Class ********** */
if OBJECT_ID('HumanResources.Class', 'U') is not null
drop table HumanResources.Class
;
go

create table HumanResources.Class
( 
	ClassID nvarchar(8) not null,
	Description nvarchar(100) not null,
	Cost money not null,
	Renewal datetime null,
	Required bit not null,
	Provider nvarchar(45) not null,
	constraint pk_Class primary key clustered (ClassID asc )
)
;
go



/* ******** Table No. 12 - HumanResources.EmployeeTraining ********** */
if OBJECT_ID('HumanResources.EmployeeTraining', 'U') is not null
drop table HumanResources.EmployeeTraining
;
go

create table HumanResources.EmployeeTraining
(
	EmpID uniqueidentifier not null, -- FK Employees.Employee
	Date datetime not null, -- format MM/DD/YYYY
	ClassID nvarchar(8) not null -- FK Classes.Class
	constraint pk_EmployeeTraining primary key clustered
		(
			EmpID asc,
			Date asc,
			ClassID asc
		) -- composite PK
)
;
go

-- drop table HumanResources.EmployeeTraining;