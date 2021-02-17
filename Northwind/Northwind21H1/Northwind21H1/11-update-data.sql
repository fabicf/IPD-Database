/* 
Purpose: update data object in the database Northwind
Script Date: February 11th, 2021
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

-- display orders info
select *
from Sales.Orders;
go

/* update Order Date , REquired Date, and Shipped Date as follow
1996 --> 2019
1997 --> 2020
1998 --> 2021

by adding 23 years
*/

/* Built-In SQL Functions
DateAdd

DateAdd(DatePart, number, date_to_update)
where DatePart: year, month, day, hour, minute...)
*/

-- 1. update order date
update Sales.Orders
set OrderDate = dateadd(year, 23, OrderDate)
-- where condition

;
go

-- 3. update requiredr date
update Sales.Orders
set requiredDate = dateadd(year, 23, requiredDate)
-- where condition
;
go

-- 3. update Shipping
update Sales.Orders
set ShippedDate = dateadd(year, 23, ShippedDate)
-- where condition
;
go

select *
from HUmanResources.Employees
;
go

/* update the birth date of all employees by adding 34 years */
update HumanResources.Employees
set BirthDate = dateadd(year, 34, BirthDate)
-- where condition
;
go

/* adjust the employee HreDate, so that the seniority value becomes as follow:

EmployeeID  Seniority  Old Seniority years| substract new seniority years	
----------  ----------
1			8			29						21
2			8			29						21
3			7			29						22
4			6			28						22
5			5			28						23
6			4			28						24	
7			3			27						24
8			2			27						25
9			1			27						26
*/

/* calculate the emp seniority using the built-in function DateDiff
Datediff(DatepPart, start_date, end_date)
(where DatePart: year, month, day, hour, minute...)
*/

select EmployeeID, FirstName, LastName,
dateDiff(year, HireDate, getDate())
from HumanResources.Employees
;
go

/* update the HireDate for Employee 1 and 2 */
update HumanResources.Employees
set HireDate = dateadd(year, 21, HireDate)
where EmployeeID in (1,2)
;
go


select *
from HUmanResources.Employees
;
go

/* for Employee #3 and #4 */
update HumanResources.Employees
set HireDate = dateadd(year, 22, HireDate)
where EmployeeID in (3,4)
;
go

/* for Employee #5 */
update HumanResources.Employees
set HireDate = dateadd(year, 23, HireDate)
where EmployeeID in (5)
;
go

/* for Employee #6 and #7 */
update HumanResources.Employees
set HireDate = dateadd(year, 24, HireDate)
where EmployeeID in (6, 7)
;
go

/* for Employee #8 */
update HumanResources.Employees
set HireDate = dateadd(year, 25, HireDate)
where EmployeeID in (8)
;
go

/* for Employee #9 */
update HumanResources.Employees
set HireDate = dateadd(year, 26, HireDate)
where EmployeeID in (9)
;
go

select EmployeeID, FirstName, LastName,
dateDiff(year, HireDate, getDate())
from HumanResources.Employees
;
go


