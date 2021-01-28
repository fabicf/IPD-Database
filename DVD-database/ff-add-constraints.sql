/* Purpose: Insert Data into tables in the KDFlix2020 database  
 	Script Date: January 27, 2021
    Developed By: Fabiola Faria
*/

use fcflix
;

/* 
How to drop constraints in MySQL

1. Remove the primary key constraint
alter table table_name
	drop primary key
;

2. Remove the foreign key constraint
alter table table_name
	drop foreign key foreign_key_name
;

3. Remove unique consraint
alter table table_name
	drop index uq_constraint_name
;

4. Remove the default constraint
alter table table_name
	alter column_name drop default
;

5. Remove the check constraint
alter table table_name
		drop check ck_constraint_name
;

*/

create table Contacts
(
	-- column_name data_type constraint(s)
    ContactID smallint not null auto_increment,
    FirstName varchar(20) not null,
    LastName varchar(20) not null,
    City varchar(20) not null,
    SIN char(11) null,
    ModifiedDate datetime null,
    constraint pk_Contacts primary key (ContactID asc)
)
;

/* add Montreal as default  city for contacts */
alter table Contacts
	alter column City
    set default 'Montreal'
;

show columns from Contacts
;

/* set the unique constraint to SIN column */
alter table Contacts
	 add constraint  uq_SIN_Contacts unique (SIN)
;

 /* set a check constraint to the Modified Date */
alter table Contacts
	add constraint ck_ModifiedDate_Contacts check  (ModifiedDate >= current_date() )
;   

insert into Contacts (FirstName, LastName, City, SIN)
values ('John', 'Smith', 'Laval', '123 456 789')
;












