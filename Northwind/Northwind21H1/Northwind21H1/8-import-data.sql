/* Import data in Northwind21H1 Database 
Script Date: February 11, 2021
Developed by: Fabiola Faria
*/

use Northwind21H1
;
go -- include end of batch markers (go statement)

/* 1. using insert clause
insert [into] schema_name.table_name [(column_name1, column_name2, ...)
values (value1, value2, ...)
;
go
*/
insert into HumanResources.Employees (FirstName, LastName, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone)
values ('John', 'Smith', '5/21/1999', '8/12/2018', 'some address', 'some city', 'some region', 'zipcode', 'some country', '(555) 555-5555')
;
go
/* add a new column named Email into table Employees */

alter table HumanResources.Employees
	add Email nvarchar(60) null
;
go

select *
from HumanResources.Employees
;
go

/* upodate email addess for employee id no 1 */
/*Syntax:
Update schema_name.table_name
set column_name = expression
where (Condition)
*/

update HumanResources.Employees
set Email = 'johnsmith@gmail.com'
where EmployeeID = 1
;
go

/* 2. Using insert clause from another table
Syntax:
insert [into] schema_name.table_name [column_name1, column_name2, ...)]
select (column_name1, column_name2, ...)
from schema_name.table_name
*/

insert into Sales.Customers (
CustomerID, CompanyName, Address, City, Region, PostalCode, Country, Phone, Email)
values
('Arout', 'Around the HOern', '120 Name street', 'London', 'region', 'WA11DP', 'UK', '(171) 555-5555', 'INFO@AROUT.CO.UK'),
('Blonp', 'Blondel pere et fils', '24, place kleber', 'Strasbourg', 'N/A', 'Wb2c1P', 'France', '88.60.15.31', 'info@blonp.fr'),
('Bonap', 'Bon app', '12, some street', 'Marseille', 'N/A', '13008', 'France', '91.24.15.40', 'info@bonapp.fr')
;
go

select *
from Sales.Customers
;
go

/* 2. Using insert clause from another table
Syntax:
insert [into] schema_name.table_name [column_name1, column_name2, ...)]
select (column_name1, column_name2, ...)
from schema_name.table_name
*/

insert into Production.Suppliers (
CompanyName, Address, City, Region, PostalCode, Country, Phone, Email)
select CompanyName, Address, City, Region, PostalCode, Country, Phone, Email
from Sales.Customers
;
go

/* 3. Using Bulk insert clause
Syntax:
bulk insert schema_name.table_name
from 'path/filename.ext'
with
(
	FirstRow = number_of_first_row,
	RowTerminator = '\n',
	FieldTerminator = ','
)
*/


bulk insert Sales.Shippers
from 'C:\Users\15144\Documents\john-abbott-2\8-database\databases\IPD-Database\Northwind\Northwind21H1\Northwind21H1\Shippers.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go


select *
from Sales.Shippers
;
go

