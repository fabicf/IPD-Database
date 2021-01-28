/*/* Purpose: Apply data integrity to tables in the officemachine database  
 	Script Date: January 26, 2021
    Developed By: Fabiola Faria
*/

use OfficeMachine
;

/* ****************************************************************** */
/* foreign key constrains to the Employees table    */
-- 1. Between Employees and Departments tables
alter table Employees
	add constraint fk_Employees_Departments foreign key(DepID)
	references Departments(DepID)
;

-- 2. Between Employees and Jobs tables
alter table Employees
	add constraint fk_Employees_Jobs foreign key (JobID)
	references Jobs (JobID)
;


/* ****************************************************************** */
/*  foreign key constrains to the AbsenceForm table */
-- 1. Between AbsenceForm and Employees tables
alter table AbsenceForm
	add constraint fk_AbsenceForm_Employees foreign key(EmpID)
	references Employees(EmpID)
;

/*  foreign key constrains to the AbsenceForm table */
-- 1. Between AbsenceForm and AbsenceCode tables
alter table AbsenceForm
	add constraint fk_AbsenceForm_AbsenceCode foreign key(AbCodeID)
	references AbsenceCode(AbCodeID)
;


/* ****************************************************************** */
/* foreign key constrains to the OvertimesForm table  */
-- 1. Between OvertimesForm and Employees tables
alter table OvertimeForm
	add constraint fk_OvertimeForm_Employees foreign key(EmpID)
	references Employees(EmpID)
;


/* ****************************************************************** */
/* set the unique constraint(s)  */
alter table Employees
	add constraint uq_SIN_Employees unique (SIN)
    ;


/* ****************************************************************** */
/*   set the default constraint(s)  */
alter table OvertimeForm
	alter column Ratio
	set default 1.0
;

/* ****************************************************************** */
/*   set the check constraint(s) */

alter table AbsenceForm
	add constraint ck_AbStartDate_AbEndDate_AbsenceForm
	check (AbEndDate >= AbStartDate)
;

/* ****************************************************************** */

/*    
Foreign Key constraint in each table
Employees: 2
AbsenceForm: 1
OvertimesForm: 1
*/

select Count(*) as `Number of Foreign key Constraints`
from information_schema.TABLE_CONSTRAINTS
where
table_name = 'Employees'
and constraint_type = 'FOREIGN KEY'
;

select Count(*) as `Number of Foreign key Constraints`
from information_schema.TABLE_CONSTRAINTS
where
table_name = 'AbsenceForm'
and constraint_type = 'FOREIGN KEY'
;

select Count(*) as `Number of Foreign key Constraints`
from information_schema.TABLE_CONSTRAINTS
where
table_name = 'OvertimeForm'
and constraint_type = 'FOREIGN KEY'
;