/* Apply Data Integrity to Tables in Northwind21H1 Database 
Script Date: February 10, 2021
Developed by: Fabiola Faria
*/

use Northwind21H1
;
go -- include end of batch markers (go statement)

/* syntax: 
1. Create a non-clusteredin a table
create nonclustered index index_name on table_name (Column_name)


2. create a clustered index on a table
create clustered index index_name on table_name (Column_name)

*/

execute sp_helpindex 'Sales.Customer'


/* using the system index tables */
select*
from sys.indexes;
go

select name, -- name of the index. Name is unique
index_id, -- the ID of the index: 0 --> heap, 1 --> clustered, >1 --> nonclustered index
type, -- type of index 0 --> heap, 1 --> clustered, 2 --> nonclustered, 3 --> xml, 4 --> spatial
type_desc, -- description of the index
is_unique, -- 1--> index is unique, 0 --> index is not unique
is_primary_key  -- 1 --> index is a part of the primary key
from sys.indexes
where object_id = Object_ID('Sales.Customer')
;
go

/*
check if indexes exist in the humanresources.employees taqble
*/

execute sp_helpindex 'HumanResources.Employees'
;
go

/* create a nonclustered index, (ncl_LastName) on the employee last name */
create nonclustered index ncl_lastName on HumanResources.Employees (LastName)
; 
go

/* remove the index ncl_laste name from the HumanResources.Employees table */
drop index HumanResources.Employees.ncl_lastName
;
go

/* add a unique nonclustered index uq_ncl_ProductName on the table Production.Products */
create unique nonclustered index uq_ncl_ProductName on Production.Products (ProductName)
;
go

execute sp_helpindex 'Production.Products'
;
go

/*drop index uq_ncl_ProductName on Production.Products */
drop index Production.Products.uq_ncl_ProductName
;
go