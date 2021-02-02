/* Purpose: populate data in the tables of movinOn database */

/*Scripts Date: February 1st, 2021
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

/* ============= Table No. 1 - Warehouses ================== */ -- --> OK

/* load data from external csv file */
-- load data infile 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\Participant_Roles.csv'
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Warehouses.csv'
into table Warehouses
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(
	WarehouseID,
    Address,
    City,
    State, 
    Zip,
    Phone, 
    @ClimateControl,
    @SecurityGate
) set
	ClimateControl=cast(@ClimateControl as signed),
	SecurityGate=cast(@SecurityGate as signed)
;

select *
from Warehouses
; 



/* ============= Table No. 2 - Positions ================== */  -- --> Ok

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Positions.csv'
into table Positions
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;


select *
from Positions
; 

/* ============= Table No. 3 - Vehicles ================== */  -- --> Ok

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Vehicles.csv'
into table Vehicles
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;

select *
from Vehicles
; 

/* ============= Table No. 4 - Drivers ================== */ -- -->  OK

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Drivers.csv'
into table Drivers
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(
    DriverID,
    DriverFirst,
    DriverLast,
    SSN,
    DOB,
    StartDate,
    @EndDate,
    Address,
    City,
    State, 
    Zip,
    Phone, 
    Cell,
    MileageRate,
	@Review,
    DrivingRecord
) 
SET 
	Review = NULLIF(@Review,''), 
    EndDate = NULLIF(@EndDate,'')
;

-- check constrait violeted data, because in line 15 csv file the EndDate is < StartDate
-- to solve this we changed line 10 in csv file

select *
from Drivers;


/* ============= Table No. 5 - Customers ================== */  -- -->  OK

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
into table Customers
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' -- add because of special characters such as & an '
lines terminated by '\r\n'
ignore 1 rows ;

select *
from Customers;



/* ============= Table No. 6 - Employees ================== */ -- -->  OK

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Employees.csv'
into table Employees
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' -- add because of special characters such as & an '
lines terminated by '\r\n'
ignore 1 rows
(
	EmpID,
    EmpFirst,
    EmpLast,
    Address,
    City,
    State, 
    Zip,
    Phone,
    Cell,
    SSN,
    DOB,
    StartDate,
    @EndDate ,
    PositionID,
    @Salary,
    @HourlyRate,
    @Review ,
    @Memo,
    WarehouseID
) SET 
    EndDate = NULLIF(@EndDate,''),
	Salary = NULLIF(@Salary,''),
    HourlyRate = NULLIF(@HourlyRate,''),
    Review = NULLIF(@Review,''),
    Memo = NULLIF(@Memo,'')
   ;


select *
from Employees;

-- delete from Employees; Had to delete date because I set up a current date to answer question 12 and messed up with everything. 

/* ============= Table No. 7 - StorageUnits  ================== */ -- -->  OK

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/StorageUnits.csv'
into table StorageUnits
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' -- add because of special characters such as & an '
lines terminated by '\r\n'
ignore 1 rows;


select *
from StorageUnits;



/* ============= Table No. 8 - UnitRentals  ================== */ -- --> ok

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/UnitRentals.csv'
into table UnitRentals
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' -- add because of special characters such as & an '
lines terminated by '\r\n'
ignore 1 rows
(
	CustID,
    WarehouseID,
    UnitID,
    DateIn,
    @DateOut
)
SET
    DateOut = NULLIF(@DateOut,'')
;

/* error 1452 cannot add or update a child row: froeign key fails: because UnitRentals_UnitID is a FK from StorageUnits_UnitID,
but in the line 10 of csv file there was a unitID = 11, and there is no unitID = 11 in the StorageUnits: we change the csv file
for this line from unitID = 11 to UnitID = 10
*/

select *
from UnitRentals;


/* ============= Table No. 9 - JobOrders  ================== */

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/JobOrders.csv'
into table JobOrders
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
(
	JobID,
    CustID,
    MoveDate,
    FromAddress,
    FromCity,
    FromState,
	ToAddress,
    ToCity,
    ToState,
    DistanceEst,
    WeightEst,
    @Packing,
    @Heavy,
    @Storage
) 
set 
	Packing=cast(@Packing as signed), 
    Heavy=cast(@Heavy as signed), 
    Storage=cast(@Storage as signed);


    
select *
from JobOrders
;
    
    
/* ============= Table No. 10 - JobDetails  ================== */

/* load data from external csv file */
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/JobDetails.csv'
into table JobDetails
fields terminated by ','
lines terminated by '\r\n'
ignore 1 rows
;

select *
from JobDetails
;
