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
use AragonPharmacy
;
go

/* ******** Table No. 1 - Customers.HealthPlan ********** */
-- no extras foreign keys
-- no constraints default
-- no constraints check


/* ******** Table No. 2 - Customers.Houselholds ********** */
-- no extras foreign keys
-- no constraints default
-- no constraints check


/* ******** Table No. 3 - Customers.Customer ********** */
-- extras foreign keys:
-- 1) set constraint FK between Customers.Customers and Customers.HealthPlan
alter table Customers.Customer
	add constraint fk_Customer_HealthPlan foreign key (PlanID)
	references Customers.HealthPlan (PlanID)
;
go

-- 2) set constraint FK between Customers.Customers and Customers.Houselholds
alter table Customers.Customer
	add constraint fk_Customer_HouseHold foreign key (HouseID)
	references Customers.Houselhold (HouseID)
;
go

-- constraints default:
-- set default 0 to Balance
alter table Customers.Customer
	add constraint df_Balance_Customer default (0) for Balance
;
go

-- no constraints check


/* ******** Table No. 4 - Doctors.Clinic ********** */
-- no extras foreign keys

-- constraints default:
-- set default province QC
alter table Doctors.Clinic
	add constraint df_Procinve_Clinic default ('QC') for Province
;
go

-- no constraints check


/* ******** Table No. 5 - Doctors.Doctor ********** */
-- extras foreign keys:
-- 1) set constraint FK between Doctors.Doctor and Doctors.Clinic
alter table Doctors.Doctor
	add constraint fk_Doctor_Clinic foreign key (ClinicID)
	references Doctors.Clinic (ClinicID)
;
go

-- no constraints default
-- no constraints check

/* ******** Table No. 6 - Prescriptions.Drug ********** */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/* ******** Table No. 7 - Prescriptions.Rx ********** */
-- extras foreign keys:
-- 1) set constraint FK between Prescriptions.Rx and Prescriptions.Drug
alter table Prescriptions.Rx
	add constraint fk_Rx_Drug foreign key (DIN)
	references Prescriptions.Drug (DIN)
;
go

-- 2) set constraint FK between Prescriptions.Rx and Customers.Customer
alter table Prescriptions.Rx
	add constraint fk_Rx_Customer foreign key (CustID)
	references Customers.Customer (CustID)
;
go

-- 3) set constraint FK between Prescriptions.Rx and Doctors.Doctor
alter table Prescriptions.Rx
	add constraint fk_Rx_Doctor foreign key (DoctorID)
	references Doctors.Doctor (DoctorID)
;
go

-- no constraints default
-- no constraints check

/* ******** Table No. 8 - Employees.JobTitle ********** */
-- no extras foreign keys
-- no constraints default
-- no constraints check

/* ******** Table No. 9 - Employees.Employee ********** */
-- extras foreign keys:
-- 1) set constraint FK betweenEmployees.Employee and Employees.JobTitle
alter table Employees.Employee
	add constraint fk_Employee_JobTitle foreign key (JobID)
	references Employees.JobTitle (JobID)
;
go

-- no constraints default
-- no constraints check

/* ******** Table No. 10 - Prescriptions.Refill ********** */
-- extras foreign keys:
-- 1) set constraint FK Prescriptions.Refill and Prescriptions.Rx
alter table Prescriptions.Refill
	add constraint fk_Refill_Rx foreign key (PrescriptionID)
	references Prescriptions.Rx (PrescriptionID)
;
go

-- 2) set constraint FK Prescriptions.Refill and Employees.Employee
alter table Prescriptions.Refill
	add constraint fk_Refill_Employee foreign key (EmpID)
	references Employees.Employee (EmpID )
;
go

-- no constraints default
-- no constraints check


/* ******** Table No. 11 - Classes.Class ********** */
-- no extras foreign keys
-- no constraints default
-- no constraints check


/* ******** Table No. 12 - Classes.EmployeeTraining ********** */
-- extras foreign keys:
-- 1) set constraint FK Classes.EmployeeTraining and Employees.Employee
alter table Classes.EmployeeTraining
	add constraint fk_EmployeeTraining_Employee foreign key (EmpID)
	references Employees.Employee (EmpID )
;
go

-- 2) set constraint FK Classes.EmployeeTraining and Classes.Class
alter table Classes.EmployeeTraining
	add constraint fk_EmployeeTraining_Class foreign key (ClassID)
	references Classes.Class (ClassID)
;
go
-- no constraints default
-- no constraints check