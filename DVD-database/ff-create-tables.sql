/* Purpose: To create tables in the Flix database */

/*Scripts Date: January 22, 2021
Developed by: Fabiola Faria */

-- switch to the flix database
-- syntax: use database_name

use fcflix
;

/* Partial Syntax to create a table 
create table table_name
(
	column_name data_type constraint(s)
	column_name data_type constraint(s)
	...
	column_name data_type constraint(s)
)
;
where constraint defines the business rules: not null, null, primary key, ...
*/

/* ***** Table No. 1 - Customer ***** */

create table Customers
(
	-- column_name data_type constraint(s)
    -- to add an auto-generated-number, use auto-increment
    CustID smallint auto_increment not null primary key,
    CustFN varchar(20) not null,
    CustMN varchar(20) null,
    CustLN varchar(20) not null
    )
    ;

/* modify the middle name and set it to varchar(25) */
    
alter table Customers
	modify column CustMN varchar(25) null
    ;

/* show the definition (structure) of the table Customers */

show create table Customers
;

-- or using describe commmand
describe Customers
;

-- or using show columns
show columns from Customers
;

/* drop the table Customers and re-create it using  */
-- drop object_type object_name
drop table Customers
;

create table Customers
(
	-- column_name data_type constraint(s)
    CustID smallint auto_increment not null,
    CustFN varchar(20) not null,
    CustMN varchar(20) null,
    CustLN varchar(20) not null,
    -- constraint constraint_name constraint_type
    constraint pk_Customers primary key (CustID asc)
    )
    ;
    
    show columns from Customers
    ;
    
    drop table Customers
    ;
    
    create table Customers
