/* 
Purpose: create schema object in the database Northwind
Script Date: February 8th, 2021
Developed by Fabiola Faria
*/

/*
Add a statement that specifies the script runs in the context of the master databse
*/

-- swictch to the master database
-- use database_name
use Northwind21H1
;
go

/* create contacts table */
/*dro the table if exists*/

if OBJECT_ID('Person.Contacts', 'U') is not null
	drop table Person.Contacts

create table Person.Contacts
(
	-- using uniqueidentifires and newID() function
	contactID uniqueIdentifier not null default newID(),
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	SocialNumber SocialInsuranceNo,
	Address BusinessAddress null,
	Region RegionCode null
)
; 
go

/* return information about the Person.Contacts */
execute sp_help 'Person.Contacs'
;
go

-- insert a new record into the table Person.Contacts
insert into Person.Contacts (FisrtName, LastName, SocialNumber)
values ('John', 'Smith', '123-456-789')
;
go

-- insert a new record into the table Person.Contacts
insert into Person.Contacts (FisrtName, LastName, SocialNumber)
values ('John', 'Smith', '123-456-789')
;
go
