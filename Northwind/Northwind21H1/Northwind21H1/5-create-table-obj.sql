/* 
Purpose: create database Northwind backu[p
Script Date: February 8th, 2021
Developed by Fabiola Faria
*/

/*
Add a statement that specifies the script runs in the context of the master databse
*/

-- swictch to the master database
-- use database_name
select *
from sys.all_objects;
go

/* ******** Table No. 1 - Sales.Customers ********** */
if OBJECT_ID('Sales.Customeres', 'U') is not null
drop table Sales.Customers
;
go

create table Sales.Customers
(
	-- solumn_name data_type constraint_type
	CustomerID nchar(5) not null,  -- based on customer name
	CompanyName nvarchar(40)not null,
	ContactName nvarchar(30) null,
	ContactTitle nvarchar(30) null,
	Address nvarchar(60) not null, -- street number and street name
	City nvarchar(15) not null,
	Region nvarchar(15) not null, -- province or state 
	PostalCode nvarchar(10) not null,
	Country nvarchar(15) not null,
	Phone nvarchar(24) not null, -- phone number includes country code and / or area code
	Fax nvarchar(24) null,
	HomePage nvarchar(60) null, -- Customer URL
	Email nvarchar(60) not null, 
	-- constraint constraint_name constraint_type
	constraint pk_Customers primary key clustered (CustomerID asc)
)
;
go

/* retun the definition of the database */
execute sp_helpdb 'Northwind21h1'
;
go

/* return the definition of the sAles.Customers table */
exec sp_help 'Sales.Customers'
;
go


/* ******** Table No. 2 - Sales.Orders ********** */
if OBJECT_ID('Sales.Orders', 'U') is not null
drop table Sales.Orders
;
go


create table Sales.Orders
(
	OrderID int identity (1,1) not null, -- auto-generated number assigned to a new order
	CustomerID nchar(5) not null, -- foreign key (CustomerID in Sales.Customers)
	EmployeeID int not null, -- foreign key (EmployeeID in HumanResources.Emplouyees)
	OrderDate datetime not null,
	RequiredDate datetime not null,
	ShippedDate datetime null,
	ShipVia int null, -- foreign keu (Shipper ID in SAles.Shippers)
	Freight money null,
	ShipName nvarchar(40) null,
	ShippAddress nvarchar(60) null,
	ShipCity nvarchar(15) null,
	ShipRegion nvarchar(15) null,
	ShipPOstalCode nvarchar(10) null,
	ShipCountry nvarchar(15) null,
	constraint pk_Orders primary key clustered (OrderID) 
)
;
go

/* ******** Table No. 3 - Production ********** */
create table Production.Products
(
	ProductID int identity(1,1) not null,
	ProductName nvarchar(40) not null,
	SupplierID int not null, -- FK
	CategoryID int not null, -- FK
	QuantityPerUnit nvarchar(20) null,
	UnitPrice money null,
	UnitsInStock smallint null,
	UnitsOnOrder smallint null,
	ReorderLevel smallint null,
	Discontinued bit not null,
	Constraint pk_Products primary key clustered
	(
		ProductID asc
	)
)
;
go


/* ******** Table No. 4 - OrderDetails ********** */
create table Sales.[Order Details]
(
	OrderID int not null, -- FK OrderID in Sales.Orders
	ProductID int not null, -- FK ProductiID in Production.Products
	UnitPrice smallmoney not null,
	Quantity smallint not null, 
	Discount real not null,
	constraint pk_Order_Details primary key clustered
		(	-- composity PK
			OrderID asc,
			ProductID asc
		)
)
;
go



/* ******** Table No. 5 - Production.Supplier ********** */
create table Production.Suppliers
(
	SupplierID int identity(1,1) not null, --  auto-generated no assigned to a new supplier
	CompanyName nvarchar(40) not null, 
	ContactName nvarchar(30) null,
	ContactTitle nvarchar(30) null,
	Address nvarchar(60) not null, -- street number and street name
	City nvarchar(15) not null,
	Region nvarchar(15) not null, -- province or state 
	PostalCode nvarchar(10) not null,
	Country nvarchar(15) not null,
	Phone nvarchar(24) not null, -- phone number includes country code and / or area code
	Fax nvarchar(24) null,
	HomePage nvarchar(60) null, -- Customer URL
	Email nvarchar(60) not null,
	constraint pk_Suppliers primary key clustered
	(
		SupplierID asc
	)
)
;
go

