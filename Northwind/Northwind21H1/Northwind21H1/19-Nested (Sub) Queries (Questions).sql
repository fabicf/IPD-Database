/*  Using Nested (sub) Queries 
	Script Date: February 17, 2021
	Developed by: Your Name
*/ 

/* add a statement that specifies the script runs in the context of the master database */

-- switch to Northwind21H1 database 
use Northwind21H1
;
go -- include end of batch markers (go statement)

/* A subquery is a query that is nested inside a SELECT, INSERT, UPDATE, or DELETE statement, or inside another subquery. A subquery can be used anywhere an expression is allowed. 

A subquery is also called an inner query or inner select, while the statement containing a subquery is also called an outer query or outer select.

A subquery nested in the outer SELECT statement has the following components:

A regular SELECT query including the regular select list components.
A regular FROM clause including one or more table or view names.
An optional WHERE clause.
An optional GROUP BY clause.
An optional HAVING clause.

*/

/* a scalar subquery -> a query that returns a single value 
 Multiple-value subquery --> a query that returns a result set much like a single-column table 
*/

/* return the last order placed */

-- using max() function

-- get the order from order details table

/* return the last order placed with the product id, unit price, and the quantity */
/* NOT AS GOOD RESULT */


/* return the last order placed using as nested query */



/* return the list of orders placed by customers from Mexico (Ship Country) */

/* return the list of orders placed by customers (Company Name) from Mexico (Ship Country) */


-- using nested query 



/* Correlated sub-query refers to columns of table used in outer table. Correlated sub-query is used to pass a value from the outer query to the inner query to be used as parameter 
*/

/* return orders with the last order date for each employee */



/* use the [NOT] [EXSITS] predicate with sub-query to check for any result that returns from a query. EXISTS evaluates whether rows exist, but rather than returns them, it returns true or false
*/

/* return the number of employees who are associated with orders */


-- using the EXISTS to return the same result 


-- add yourself as a new employee


/* return any customer (company name) that has never placed an order */
-- use [NOT] EXISTS clause


-- same query using outer join





