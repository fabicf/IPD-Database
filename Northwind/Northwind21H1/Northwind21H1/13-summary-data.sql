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
/* Purpose: Summarizing  data in database Northwind21H1
	Script Date: February 15, 2021
	Developed by: your name
*/

/* add a statement that specifies the script
runs in the context of the master database */

-- switch to the current database
-- use database_name
use Northwind21H1
;
go -- include end of the batch marker


/* return the quantity of each product placed in orders */
select OrderID, ProductID, Quantity
from Sales.[Order Details]
;
go

/* return the total quantity of each product placed in orders */
select ProductID, sum(Quantity) as 'Total Quantity'
from Sales.[Order Details]
group by ProductID
;
go

/* return the total quantity of product number (ProductID = 2)  placed in orders */
select ProductID, sum(Quantity) as 'Total Quantity'
from Sales.[Order Details]
where ProductID = 2
group by ProductID -- only rows that satisfy the WHERE condition are grouped
;
go

/* return the total quantity of each product placed in orders, for products with more than 500 units */
select ProductID, sum(Quantity) as 'Total Quantity'
from Sales.[Order Details]
-- where ProductID = 2
group by ProductID
having  sum(Quantity) > 500
;
go

/* Using the GROUP BY Clause with the ROLLUP Operator */
select ProductID, OrderID, sum(Quantity) as 'Total Quantity'
from Sales.[Order Details]
where ProductID in(1, 2, 3)
group by ProductID, OrderID
with rollup
order by ProductID asc, OrderID
;
go

/* Using the GROUP BY Clause with the CUBE Operator */
select ProductID, OrderID, sum(Quantity) as 'Total Quantity'
from Sales.[Order Details]
where ProductID in(1, 2, 3)
group by ProductID, OrderID
with cube -- produces two more summary values than the rollup
order by ProductID, OrderID
;
go

/* Using the GROUPING Function 
1 - represents summary values in the preceding column 
0 - represents detail values in the preceding column
*/

SELECT ProductID, GROUPING(ProductID) as 'Grouping Product ID', 
OrderID, GROUPING(OrderID) as 'Grouping Order ID',
SUM(quantity) AS total_quantity
FROM Sales.[Order Details]
where ProductID in(1, 2, 3)
GROUP BY productid, orderid
WITH CUBE 
ORDER BY productid, orderid
;
go

/* Compute is deprecated  */

/* return the top 5 product with highest quantity */
select top 5 OrderID, ProductID, Quantity
from sales.[Order Details]
order by Quantity desc
;
go

/*
WITH TIES
Returns two or more rows that tie for last place in the limited results set. You must use this argument with the ORDER BY clause. WITH TIES might cause more rows to be returned than the value specified in expression.
*/
select top 5 with ties OrderID, ProductID, Quantity
from sales.[Order Details]
order by Quantity desc
;
go

/* 
GROUP BY ROLLUP
Creates a group for each combination of column expressions. In addition, it "rolls up" the results into subtotals and grand totals. To do this, it moves from right to left decreasing the number of column expressions over which it creates groups and the aggregation(s).
*/
select SC.Country, Sc.Region, SC.City, count(SO.OrderID) as 'Total_Orders'
from Sales.Customers as SC
	inner join Sales.Orders as SO
		on SC.CustomerID = SO.CustomerID
where SC.Country in('Canada', 'USA', 'France')
group by rollup (SC.Country, Sc.Region, SC.City)
;
go


/* GROUP BY CUBE ( )
GROUP BY CUBE creates groups for all possible combinations of columns. For GROUP BY CUBE (a, b) the results has groups for unique values of (a, b), (NULL, b), (a, NULL), and (NULL, NULL).

Using the table from the previous examples, this code runs a GROUP BY CUBE operation on Country and Region.
*/
select SC.Country, Sc.Region, SC.City, count(SO.OrderID) as 'Total_Orders'
from Sales.Customers as SC
	inner join Sales.Orders as SO
		on SC.CustomerID = SO.CustomerID
where SC.Country in('Canada', 'USA', 'France')
group by cube (SC.Country, Sc.Region, SC.City)
;
go








-- ===================================================================================================================
/* return the quantity of each product placed in orders */
select OrderID, ProductID, Quantity
from Sales.[Order Details]
;
go

/* return the total quantity of each product placed in orders */
select ProductID, sum(Quantity) as 'Total Qty'
from Sales.[Order Details]
group by ProductID
;
go

/* return the total quantity of product number (ProductID = 2) placed in orders */

select ProductID, sum(Quantity) as 'Total Qty'
from Sales.[Order Details]
where ProductID = 2
group by ProductID -- only rows that satisfy the where condition are group
;
go

-- return the total quantity of each product placed in orders, for prodsucts with more than 500 units
select ProductID, sum(Quantity) as 'Total Qty'
from Sales.[Order Details]
-- where ProductID = 2
group by ProductID -- only rows that satisfy the where condition are group
having sum(Quantity) > 50
;
go

/* u sing the GROUP gy clause with the ROLLUP operator */
select ProductID, OrderID, sum(Quantity) as 'Total Qty'
from Sales.[Order Details]
where ProductID in (1, 2, 3)
group by ProductID, OrderID
order by ProductID asc, OrderID
;
go

select ProductID, OrderID, sum(Quantity) as 'Total Qty'
from Sales.[Order Details]
where ProductID in (1, 2, 3)
group by ProductID, OrderID
with rollup
order by ProductID asc, OrderID
;
go

/* Using the Group By clause with the CUBE operator*/
select ProductID, OrderID, sum(Quantity) as 'Total Qty'
from Sales.[Order Details]
where ProductID in (1, 2, 3)
group by ProductID, OrderID
with cube -- produces two more summary values than rollup
order by ProductID asc, OrderID
;
go


/* using the GROUPING function
1 - represents summary values in thee preceding column
0 - represents detail values in the preeding colum
*/
select ProductID, GROUPING(ProductID) as 'Product ID'

from Sales.[Order Details]
where ProductID in (1, 2, 3)
group by ProductID, OrderID
with cube -- produces two more summary values than rollup
order by ProductID asc, OrderID
;
go

