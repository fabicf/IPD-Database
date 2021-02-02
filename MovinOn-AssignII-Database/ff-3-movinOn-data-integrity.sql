/* Purpose: To Apply data integrity in the tables of movinOn database */

/*Scripts Date: January 31, 2021
Developed by: Fabiola Faria */

use movinOn
;

/*
Table No. 1 - Warehouses
	no FK, Uq, Default
Table No. 2 - Positions
	no FK, Uq, Default
Table No. 3 - Vehicles
	no FK, Uq, Default
Table No. 4 - Drivers
	constraint check in EndDate column - ok
    constraint unique in SSN column - ok
Table No. 5 - Customers
	constraint default = 0 in Balance column - ok
Table No. 6 - Employees
	constraint FK in PositionID column - ok
    constraint FK in WarehouseID column - ok
	constraint check in EndDate column - ok
    constraint check in Salary column - ok
    constraint check in HourlyRate column - ok
	constraint unique in SSN column - ok
Table No. 7 - StorageUnits 
	constraint FK in WarehouseID column - ok
Table No. 8 - UnitRentals
	constraint FK in CustID column - ok
	constraint FK in WarehouseID column - ok
    constraint FK in UnitID column - ok 
    constraint check in DateOut column - ok
Table No. 9 - JobOrders
	constraint FK in CustID column - ok 
    constraint FK in JobDetailsID column -- REMOVED IN LAST MEETING - ok
Table No. 10 - JobDetails
	constraint FK in JobID column
	constraint FK in VehicleID column - ok
    constraint FK in DriverID column - ok
*/



/* ============= Table No. 4 - Drivers ================== */

-- add constraint check in EndDate column (Drivers table)
alter table Drivers
    add constraint ck_Drivers_EndDate_StartDate
    check (EndDate > StartDate)
    ;

-- constraint unique in SSN column (Drivers table)
alter table Drivers
	add constraint uq_Drivers unique (SSN)
    ;


/* ============= Table No. 5 - Customers  ================== */

-- add constraint default = 0 in Balance column (Customers table)
alter table Customers
	alter column Balance
    set default 0
    ;


/* ============= Table No. 6 - Employees  ================== */

-- add constraint FK in PositionID column (Employees table)
alter table Employees
    add constraint fk_Employees_Positions foreign key (PositionID)
    references Positions (PositionID)
    ;

-- add constraint FK in WarehouseID column (Employees table)
alter table Employees
    add constraint fk_Employees_Warehouses foreign key (WarehouseID)
    references Warehouses (WarehouseID)
    ;

-- add constraint check in EndDate column (Employees table)
alter table Employees
    add constraint ck_Employees_EndDate_StartDate
    check (EndDate > StartDate)
    ;

-- add constraint check in Salary column (Employees table)
-- alter table Employees
--     add constraint ck_Employees_Salary
--     check (Salary >= 24570)
--     ;

-- alter table Employees
-- drop constraint ck_Employees_Salary;


-- -- add  constraint check in HourlyRate column (Employees table)
-- alter table Employees
--     add constraint ck_Employees_HourlyRate
--     check (HourlyRate >= 13.5)
--     ;

-- alter table Employees
-- drop constraint ck_Employees_HourlyRate;


-- add constraint unique in SSN column (Employees table)
alter table Employees
	add constraint uq_Employees unique (SSN)
    ;


/* ============= Table No. 7 - StorageUnits  ================== */

-- add constraint FK in WarehouseID column (StorageUnits table)
alter table StorageUnits
	add constraint fk_StorageUnits_Warehouses foreign key (WarehouseID)
    references Warehouses (WarehouseID)
    ;


/* ============= Table No. 8 - UnitRentals  ================== */

-- add constraint FK in CustID column (UnitRentals table)
alter table UnitRentals
    add constraint fk_UnitRentals_Customers foreign key (CustID)
    references Customers (CustID)
    ;
    
-- add constraint FK in WarehouseID column (UnitRentals table)
    alter table UnitRentals
    add constraint fk_UnitRentals_WarehouseID foreign key (WarehouseID)
    references Warehouses (WarehouseID)
    ;
    
-- alter table UnitRentals
-- 	drop constraint fk_UnitRentals_WarehouseID;

-- add constraint FK in UnitID column (UnitRentals table)
    alter table UnitRentals
    add constraint fk_UnitRentals_StorageUnits foreign key (UnitID)
    references StorageUnits (UnitID)
    ;


-- add  constraint check in DateOut column	(UnitRentals table)
alter table UnitRentals
	add constraint ck_UnitRentals_DateOut_DateIn
    check (DateOut > DateIn)
    ;


/* ============= Table No. 9 - JobOrders ================== */

-- add constraint FK in CustID column (JobOrders table)
alter table JobOrders
    add constraint fk_JobOrders_Customers foreign key (CustID)
    references Customers (CustID)
    ;
    

/* ============= Table No. 10 - JobDetails ================== */

-- add constraint FK in JobID column (JobDetails table)
alter table JobDetails
    add constraint fk_JobDetails_JobOrders foreign key (JobID)
    references JobOrders (JobID)
    ;

-- alter table JobDetails
--     drop constraint fk_JobDetails_JobOrders;


-- add constraint FK in VehicleID column (JobDetails table)
alter table JobDetails
    add constraint fk_JobDetails_Vehicles foreign key (VehicleID)
    references Vehicles (VehicleID)
    ;


-- add constraint FK in DriverID column (JobDetails table)
alter table JobDetails
    add constraint fk_JobDetails_Drivers foreign key (DriverID)
    references Drivers (DriverID)
    ;
    
