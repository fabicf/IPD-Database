/*
Purpose: create schema object in the database Northwind
Script Date: February 5th, 2021
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

/* Partial Syntax
create type [schema_name].type_name
from system_data_type
*/

/* create BusinessAddress data type */
create type BusinessAddress
from nvarchar(40) not null
;
go

/* create RegionCode (State or province) data type */
create type dbo.RegionCode
from nchar(2) null
;
go

/* create Social Insurance Number data type */
create type SocialInsuranceNo
from nchar(11) not null
;
go

/* create Contacts table */
create table Person.Contacts 
(
	ContactID nchar(5),
	FirstName nvarchar(15) not null,
	LastName nvarchar(15) not null,
	SocialNumber SocialInsuranceNo,
	Address BusinessAddress,
	Region RegionCode
)
;
go

drop type RegionCode;


/* return the definition of Contacts table */
execute sp_help 'Contacts'
;
go



