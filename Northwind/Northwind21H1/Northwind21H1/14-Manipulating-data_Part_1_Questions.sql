/* Purpose: Manipulate data in the database NorthWind
	Script Date: February 15, 2021
	Developed By: Fabiola Faria
*/

/* add a statement that specifies the script
runs in the context of the Safeway database
Syntax: use database_name
*/

-- switch to the Safeway database
use NorthWind21H1
;
go -- include end of the batch marker 



/* Partial syntax:
select <select_list> [into new_table]
[From object_name]
[Where search_condition]
[Group by group_by_condition]
[Having search_condition]
[Order by order_expression [asc] | [desc] ]
*/

/* 
1) Read the question
2) find the object(s) - table or a query that answer your question
3) list the column(s) - fields from each object
4) define the criteria(s) 
5) run one criteria after another
*/

/*
The actual physical execution of the statement is determined by the query processor and the order may vary from this list.

1. FROM
2. ON
3. JOIN
4. WHERE
5. GROUP BY
6. WITH CUBE or WITH ROLLUP
7. HAVING
8. SELECT
9. DISTINCT
10. ORDER BY
11. TOP

*/

/*
Example 1
Find customers in London (UK) with Sales Representative contact title. ----> correct
*/
select CustomerID as 'Customer ID', ContactTitle as 'Contact Title', City, Country as 'Country'
from Sales.Customers
where Country = 'UK'
and City = 'London'
and ContactTitle like '%Sales Rep%'
;
go


/*
Example 2
Suppose that you want to see a list of countries where Northwind Traders’ suppliers are located. You want to arrange the countries alphabetically, and within each country you want to list supplier names alphabetically. 
*/
select Country as 'Country Name', CompanyName as 'Company Name'
from Production.Suppliers
order by Country asc, CompanyName asc
;
go


/*
Example 3
Suppose you want to see the name and location of Northwind Traders’ suppliers from Germany. 
*/
select CompanyName as 'Company Name', Address, City, Region, PostalCode
from Production.Suppliers
where Country = 'Germany'
;
go


/*
Example 4
Suppose that you want to display company names of suppliers from Sweden, but you only want to see the company names, not the country, in the result set. 
*/
select CompanyName as 'Company Name'
from Production.Suppliers
where Country = 'Sweden'
;
go

/*
Example 5
Suppose that you want to view all the fields in the Order Details table, but you’re interested in seeing only those records with an Order ID greater than 11000. 
*/
select *
from Sales.[Order Details]
where OrderID > 11000
;
go

/*
Example 6
Suppose that you want to find employees who are hired between January 1st and March 31st 2018 (first quarter of 2018).   
*/

select EmployeeID, FirstName as 'First Name', LastName as 'Last Name'
from HumanResources.Employees
where HireDate between '2018/1/1' and '2019/3/31'
;
go

/*
Example 7
Suppose you want to see suppliers from Germany or Canada. 
*/
select SupplierID, CompanyName as 'Company Name', Country as 'Country'
from Production.Suppliers
where Country in ('Germany', 'Canada')
;
go


select CompanyName as 'Company Name', Country as 'Country'
from Production.Suppliers
where Country = 'Germany' OR Country = 'Canada'
;
go


/*
Example 8
Suppose you want to see suppliers in either the UK (United Kingdom) or Paris.  
*/
select *
from Production.Suppliers
where Country = 'UK' OR City = 'Paris'
;
go

/*
Example 9
Suppose that you want to find suppliers who have a fax number. 
*/
select CompanyName as 'Company_Name', Fax as 'Fax'
from Production.Suppliers
where Fax is not null
;
go



/*
Example 10
Suppose that you want to see customers who are located in Seattle, Kirkland, or Portland. 
*/
select CompanyName as 'Company Name'
from Sales.Customers
where City in ('Seattle', 'Kirkland', 'Portland')
;
go


select CompanyName as 'Company Name'
from Sales.Customers
where City = 'Seattle' OR City = 'Kirkland' OR City = 'Portland'
;
go


/*
Example 11
Suppose that you want to select a list of countries where  suppliers are located.
*/
select distinct Country 
from Production.Suppliers
;
go

