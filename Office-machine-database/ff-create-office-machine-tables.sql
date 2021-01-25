/* Purpose: To create tables in the OfficeMachine database */

/*Scripts Date: January 23, 2021
Developed by: Fabiola Faria */

-- switch to the OficeMachine database
-- syntax: use database_name

use OfficeMachine
;

/* create tables: Departments, Jobs, Employees, AbsenceForm, OvertimeForm
*/

/* ****** Table Departments ****** */
create table Departments
(
	DepID smallint auto_increment not null,
    DepName varchar(30) not null,
    constraint pk_Departments primary key (DepID asc)
    )
;


/* ****** Table Jobs ****** */
create table Jobs
(
	JobID smallint auto_increment not null,
    JobDes varchar(100) not null,
    JobCategory varchar(30) not null,
    constraint pk_Jobs primary key (JobID asc)    
)
;


/* ****** Table Employees ****** */
create table Employees
(
	EmpID smallint auto_increment not null,
    DepID smallint not null,
    FName varchar(20) not null,
    MName varchar(20) not null,
    LName varchar(20) not null,
    Gender bit not null,
    Address varchar(40) not null,
    City varchar(20) not null,
    Province varchar(20) not null,
    Country varchar(20) not null,
    PostalCode char(7) not null,
    SIN char(11) not null,
    Seniority bit not null,
    FullTime bit not null,
    HourlyWage decimal(4,2) not null,
    constraint pk_Employees primary key (EmpID asc)
)
;


/* ****** Table AbsenceForm ****** */
create table AbsenceForm
(
	AbFormID smallint auto_increment not null,
	EmpID smallint not null,
    AbStartDate date not null,
    AbLength smallint not null,
    AbCode char(1) not null,
    SickDays smallint not null,
    SpecialOccasions smallint not null,
    AbNote varchar(500) not null,
    constraint pk_AbsenceForm primary key (AbFormID asc)
)
;


/* ****** Table OvertimeForm ****** */
create table OvertimeForm
(
	OvFormID smallint auto_increment not null,
    EmpID smallint not null,
    Ratio decimal(2,1) not null,
    OvDate date not null,
    OvHours time not null,
    Balance time not null,
    OvNote varchar(500) not null,
    constraint pk_OvertimeForm primary key (OvFormID asc)
)
;