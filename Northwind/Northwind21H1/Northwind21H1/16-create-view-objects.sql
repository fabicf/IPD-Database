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

/* 1. create the contact customer view (Sales.ContactNameView) that contains the contact name and contact title */

if OBJECT_ID('Sales.ContactNameView', 'V') is not null
	drop view Sales.ContactNameView
;
go

create view Sales.ContactNameView
as
	select SC.CustomerID, SC.CompanyName, SC.ContactName, SC.ContactTitle
	from Sales.Customers as SC
;
go

select *
from Sales.ContactNameView
order by CompanyName asc 
;
go

/* 2. modify the Sales.ContactNameView and add the Phone, and Country */
alter view Sales.ContactNameView
as
	select SC.CustomerID, SC.CompanyName, SC.ContactName, SC.ContactTitle, SC.Phone, SC.Country
	from Sales.Customers as SC
;
go

select *
from Sales.ContactNameView
where CustomerID = 'ALFKI'
;
go


/* calculate the subtotal of each order. Create this view and save it as 20_vOrderSubtotal.
Subtotal = unit price x quantity - discount
*/
create view Sales.OrderSubtotal_View
as
select OD.OrderID, OD.ProductID, OD.UnitPrice, OD.Quantity, OD.Discount, (OD.UnitPrice * OD.Quantity) * (1 - OD.Discount) as 'OrderSubtotal'
from Sales.[Order Details] as OD
;
go

/* modify the OrderSubtotal_View */
alter view Sales.OrderSubtotal_View
-- with encryption
as
select OD.OrderID, OD.ProductID, OD.UnitPrice, OD.Quantity, OD.Discount, 
sum(convert(smallmoney,((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) ) ) as 'Subtotal'
from Sales.[Order Details] as OD
group by OD.OrderID, OD.ProductID, OD.UnitPrice, OD.Quantity, OD.Discount
;
go

select *
from Sales.OrderSubtotal_View
where OrderID = 10248
;
go

/* return the definition of the view Sales.OrderSubtotal_View */
execute sp_helptext 'Sales.OrderSubtotal_View'
;
go
