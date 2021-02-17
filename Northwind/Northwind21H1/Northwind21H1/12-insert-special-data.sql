/* 
Purpose: insert special data
Script Date: February 15th, 2021
Developed by Fabiola Faria
*/

/*
Add a statement that specifies the script runs in the context of the master databse
*/
use Northwind21H1
;
go 

CREATE TABLE Sales.Shippers2
(
	ShipperID int IDENTITY(1,1) NOT NULL, -- auto-generated number
	CompanyName nvarchar(40) NOT NULL, -- Name of the shipping company
	Phone nvarchar(24) NOT NULL, -- Phone number includes country code and /or area code
	PostalCode nchar(7) null,
	CONSTRAINT pk_Shippers2 PRIMARY KEY CLUSTERED 
	(
		ShipperID ASC
	)
)
;
go

/* 1. insert data into shuppers2 */
insert into Sales.Shippers2 (CompanyName, Phone, PostalCode)
values (upper('Green Food'), '(514) 555-1234', upper('H4E 3T3') )
;
go


/* 2. import from an external data source */
bulk insert Sales.Shippers2
from 'I:\data_sources\Shippers2.txt'
with 
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ',',
	FIRE_TRIGGERS
)
;
go



/* updat2 Shippers2 - set the company name and postal code to upper case */
update Sales.Shippers2
set CompanyName = upper(CompanyName)
;
go

/* create a check constraint oh the phone number */
alter table Sales.Shippers2
	with check
	add constraint ck_Phone_Shippers2 check
	(Phone like
		'(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
	or Phone like 
		'(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
)
;
go



/* insert a new row into shippers2 */
insert into Sales.Shippers2 (CompanyName, Phone, PostalCode)
values (upper('Live is Foods'), '(514) 555-1234', upper('h4e 3t3') )
;
go

select *
from Sales.Shippers2
;
go


/* create a trigger, Sales.toUpperCaseTr, that changes the lower case characters to upper case */
create trigger Sales.toUpperCaseTr
on Sales.Shippers2
after insert, update
as
	begin
		update Sales.Shippers2
		set PostalCode = upper(PostalCode)
		where ShipperID in ( select ShipperID from inserted)
	end
;
go

insert into Sales.Shippers2 (CompanyName, Phone, PostalCode)
values ('Green Food', '(514) 555-1234', 'h4e 3t3' )
;
go


update Sales.Shippers2
set PostalCode = 'h4e 3b7'
where ShipperID = 3
;
go


