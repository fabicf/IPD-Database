/* Manipulate data in the Northwind database 
Script Date: February 17, 2021
Developed by: Fabiola Faria
*/

/* add a statement that specifies the script runs in the context of the master database */

-- switch to Northwind database 
use NorthWind21H1
;
go -- include end of batch markers (go statement)

-- some of the date and time buil-in functions
select 
	OrderID as 'Order ID',
	OrderDate as 'Order Date',
	year(OrderDate) as 'Order Year',
	day(OrderDate) as 'Order Day',
	DatePart(year, OrderDate) as 'Year Date Part',
	DatePart(month, OrderDate) as 'Month Date Part',
	DatePart(day, OrderDate) as 'Day Date Part',
	DatePart(weekday, OrderDate) as 'Weekday Date Part',
	DatePart(DayOfYear, OrderDate) as 'Day of Year Date Part',
	DateName(weekday, OrderDate) as 'DayName',
	EOMonth(OrderDate) as 'End of Month'
from Sales.Orders;


select OrderID, OrderDate
from Sales.Orders
-- where year(OrderDate) between 2019 and 2020
-- where year(OrderDate) in (20190, 2020)
where OrderDate between '1/1/2019' and '12/31/2020'
;
go


-- some of the T-SQL logical functions
-- isNumeric(expression) - return 1 when the input expression evaluates
-- to a valiud data type, otherwise it returns 0.

-- return the list of employees and the posal code with numeric values
select EMployeeID, FirstName, LastName, PostalCode
from HumanResources.Employees
where ISNUMERIC(PostalCode) = 1
;
go


/* IIF(expression) - Immediate If function that retrn one or two values depending on whether the boolean expression evaluates  to true or false
SYNTAX: iif( (expression), 'true_value', 'Flase_value'))*/


execute sp_helplanguage;