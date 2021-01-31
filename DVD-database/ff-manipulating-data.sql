/* Manipulating data in the flix database */

/* Script Date: January 28, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/*
crud
Create (DDL)
Retrieve (DML)
Update
Delect
Select
return the mployee list, including fn, ln and phone
*/

/* select column1, column2,
from object_name 
ehere condition

*/

select firstname, lastname, phone
from employees
where City = 'Montreal'

select the list on countries where you customers are located
Country
Canada
Canada
USA
USA

how many customers in Canada
Aggregate functions: sum(), avergage(), max(), min(), count()

select count(CustomerID), 
group by Country
order by country asc | desc

having count(OrderID) >= 10

-- select distinc
CustomerID Country
1			CA
2			USA
3			CA
4			FR

5. select
1. from
2. where
3. group by
4. having
6. order by

list the most 10 expensive products

select productID, productName
from Products
order by UnitPrice desc
limit 10



