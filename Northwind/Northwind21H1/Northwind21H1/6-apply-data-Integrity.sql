/* Apply Data Integrity to Tables in Northwind21H1 Database 
Script Date: February 9, 2021
Developed by: Fabiola Faria
*/

use Northwind21H1
;
go -- include end of batch markers (go statement)


/* Integrity Types:
	1. Domain (column)
	2. Entity (row)
	3. Referential (between two columns or tables)

   Constraint Types:
   1. Primary Key (pk_)
		alter table schema_name.table_name
			add constraint pk_table_name primary key clustered (column_name asc)

   2. Foreign key (fk_)
		alter table schema_name.table_name
			add constraint fk_first_table_name_second_table_name foreign key (fk_column_name) references second_table_name (pk_column_name)

   3. Default (df_)
		alter table schema_name.table_name
			add constraint df_column_name_table_name default (value) for column_name

   4. Check (ck_)
		alter table schema_name.table_name
			add constraint ck_column_name_table_name check (condition)

   5. Unique (uq_)
	alter table schema_name.table_name
			add constraint uq_column_name_table_name unique (column_name)
*/


/***** Table No. 1 - Sales.Customers *****/
-- No extra constraints (only one primary key)


/***** Table No. 2 - Sales.Orders *****/

-- Foreign key constraints
/* 1) Between Sales.Orders and Sales.Customers */
alter table Sales.Orders
	add constraint fk_Orders_Customers foreign key (CustomerID)
	references Sales.Customers (CustomerID)
;
go


/* 2) Between Sales.Orders and Sales.Shippers */
alter table Sales.Orders
	add constraint fk_Orders_Shippers foreign key (ShipVia)
	references Sales.Shippers (ShipperID)
;
go

/* 3) Between Sales.Orders and HumanResources.Employees*/
alter table Sales.Orders
	add constraint fk_Orders_Employees foreign key (EmployeeID)
	references HumanResources.Employees (EmployeeID)
;
go


-- Default constraints (set Freight column value to zero)
alter table Sales.Orders
	add constraint df_Freight_Orders default (0) for Freight
;
go


/***** Table No. 3 - Sales.[Order Details] *****/
-- Foreign key constraints

/* 1) Between Sales.[Order Details] and Sales.Orders */
alter table Sales.[Order Details]
	add constraint fk_OrderDetails_Orders foreign key (OrderID)
	references Sales.Orders (OrderID)
;
go


/* 2) Between Sales.[Order Details] and Production.Products*/
alter table Sales.[Order Details]
	add constraint fk_OrderDetails_Products foreign key (ProductID)
	references Production.Products (ProductID)
;
go


-- Default constraints
/* set the default constraint value to 0 for UnitPrice and Discount, and 1 for Quantity column */

-- 1. set the default constraint value to 0 for UnitPrice
alter table Sales.[Order Details]
	add constraint df_UnitPrice_OrdersDetails default (0) for UnitPrice
;
go

-- 2. set the default constraint value to 0 for Discount
alter table Sales.[Order Details]
	add constraint df_Discount_OrdersDetails default (0) for Discount
;
go

-- 3. set the default constraint value to 1 for Quantity
alter table Sales.[Order Details]
	add constraint df_Quantity_OrdersDetails default (1) for Quantity
;
go


/***** Table No. 4 - Production.Products *****/

-- Foreign key constraints
/* 1) Between Production.Products and Production.Suppliers*/
alter table Production.Products
	add constraint fk_Products_Suppliers foreign key (SupplierID)
	references Production.Suppliers (SupplierID)
;
go


/* 2) Between Production.Products and Production.Categories */
alter table Production.Products
	add constraint fk_Products_Categories foreign key (CategoryID)
	references Production.Categories (CategoryID)
;
go


-- Default constraints
/* set the default value to 0 for: UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, and Discontinued columns in Production.Products*/

-- 1. set the default constraint value to 0 for UnitPrice
alter table Production.Products
	add constraint df_UnitPrice_Products default (0) for UnitPrice
;
go

-- 2. set the default constraint value to 0 for UnitsInStock
alter table Production.Products
	add constraint df_UnitsInStock_Products default (0) for UnitsInStock
;
go

-- 3. set the default constraint value to 0 for UnitsOnOrder
alter table Production.Products
	add constraint df_UnitsOnOrder_Products default (0) for UnitsOnOrder
