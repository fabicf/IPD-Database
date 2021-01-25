/* Apply data integrity to tables in the flix database */

/* Script Date: January 25, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/* Constraint Types:
1) Primary key --> pk_table_name (pk_Customers)
2) Foreign Key -->

	alter table table_name
		add constraint constraint_name foreign key (column_name)
        references table_name (primary_key_column)
        
        where constraint _name:
	a) between 2 tables: fk_table_name_a_table_name_2 (fk_Orders_Customers)
    b) between 2 columns: within the same table:
		fk_table_name_1_column_name_1_column_name_2 (fk_Employees_EmployeeID_reportsTo)

3) Unique --> uq_column_name_tyable_name (uq_companyName_Suppliers)
4) Default --> df_column_name_table_name (df_City_Employees)

5) Check --> 
	a) ck_column_name_table_name --> ck_Quantity_orders (condition)
    b) ck_column_name_1_column_name_2_table_name --> ck_DateDue_DateOut_Transactions (condition) (DateDue >= DateOut)
*/

/* add a primary key constraint to an existing table 
alter table table_name
	add constraint pk_table_name primary key [clustered] (column_name [asc])
*/

create table Suppliers
(
	SupplierID smallint not null,
    CompanyName varchar(40) not null,
    Phone varchar(15) not null
)
;

-- add a primary key constraint to the table SUppliers
alter table Suppliers
	add constraint pk_Suppliers primary key (SupplierID asc)
;

/* modify table:
1. change the column name
2. change the data type
3. change the column size
4. add a new column
5. drop an existing column
6. add constraint(s)
7. drop constraints(s)
*/

/* add foreign key constraint(s) to the DVD table */

/* Foreign Key -->

	alter table table_name
		add constraint constraint_name foreign key (column_name)
        references table_name (primary_key_column)*/

/* 1. between DVDs and MovieType tables */
alter table DVDs
	add constraint fk_DVDs_MovieTypes foreign key (MTypeID) references MovieTypes (MTypeID)
;


/* 2. between DVDs and Studio tables */
alter table DVDs
	add constraint fk_DVDs_StudioID foreign key (StudID) references Studios (StudID)
;

/* 3. between DVDs and Ratings tables */
alter table DVDs
	add constraint fk_DVDs_RatingID foreign key (RatingID) references Ratings (RatingID)
;

/* 4. between DVDs and Formats tables */
alter table DVDs
	add constraint fk_DVDs_Format foreign key (FormID) references Formats (FormID)
;

/* 5. between DVDs and Status tables */
alter table DVDs
	add constraint fk_DVDs_Status foreign key (StatID) references Status (StatID)
;


/* ********************************************************** */

/* Add foreign key constraint(s) to the table DVDParticipants */

/* 1. between DVDParticipants and DVD tables */
alter table DVDParticipants
	add constraint fk_DVDParticipants_DVDID foreign key (DVDID) references DVDs (DVDID)
;

/* 2. between DVDParticipants and Participants tables */
alter table DVDParticipants
	add constraint fk_DVDParticipants_PartID foreign key (PartID) references Participants (PartID)
;

/* 3. between DVDParticipants and Roles tables */
alter table DVDParticipants
	add constraint fk_DVDParticipants_RoleID foreign key (RoleID) references Roles (RoleID)
;

/* ********************************************************** */

/* Add foreign key constraint(s) to the table Orders */

/* 1. between Orders and Customers tables */
alter table Orders
	add constraint fk_Orders_CustID foreign key (CustID) references Customers (CustID)
;

/* 2. between Orders and EMployees tables */
alter table Orders
	add constraint fk_OrdersEmpID foreign key (EmpID) references Employees (EmpID)
;

/* ********************************************************** */

/* Add foreign key constraint(s) to the Transactions table */

/* 1. between Transactions and Orders tables */
alter table Transactions
	add constraint fk_Transactions_OrderID foreign key (OrderID) references Orders (OrderID)
;

/* 2. between Transactions and DVDs tables */
alter table Transactions
	add constraint fk_Transactions_DVDID foreign key (DVDID) references DVDs (DVDID)
;




/* ********************************************************** */

-- set the default constraint(s)

-- set the DVD name to be unique
alter table DVDs
	-- constraint constraint_name constraint_type
	add constraint uq_DVDname_DVDs unique (DVDName)
;

/* return the DVDs table definition */
show columns from DVDs
;

describe DVDs
;

 /* return the  definition of table DVDs
*/
select *
from information_schema.COLUMNS
where table_name = 'DVDs'
;


/* set the default value of the NumDisks column in the table DVDs to One */
-- Default --> df_column_name_table_name (df_City_Employees)

alter table DVDs
	alter column NumDisks 
	set default 1
;




/* ********************************************************** */

-- set the check constraint(s) to the Transactions table on Date Due to be greater than or equal to Date Out
alter table transactions
	add constraint ck_DateDue_DateOut_Transactions 
		check (DateDue >= DateOut)
        ;
    
describe transactions
;

show create table transactions
;



/* ********************************************************** */
/* return foreign key contraint(s) in table DVDs */
select *
from information_schema.TABLE_CONSTRAINTS
where 
	table_name = 'DVDs'
    and constraint_type = 'foreign key'
    ;
    
-- count foreign key constraints
select count(*) as `Number of Foreign Key Constraints`
from information_schema.TABLE_CONSTRAINTS
where 
	table_name = 'DVDs'
    and constraint_type = 'FOREIGN KEY'
    ;

    
/* Foreign key constraints in each table
DVDParticipants: 3
DVDs: 5
Orders: 2
Transactions: 2s
*/