/* ******** Table No. 6 - Production.Categories ********** */
create table Production.Categories
(
	CategoryID int identity(1,1) not null,
	CategoryName nvarchar(15) not null,
	Description nvarchar(250) null,
	Picture varbinary(max) null, -- picture representingthe  food category
	constraint pk_Categories primary key clustered
	(
		CategoryID asc
	)
)
;
go


/* ******** Table No. 7 - Sales.Shippers ********** */
create table Sales.Shippers
(
	ShipperID int identity(1,1) not null,
	CompanyName nvarchar(40) not null,
	Phone nvarchar(24) not null,
	constraint pk_Shippers primary key clustered
	(
		ShipperID asc
	)
)
;
go


/* ******** Table No. 8 - HumanResources.Employees ********** */
create table HumanResources.Employees
(
	EmployeeID int identity(1,1) not null,
	LastName nvarchar(20) not null,
	FirstName nvarchar(10) not null,
	Title nvarchar(30) not null,
	TitleOfCourtesy nvarchar(25) null,
	BirthDate datetime not null,
	HireDate datetime not null,
	Address nvarchar(60) not null, -- street number and street name
	City nvarchar(15) not null,
	Region nvarchar(15) not null, -- province or state 
	PostalCode nvarchar(10) not null,
	Country nvarchar(15) not null,
	HomePhone nvarchar(24) not null,
	Extension nvarchar(4) null,
	Photo varbinary(max) null,
	Notes nvarchar(250) null,
	ReportsTo int null, -- FK to the same EMployees table
	DepartmentID smallint null, -- FK key (DepartmentID in Departments)
	constraint pk_Employees primary key clustered 
	(
		EmployeeID asc
	)
)
;
go


/* ******** Table No. 9 - HumanResources.Region ********** */
create table HumanResources.Region
(
	RegionID int not null,
	RegionDescription nvarchar(50) not null,
	constraint pk_Region primary key clustered (RegionID asc)
)
;
go

/* ******** Table No. 10 - HumanResources.Territories ********** */
create table HumanResources.Territories
(
	TerritoryID nchar(2) not null,
	TerritoryDescription nvarchar(50) not null,
	RegionID int not null, -- FK RegionID in HUmanResources.Region
	constraint pk_Territory primary key clustered (TerritoryID asc)
)
;
go





/* ******** Table No. 11 - HumanResources.EmployeeTerritories ********** */
create table HumanResources.EmployeeTerritories
(
	EmployeeID int not null, -- FK eMPLOYEE
	TerritoryID nchar(2) not null, -- FK
	constraint pk_EmployeeTerritory primary key clustered 
		(
		EmployeeID asc,
		TerritoryID asc
		)
)
;

/* ******** Table No. 12 - Sales.CustomerCustomerDemo ********** */
create table Sales.CustomerCustomerDemo
(
	CustomerID nchar(5) not null, -- FK
	CustomerTypeID nvarchar(10) not null,
	constraint pk_CustomerCustomerDemo primary key clustered
		(
			CustomerID asc,
			CustomerTypeID asc
		)
)
;
go

/* ******** Table No. 13 - Sales.CustomerDemographics ********** */
create table Sales.CustomerDemographics
(
	CustomerTypeID nvarchar(10) not null,
	CustomerDescription nvarchar(250) not null,
	constraint pk_CustomerDemographics primary key clustered
		(
			CustomerTypeID asc
		)
)
;
go

/* display used-defined and system tables */

-- in Schema Production
execute sp_tables
@table_Owner = 'Production',
@table_qualifier = 'Northwind21H1'
;
go

-- in Schema HumanResources
execute sp_tables
@table_Owner = 'HumanResources',
@table_qualifier = 'Northwind21H1'
;
go

-- in Schema Sales
execute sp_tables
@table_Owner = 'Sales',
@table_qualifier = 'Northwind21H1'
;
go

-- in Schema Person
execute sp_tables
@table_Owner = 'Person',
@table_qualifier = 'Northwind21H1'
;
go