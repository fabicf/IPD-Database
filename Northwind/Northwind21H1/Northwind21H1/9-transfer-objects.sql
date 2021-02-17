/* transfer objects from one to another scheme - after backup - Northwind21H1 Database 
Script Date: February 11, 2021
Developed by: Fabiola Faria
*/

use Northwind21H1
;
go

-- Customers
alter schema  Sales transfer dbo.Customers
;
go

-- Orders
alter schema Sales transfer dbo.Orders
;
go

-- Order Details
alter schema Sales transfer dbo.[Order Details]
;
go

-- Shippers
alter schema Sales transfer dbo.Shippers
;
go

-- CustomerCustomerDemo
alter schema Sales transfer dbo.CustomerCustomerDemo
;
go

-- CustomerDemographics
alter schema Sales transfer dbo.CustomerDemographics
;
go


-- Products
alter schema Production transfer dbo.Products
;
go

-- Suppliers
alter schema Production transfer dbo.Suppliers
;
go

-- Categories
alter schema Production transfer dbo.Categories
;
go

-- Employees
alter schema HumanResources transfer dbo.Employees
;
go

-- Region
alter schema HumanResources transfer dbo.Region
;
go


-- Territories
alter schema HumanResources transfer dbo.Territories
;
go

-- EmployeeTerritories
alter schema HumanResources transfer dbo.EmployeeTerritories
;
go