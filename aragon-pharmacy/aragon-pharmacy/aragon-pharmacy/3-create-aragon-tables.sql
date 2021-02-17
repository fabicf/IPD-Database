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
use AragonPharmacy
;
go


select *
from sys.all_objects;
go

/* ******** Table No. 1 - Customers.HealthPlan ********** */
/* ******** Table No. 2 - Customers.Houselholds ********** */
/* ******** Table No. 3 - Customers.Customer ********** */
/* ******** Table No. 4 - Doctors.Clinic ********** */
/* ******** Table No. 5 - Doctors.Doctor ********** */
/* ******** Table No. 6 - Prescriptions.Drug ********** */
/* ******** Table No. 7 - Prescriptions.Rx ********** */
/* ******** Table No. 8 - Employees.JobTitle ********** */
/* ******** Table No. 9 - Employees.Employee ********** */
/* ******** Table No. 10 - Prescriptions.Refill ********** */
/* ******** Table No. 11 - Classes.Class ********** */
/* ******** Table No. 12 - Classes.EmployeeTraining ********** */



/* ******** Table No. 1 - Customers.HealthPlan ********** */
if OBJECT_ID('Customers.HealthPlan', 'U') is not null
drop table Customers.HealthPlan
;
go

create table Customers.HealthPlan
(
	PlanID int identity (1,1) not null,
	PlanName nvarchar(30) not null,
	Address nvarchar(40) not null,
	City nvarchar(40) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	Phone nchar(15) not null, -- input mask to format (###) ###-####
	Days int null,
	Website nvarchar(60) null,
	constraint pk_HealthPlan primary key clustered (PlanID asc)
)
;
go


/* ******** Table No. 2 - Customers.Houselholds ********** */
if OBJECT_ID('Customers.Houselholds', 'U') is not null
drop table Customers.Houselholds
;
go


create table Customers.HouselHold
(
	HouseID int identity(1,1) not null,
	Address nvarchar(40) not null,
	City nvarchar(40) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	constraint pk_HouseHold primary key clustered (HouseID asc)
)
;
go


/* ******** Table No. 3 - Customers.Customer ********** */
if OBJECT_ID('Customers.Customer', 'U') is not null
drop table Customers.Customer
;
go

create table Customers.Customer
(
	CustID int identity(1,1) not null,
	CustFirst nvarchar(30) not null,
	CustLast nvarchar(30) not null,
	Phone nchar(15) not null, -- input mask to format (###) ###-####
	DOB datetime not null,
	Gender bit not null,
	Balance money not null, -- set default 0,00
	ChildproofCap bit not null,
	PlanID int not null, -- FK lookup table HealthPlan | PlanID and PlanName
	HouseID int not null, -- FK HOuseHold
	HeadHH bit not null, -- yes or no
	Allergies nvarchar(40) null,
	constraint pk_Customer primary key clustered (CustID asc)
)
;
go


/* ******** Table No. 4 - Doctors.Clinic ********** */
if OBJECT_ID('Doctors.Clinic', 'U') is not null
drop table Doctors.Clinic
;
go

create table Doctors.Clinic
(
	ClinicID int identity(1,1) not null, 
	ClinicName nvarchar(50) not null,
	Address1 nvarchar(40) not null,
	Address2 nvarchar(40) not null,
	City nvarchar(40) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	Phone nchar(15) not null, -- input mask to format (###) ###-####
	constraint pk_Clinic primary key clustered (ClinicID asc)
)
;
go

/* ******** Table No. 5 - Doctors.Doctor ********** */
if OBJECT_ID('Doctors.Doctor', 'U') is not null
drop table Doctors.Doctor
;
go

create table Doctors.Doctor
(
	DoctorID int identity(1,1) not null, 
	DoctorFirst nvarchar(30) not null,
	DoctorLast nvarchar(30) not null,
	Phone nchar(15) not null, -- input mask to format (###) ###-####
	Cell nchar(15) not null, -- input mask to format (###) ###-####
	ClinicID int  not null, -- FK Doctors.Clinic
	constraint pk_Doctor primary key clustered (DoctorID asc)
)
;
go


/* ******** Table No. 6 - Prescriptions.Drug ********** */
if OBJECT_ID('Prescriptions.Drug', 'U') is not null
drop table Prescriptions.Drug
;
go

create table Prescriptions.Drug
(
	DIN nchar(8) not null,
	Name nvarchar(30) not null, -- add index
	Generic bit not null,
	Description nvarchar(250) not null,
	Unit nvarchar(10) not null,
	Dosage nvarchar(10) not null,
	DosageForm nvarchar(20) not null,
	Cost money not null,
	Price money not null,
	Interactions nvarchar(60) not null,
	Supplier nvarchar(20) not null,
	constraint pk_Drug primary key clustered (DIN asc)
)
;
go



/* ******** Table No. 7 - Prescriptions.Rx ********** */
if OBJECT_ID('Prescriptions.Rx', 'U') is not null
drop table Prescriptions.Rx
;
go

create table Prescriptions.Rx
(
	PrescriptionID int identity(1,1) not null,
	DIN nchar(8) not null, -- FK Prescriptions.Drug
	Quantity decimal(8,3) not null,
	Unit nvarchar(10) not null,
	Date datetime not null, -- format mm/dd/yyyy
	ExpireDate datetime not null, -- format mm/dd/yyyy  -- apply constraint ck ExpireDate > Date
	Refills smallint not null,
	AutoRefill bit not null,
	RefillsUsed smallint not null,
	Instructions nvarchar(50) not null,
	CustID int not null,-- FK Customers.Customer
	DoctorID int not null, -- FK Doctors.Doctor
	constraint pk_Rx primary key clustered (PrescriptionID asc )
)
;
go


/* ******** Table No. 8 - Employees.JobTitle ********** */
if OBJECT_ID('Employees.JobTitle', 'U') is not null
drop table Employees.JobTitle
;
go

create table Employees.JobTitle
(
	JobID int identity(1,1) not null,
	Title nvarchar(30) not null,
	constraint pk_JobTitle primary key clustered (JobID asc )
)
;
go

/* ******** Table No. 9 - Employees.Employee ********** */
if OBJECT_ID('Employees.Employee', 'U') is not null
drop table Employees.Employee
;
go

create table Employees.Employee
(
	EmpID int identity(1,1) not null,
	EmpFirst nvarchar(30) not null,
	EmpMI nchar(2) not null,
	EmpLast nvarchar(30) not null,
	SIN nchar(9) not null, -- input mask to format ###-###-###
	DOB datetime not null, -- format MM/DD/YYYY
	StartDate datetime not null, -- format MM/DD/YYYY
	EndDate datetime not null, -- format MM/DD/YYYY -- apply check EndDate > startDate
	Address nvarchar(40) not null,
	City nvarchar(40) not null,
	Province nchar(2) not null, -- convert to uppercase | not digit/char, just letters
	PostalCode nchar(7) not null, -- convert to uppercase | use pattern
	JobID int not null, -- FK Employees.JobTiTle
	Memo nvarchar(250) not null, 
	Phone nchar(15) not null, -- input mask to format (###) ###-####
	Cell nchar(15) not null, -- input mask to format (###) ###-####
	Salary money null,
	HourlyRate money null,
	Review datetime not null, -- format MM/DD/YYYY
	constraint pk_Employee primary key clustered (EmpID asc )
)
;
Go

/* ******** Table No. 10 - Prescriptions.Refill ********** */
if OBJECT_ID('Prescriptions.Refill', 'U') is not null
drop table Prescriptions.Refill
;
go

create table Prescriptions.Refill
(
	PrescriptionID int not null, -- FK Prescriptions.Rx
	RefillDate datetime not null, -- format MM/DD/YYYY
	EmpID int not null -- FK Employees.Employee
	constraint pk_Refill primary key clustered
		(
			PrescriptionID asc,
			EmpID asc
		) -- composite PK
)
;
go

/* ******** Table No. 11 - Classes.Class ********** */
if OBJECT_ID('Classes.Class', 'U') is not null
drop table Classes.Class
;
go

create table Classes.Class
( 
	ClassID int identity(1,1) not null,
	Description nvarchar(60) not null,
	Cost money not null,
	Renewal datetime not null,
	Required bit not null,
	Provider nvarchar(40) not null,
	constraint pk_Class primary key clustered (ClassID asc )
)
;
go


/* ******** Table No. 12 - Classes.EmployeeTraining ********** */
if OBJECT_ID('Classes.EmployeeTraining', 'U') is not null
drop table Classes.EmployeeTraining
;
go

create table Classes.EmployeeTraining
(
	EmpID int not null, -- FK Employees.Employee
	Date datetime not null, -- format MM/DD/YYYY
	ClassID int not null -- FK Classes.Class
	constraint pk_EmployeeTraining primary key clustered
		(
			EmpID asc,
			ClassID asc
		) -- composite PK
)
;
go