(
	-- column_name data_type constraint(s)
    CustID smallint auto_increment not null,
    CustFN varchar(20) not null,
    CustMN varchar(20) null,
    CustLN varchar(20) not null,
    -- constraint constraint_name constraint_type
    constraint pk_Customers primary key (CustID asc)
    )
    ;
    
    -- create the lookup tables
    /* ***** Table No. 2 - Roles ***** */
    create table Roles
    (
		RoleID varchar(4) not null,
        RoleDescrip varchar(30),
        Constraint pk_Roles primary key (RoleID asc) 
    )
    ;

    /* ***** Table No. 3 - MovieTypes ***** */
    create table MovieTypes
    (
		MTypeID varchar(4) not null,
        MTypeDescrip varchar(30) not null,
        constraint pk_MovieTypes primary key clustered (MTypeID asc)
	)
	;
        
    
	/* ***** Table No. 4 - Studeios ***** */
    create table Studios
    (
		StudID varchar(4),
        StudDescrip varchar(40),
        constraint pk_Studios primary key clustered (StudID asc)
	)
    ;
       
    
    /* ***** Table No. 5 - Ratings ***** */
        create table Ratings
    (
		RatingID varchar(4) not null,
        RatingDescrip varchar(30) not null,
        constraint pk_Ratings primary key (RatingID asc)
	)
    ;
               
     
	/* ***** Table No. 6 - Formats ***** */
    create table Formats
    (
		FormID char(2) not null,
        FormDescrip varchar(15) not null, 
        constraint pk_Formats primary key (FormID asc)
	)
    ;
            
    
	/* ***** Table No. 7 - Status ***** */
    create table Status
    (
		StatID char(2) not null,
        StatDescrip varchar(20) not null, 
        constraint pk_Status primary key (StatID asc)
	)
    ;
    
    /* ***** fixing table status: change column ***** */
    /* alter table table_name
    change column `old_column_name` `new_column_name` data_type */
    
    alter table Status
	change column `StatID` `StatusID` char(3) not null
    ;
    
     alter table Status
	change column `StatID` `StatID` char(2) not null
    ;
    
	/* ***** Table No. 8 - Participants ***** */
     create table Participants
    (
		PartID smallint auto_increment not null,
        PartFN varchar(20) not null,
		PartMN varchar(20) not null,
        PartLN varchar(20) not null,
        RoleID varchar(20) not null, 
        constraint pk_Participants primary key clustered (PartID asc)
	)
    ;
    
    alter table Participants
	change column `PartMN` `PartMN` char(20)  null
    ;
    
    /* ***** remove RoleID from table Participants ***** */
        alter table Participants
	drop column RoleID
    ;
          
    
	/* ***** Table No. 9 - DVDs ***** */
    create table DVDs
    (
		DVDID smallint auto_increment not null,
        DVDName varchar(60) not null,
        NumDisks tinyint not null,
        YearRlsd year not null,
        MTypeID varchar(4) not null, -- Foreign Key (MovieTypes)
        StudID varchar(4) not null, -- Foreign Key (Studios)
        RatingID varchar(4) not null, -- Foreign Key (Ratings)
        FormID varchar(2) not null, -- Foreign Key (Formats)
        StatID varchar(3) not null, -- Foreign Key (Status)
        constraint pk_DVDs primary key clustered (DVDID asc)           
    )
    ;
    
    /* change the data type of the column YearRlsd to char(4) */
    alter table DVDs
    modify column YearRlsd char(4) not null
    ;
        
    /* ***** Table No. 10 - DVDPArticipants ***** */
    create table DVDParticipants
    (
		DVDID smallint not null,  -- Foreign Key (DVDs)
        PartID smallint not null, -- Foreign Key (Participants)
        RoleID varchar(4) not null, -- Foreign Key (Roles)
        constraint pk_DVDParticipants primary key
			(
				DVDID asc,
				PartID asc,
				RoleID asc
			) -- Composite Primary Key
    )
    ;
    
    /* return definition of table participants */
    describe DVDParticipants
    ;
           
    /* ***** Table No. 11 - Employees ***** */
    create table Employees
    (
		EmpID smallint auto_increment not null,
        EmpFN varchar(20) not null,
        EmpMN varchar(20) null,
        EmpLN varchar(20) not null,
        constraint pk_Employees primary key clustered (EmpID asc)
    )
    ;
        
    
    /* ***** Table No. 12 - Orders ***** */
    create table Orders
    (
		OrderID int auto_increment not null,
        CustID smallint not null, -- foreign key (Customers table)
        EmpID smallint not null, -- foreign key (Employees table)
        constraint pk_Orders primary key clustered (OrderID asc)
    )
    ;
    
            
    /* ***** Table No. 13 - Transactions ***** */
    create table Transactions
    (
		TransID int auto_increment not null,
        OrderID int not null, -- foreign key (Orders table)
        DVDID smallint not null, -- foreign key (DVDs table)
        DateOut date not null,
        DateDue date not null,
        DateIn date null,
        constraint pk_Transactions primary key clustered (TransID asc)
    )
    ;


	/* ************************************************* */
    create table Contacts
    (
    ContactID char(2) not null,
    FirstName varchar(15) not null,
    LastName varchar(15) not null,
    Phone varchar(20) not null,
    constraint pk_Contacts primary key (ContactID asc)
	)
	;
    
    /* In order to change the primary key, follow these tjree steps */
    -- 1. drop the primary key
    alter table Contacts
		drop primary key
        ;
    
    -- 2. modify the column that assigned to the primary key
    alter table Contacts
		modify ContactID char(5) not null
        ;
	
    -- 3. set back (re-create) the primary key
    alter table Contacts
		add constraint pk_Contacts primary key (ContactID asc)
        ;
    
    
    /* *********************************************************** */
    
    show tables 
    ;
    
    /* return the information about the base tables in my mySQL Server 
    syntax:
    select [all] column_name1, column_name2,...
    from object_name
    where condition
        */
    
    select *
    from information_schema.tables
    where table_schema = 'fcflix'
    and
    table_type = 'BASE TABLE'
    ;
    
    /* how many tables in fcflix database */
    select count(table_name) as `No. of Tables in fcflix database`
    from information_schema.tables
    where table_schema = 'fcflix'
    and
    table_type = 'BASE TABLE'
    ;
    
    /* return the  definition of table Customers
    */
    select *
    from information_schema.COLUMNS
    where table_name = 'Customers'
    ;
    
    
    /* rename a column:
    alter table table_name
		rename column old_column_name TO new_column_name
	
    modify column
    alter table table_name
		change old_column_name new_column_name data type
    */
    
