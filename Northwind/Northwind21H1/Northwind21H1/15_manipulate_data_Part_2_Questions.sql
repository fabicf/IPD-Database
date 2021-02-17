/* Manipulate data in the Northwind database 
Script Date: February 15, 2021
Developed by: Fabiola Faria
*/

/* add a statement that specifies the script runs in the context of the master database */

-- switch to Northwind database 
use NorthWind21H1
;
go -- include end of batch markers (go statement)

/* Partial syntax:
select <select_list< [ into new_table]
[From object_name]
[Where search_condition]
[Group by group_by_condition]
[Having search_condition]
[Order by oreder_expression [asc] | [desc] ]
*/

/* 
1) Read the question
2) find the object(s) - table or a view that answer your question
3) list the column(s) - fields from each object
4) define the criteria(s) 
5) run one criteria after another
*/

/* Example 11
Suppose that you want to select a list of countries where Northwind suppliers are located. Create this view and save it as vDistinctSuppliersCountry. 
*/

-- ====================================
create view Production.vDistinctSuppliersCountry
as
select CompanyName as 'Company Name', Country
from Production.Suppliers
;
go


/* Example 12
Suppose you remember that a customer's company name starts with "The", but you can't remember the rest of the name. Find all the company names starting with "The". Create this view and save it as 12_vCompanyNameStartingWithThe.
*/
create view Sales.vCompanyNameStartingWithThe
as
select CompanyName
from Sales.Customers
where CompanyName like ('The%')
;
go


/* Example 13
Create a view that returns the employee id, employee full name, full address, home phone, and extension. Save this view as 13_vEmployeeFullName.
*/
create view HumanResources.vEmployeeFullName
as
select EmployeeID as 'Employee ID', concat(FirstName, ' ', LastName) as 'Employee Name',
	concat_ws(' ', Address, City, Region, Country, PostalCode) as 'Full Address',
	HomePhone as 'Home_Phone',
	Extension as 'Extension'
from HumanResources.Employees
;
go

/*
calculated_field_name:expression
EmployeeName:[First Name] & " " & [LastName] as "Employee"

Example 14
Suppose you want to find out what all your confection products (CategoryID = 3) would cost if you raised price by 25 percent. Add a calculated field and name it NewPrice. Create this view and save it as 14_vNewPriceForConfectionProducts. 
*/
create view Production.vNewPriceForConfectionProducts
as
select UnitPrice as 'Unit Price', (UnitPrice+(UnitPrice*0.25)) as 'New Price'
from Production.Products
where CategoryID = 3
;
go


/* Example 15
Suppose you want to calculate the total number of Northwind products. Create this view and save it as 15_vTotalNumberOfProducts. 
*/ 
create view Production.vTotalNumberOfProducts
as
select count(ProductID) as 'Products Count'
from Production.Products
;
go


/* Example 16
Suppose you want to find the total number of product ordered that come from each supplier (company name). Create this view and save it as 16_vTotalNumberOfProductsFromEachSupplier. 
*/ 
create view Sales.vTotalNumberOfProductsFromEachSupplier
as
select count(ProductID)
from Sales.Customers
group by CompanyName
;
go

/* Example 17
How many products each category (category Name) contains. Create this view and save it as 17_vTotalNumberOfProductsPerCategory.
*/

create view v17_TotalNumberOfProductsPerCategory
as
select count(ProductName) as 'Product Name'
from Production.Products as P
inner join Production.Categories as PC
on P.CategoryID = PC.CategoryID
group by PC.CategoryName
;
go

/* Example 18
What is the perecentage of UnitsInStock comparing to UnitsOnOrder. Create this view and save it as 18_vUnitPercentage.
*/
create view v18_UnitPercentage
as
select (UnitsOnOrder * 100 / UnitsInStock) as 'Percentage'
from Production.Products
;
go

/* Example 19
Find the ten most expensive products. Create this view and save it as 19_vTenMostExpensiveProducts.
*/

create view v19_TenMostExpensiveProducts
as
select top (10) ProductName as 'Product Name', UnitPrice as 'Unit Price'
from Production.Products
order by UnitPrice desc
;
go

/* Example 20
calculate the subtotal of each order. Create this view and save it as 20_vOrderSubtotal.
Subtotal = unit price x quantity - discount
*/

create view v20_OrderSubtotal
as
select ((UnitPrice * Quantity) * (1 - Discount) as 'Subtotal'
from Sales.[Order Details]
;
go

select *
from HumanResources.Employees
;
go