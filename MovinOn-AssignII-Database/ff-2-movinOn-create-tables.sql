/* Purpose: To create tables in the movinOn database */

/*Scripts Date: January 31, 2021
Developed by: Fabiola Faria */

use movinOn
;

/*
Table No. 1 - Warehouses
Table No. 2 - Positions
Table No. 3 - Vehicles
Table No. 4 - Drivers
Table No. 5 - Customers
Table No. 6 - Employees
Table No. 7 - StorageUnits
Table No. 8 - UnitRentals
Table No. 9 - JobOrders
Table No. 10 - JobDetails

*/

/* ***** Table No. 1 - Warehouses ***** */
create table Warehouses
(
	WarehouseID char(4) not null,
    Address varchar(30) not null,
    City varchar(15) not null,
    State char(2) not null, 
    Zip char(5) not null,
    Phone char(10) not null, 
    ClimateControl bit not null,
    SecurityGate bit not null,
    constraint pk_Warehouses primary key clustered (WarehouseID asc)
)
;

describe Warehouses
;

/* ***** Table No. 2 - Positions ***** */
create table Positions
(
	PositionID smallint auto_increment not null,
    title varchar(15) not null,
    constraint pk_Positions primary key clustered (PositionID asc)
)
;

alter table Positions
	modify column title varchar(35) not null
;

describe Positions
;

/* ***** Table No. 3 - Vehicles ***** */
create table Vehicles
(
	VehicleID char(7) not null,
    LicensePlateNum char(7) not null,
    Axle  char(1) not null,
    Color varchar(10) not null,
    constraint pk_Vehicles primary key clustered (VehicleID asc)
)
;

describe Vehicles
;

/* ***** Table No. 4 - Drivers ***** */
create table Drivers
(
	DriverID smallint auto_increment not null,
    DriverFirst varchar(20) not null,
    DriverLast varchar(20) not null,
    SSN char(9) not null,
    DOB date not null,
    StartDate date not null,
    EndDate date null,
    Address varchar(30) not null,
    City varchar(15) not null,
    State char(2) not null, 
    Zip char(5) not null,
    Phone char(10) not null, 
    Cell char(10) not null,
    MileageRate decimal(3,2) not null,
	Review date null,
    DrivingRecord char(1) not null,
    constraint pk_Drivers primary key clustered (DriverID asc)    
)
;

describe Drivers
;

/* ***** Table No. 5 - Customers ***** */
create table Customers
(
	CustID smallint auto_increment not null,
    CompanyName varchar(20) null,
    ContactFirst varchar(20) not null,
    ContactLast varchar(22) not null,
    Address varchar(30) not null,
    City varchar(15) not null,
    State char(2) not null, 
    Zip char(5) not null,
    Phone char(10) not null, 
    Balance decimal(8,2) not null,
    constraint pk_Customers primary key clustered (CustID asc)    
)
;

-- alter the length of company name
alter table Customers
	modify column CompanyName varchar(50) null
;

-- alter the length of City
alter table Customers
	modify column City varchar (15) not null
;

-- alter the length of state
alter table Customers
	modify column State char (2) not null
;

describe Customers
;

/* ***** Table No. 6 - Employees ***** */
create table Employees
(
	EmpID smallint auto_increment not null,
    EmpFirst varchar(20) not null,
    EmpLast varchar(20) not null,
    Address varchar(30) not null,
    City varchar(15) not null,
    State char(2) not null, 
    Zip char(5) not null,
    Phone char(10) not null, 
    Cell char(10) not null,
    SSN char(9) not null,
    DOB date not null,
    StartDate date not null,
    EndDate date null,
    PositionID smallint not null, -- FK Positions
    Salary decimal(8,2) null,
    HourlyRate decimal(4,2) null,
    Review date null,
    Memo varchar(100) null,
    WarehouseID char(4) not null, -- FK Warehouses
    constraint pk_Employees primary key clustered (EmpID asc)    
)
;

alter table Employees
	modify column Salary decimal(10,2) null
;

describe Employees
;

/* ***** Table No. 7 - StorageUnits ***** */
create table StorageUnits
(
	UnitID smallint not null,
    UnitSize varchar(10) not null,
    WarehouseID char(4) not null, -- FK Warehouses
    Rent decimal(4,2) not null,
    constraint pk_StorageUnits primary key 
		(
			UnitID asc,
            WarehouseID asc
		) -- composite primary key
)
;

drop table StorageUnits;

-- change rent decimal(4,2) to decimal(5,2)
alter table StorageUnits
	modify column  Rent decimal(5,2) not null
;

describe StorageUnits
;



/* ***** Table No. 8 - UnitRentals ***** */
create table UnitRentals
(
	CustID smallint not null, -- FK Customers
    WarehouseID char(4) not null, -- FK Warehouses
    UnitID smallint not null, -- FK StorageUnits
    DateIn date not null,
    DateOut date null,
    constraint pk_UnitRentals primary key
		(
			CustID asc,
            WarehouseID asc,
            UnitID asc
        ) -- composite primary key
)
;

describe UnitRentals
;


/* ***** Table No. 9 - JobOrders ***** */
create table JobOrders
(
	JobID smallint auto_increment not null,
    CustID smallint not null, -- FK Customers
    MoveDate date not null,
    FromAddress varchar(30) not null,
    FromCity varchar(15) not null,
    FromState char(2) not null,
	ToAddress varchar(30) not null,
    ToCity varchar(15) not null,
    ToState char(2) not null,
    DistanceEst smallint not null,
    WeightEst smallint not null,
    Packing bit not null,
    Heavy bit not null,
    Storage bit not null,
    constraint pk_JobOrders primary key (JobID asc)
    )
;

describe JobOrders
;


/* ***** Table No. 10 - JobDetails ***** */
create table JobDetails
(
	JobID smallint not null,
    VehicleID char(7) not null, -- FK Vehicles
    DriverID smallint not null, -- FK Drivers
    MileageActual smallint not null,
    WeightActual smallint not null,
    constraint pk_JobDetails primary key 
		(
        JobID asc,
        VehicleID asc,
        DriverID asc        
        ) -- composite Primary key
        
)
;

describe JobDetails
;