;
go

-- 4. set the default constraint value to 0 for ReorderLevel
alter table Production.Products
	add constraint df_ReorderLevel_Products default (0) for ReorderLevel
;
go

-- 5. set the default constraint value to 0 for Discontinued
alter table Production.Products
	add constraint df_Discontinued_Products default (0) for Discontinued
;
go

-- Check constraint 
/* check that the following column values in the Products table must be >= 0: UnitPrice, ReorderLevel, UnitsInStock, UnitsOnOrder */

-- 1. check that UnitPrice >= 0
alter table Production.Products
	add constraint ck_UnitPrice_Products check (UnitPrice >= 0)
;
go


-- 2. check that UnitsInStock >= 0
alter table Production.Products
	add constraint ck_UnitsInStock_Products check (UnitsInStock >= 0)
;
go

-- 3. check that UnitsOnOrder >= 0
alter table Production.Products
	add constraint ck_UnitsOnOrder_Products check (UnitsOnOrder >= 0)
;
go

-- 4. check that ReorderLevel >= 0
alter table Production.Products
	add constraint ck_ReorderLevel_Products check (ReorderLevel >= 0)
;
go

/* set the ProductName to be unique in the Production.Products table */
alter table Production.Products
-- add constraint un_name unique (Column_name)
	add constraint uq_ProductName_Products unique (ProductName)
;
go



/***** Table No. 5 - Production.Suppliers *****/
-- No extra constraints (only one primary key)

/***** Table No. 6 - Production.Categories *****/
-- No extra constraints (only one primary key)

/***** Table No. 7 - Sales.Shippers *****/
-- No extra constraints (only one primary key)

/***** Table No. 8 - HumanResources.Employees  *****/
-- Foreign key between Employees.EmployeeID and Employees.ReportsTo 
alter table HumanResources.Employees
	add constraint fk_Employees_Employees foreign key (ReportsTo)
	references HumanResources.Employees (EmployeeID)
;
go

-- Check Birth Date to be less than current date
alter table HumanResources.Employees
	add constraint ck_BirthDate_Employees check (BirthDate < getDate())
;
go


/***** Table No. 9 - HumanResources.Region  *****/
-- No extra constraints (only one primary key)

/***** Table No. 10 - HumanResources.Territories  *****/
-- Foreign key constraints
/* Between HumanResources.Territories and HumanResources.Region*/
alter table HumanResources.Territories
	add constraint fk_Territories_Region foreign key (RegionID)
	references HumanResources.Region (RegionID)
;
go

/***** Table No. 11 - HumanResources.EmployeeTerritories  *****/
-- Foreign key constraints
/* 1) Between HumanResources.EmployeeTerritories and HumanResources.Employees*/
alter table HumanResources.EmployeeTerritories
	add constraint fk_EmployeeTerritories_Employees foreign key (EmployeeID)
	references HumanResources.Employees (EmployeeID)
;
go

/* 2) Between HumanResources.EmployeeTerritories and HumanResources.Territories*/
alter table HumanResources.EmployeeTerritories
	add constraint fk_EmployeeTerritories_Territories foreign key (TerritoryID)
	references HumanResources.Territories (TerritoryID)
;
go

/***** Table No. 12 - Sales.CustomerCustomerDemo  *****/

-- Foreign key constraints
/* 1) Between Sales.CustomerCustomerDemo and Sales.CustomerDemographics */
alter table Sales.CustomerCustomerDemo
	add constraint fk_CustomerCustomerDemo_CustomerDemographics foreign key (CustomerTypeID)
	references Sales.CustomerDemographics (CustomerTypeID)
;
go

/* 2) Between Sales.CustomerCustomerDemo and Sales.Customers */
alter table Sales.CustomerCustomerDemo
	add constraint fk_CustomerCustomerDemo_Customers foreign key (CustomerID)
	references Sales.Customers (CustomerID)
;
go


/***** Table No. 13 - Sales.CustomerDemographics  *****/
-- No extra constraints (only one primary key)




-- ===============================================================
/* transfer table from one schema to another schema */
-- alter schema to_Schema_name TRANSFER from_schema_name.table.name

/* i.e.
alter schema Person transfer dbo.Contacts
;
*/


