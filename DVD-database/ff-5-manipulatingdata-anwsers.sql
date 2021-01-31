/* Manipulating data in the flix database */

/* Script Date: January 28, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;


/* A query is a question you ask about the data in the database. A query can be based on one or more tables or other queries. */

/* in order to answer any question about the data:
1. determine the object(s), table (base table) or view (virtual table) [FROM]
2. determine the column(s) from each object [SELECT]
3. run the script
4. define criteria(s), condition(s), and then run them one after another [WHERE] | [HAVING]
5) group the data [GROUP BY]
6) eliminate the duplicate data [DISTINCT]
*/

/* Partial Syntax:
select * (all) | <comma seperator column_list> | top (number) | distinct | 
from object_name
where condition
 */

 /* 1. list all dvd id, dvd name, and year released */
 
 select DVDID,  DVDName, YearRlsd
 from DVDs
 ;

 /* 2. list all dvd id, and dvd name released in 2019 */ 
  select DVDID, DVDName, YearRlsd
 from DVDs
 where YearRlsd = '2019'
 ;


 /* 3. list all dvd id and dvd names that have more than one disk */
select DVDID, DVDName
from DVDs
where NumDisks > 1
;
   
 /* 4. using aliases(as clause), re-write the previous script using aliases */
select D.DVDID as 'DVD ID', D.DVDName as 'DVD Name'
from DVDs as D
where D.NumDisks > 1
;
 

 /* 5. Using aliases, change the column names in the result set of the Employees table. 
 For example, EmpID -> Employee ID, EmpFN -> First Name, and so on. */
 select E.EmpID as 'Employee ID', E.EmpFN as 'Employee First Name', E.EmpMN as 'Employee Middle Name', E.EmpLN as 'Employee Last Name'
 from Employees as E
 ;


 /* 6. return the employee full name as a single string. String concatenation: + | &  */
 
 select E.EmpFN + ' ' + E.EmpMN + ' ' + E.EmpLN
 from Employees as E
 ;
 
 /* 7. using concat(str1, str2, ... strN) 
 Syntax: CONCAT(string_value1, string_value2 [, string_valueN])
 */
 
 select concat(E.EmpFN, ' ', E.EmpMN, ' ', E.EmpLN) as 'Employee Full Name'
 from Employees as E
;
 
 /* 8. using the coalesce function --> to avoid have empty value when is null*/
select concat(E.EmpFN, ' ', coalesce(E.EmpMN, ''), ' ', E.EmpLN) as 'Employee Full Name'
from Employees as E
; 
   
 /* 9. using concat_ws() function - apply to SQL Server version 2017 and above:
 concat_ws(seperator, argument1, argument2, ..., [, argumentN])
 */
select concat_ws(E.EmpFN, ' ', coalesce(E.EmpMN, ''), ' ', E.EmpLN) as 'Employee Full Name'
from Employees as E
; 
 
 /*
 delete 
 from Employees
 where EmpID > 6
 */


 /* 10. return the rating id (NO Duplicate Values) from the DVDs table */
 select distinct RatingID as 'Rating'
 from DVDs
 ;


 /* 11. return the dvd names and movie type id for the status value S1 (Checked Out) */
 select D.DVDName as 'DVD Name', D.MTypeID as 'Movie Type'
 from DVDs as D
 where D.StatID = 'S1'
 ;
 
 select * from status;
  
 /* 12. return the dvd names and movie type id for the status values S1, S2, or S4 */
 select D.DVDName as 'DVD Name', D.MTypeID as 'Movie Type', D.StatID as 'Status'
 from DVDs as D
 where D.StatID = 'S1' or D.StatID = 'S2' or D.StatID = 'S4'
 ;

/* repeating the same query using the In() operation */
 select D.DVDName as 'DVD Name', D.MTypeID as 'Movie Type', D.StatID as 'Status'
 from DVDs as D
 where D.StatID in ('S1', 'S2', 'S4')
 ;


 /* 13. return the DVD name and the movie type id for the status id = S2, and the rating id equals NR or G
 */
 select D.DVDName as 'DVD Name', D.MtypeID as 'Movie Type', RatingID as 'Rating'
 from DVDs as D
 where D.StatID = 'S2'
 and D.RatingID in ('NR', 'G')
 ;

 /* Aggregate Functions: count([column_name]) | sum() | min() | max() | avg() */
 
 /* 14. return the total number of dvds */
 select count(DVDID) as 'Total Number of DVDs'
 from DVDs
 ;


/* 15. return the total number of disks */
select sum(NumDisks) as 'Total Number of Disks'
from DVDs
;


/* 16. find out how many transactions per each order. List them form the highest to the lowest value */ 
select OrderID, count(TransID) as 'Number of Transactions per Order'
from Transactions
group by OrderID
order by count(TransID) desc
;

select OrderID, count(TransID) as `Number of Transactions per Order`
from Transactions
group by OrderID
order by `Number of Transactions per Order` desc
-- order by 2 desc -- order by second column
;

select * from transactions
;


/* 17. how many orders were taken by each employee */
select EmpID as `Employee No.`, count(OrderID) as `Orders taken by Employee`
from orders
group by EmpID
;

/* Return the total number of orders placed by each customer */
select CustID as `Customer ID`, count(OrderID) as `Order taken by Customer`
from Orders
group by CustID;

/* 18. list customers who placed more than 2 orders */
select CustID as `Customer ID`, count(OrderID) as `Number of Orders`
from Orders
group by CustID 
having count(OrderID) > 2
;



/* Join Types
1. inner join (default) - matched values
outer join - unmatched values

Syntax:
select
from table1 as T1 join_type table2 as T2
	on T1.Pk = T2.FK
*/

/* 19. return the DVD name and Movie Type Description */
select  D.DVDName as `DVD Name`, MT.MTypeDescrip as `Movie Type`
from DVDs as D
	inner join MovieTypes as MT
    on D.MtypeID = MT.MTypeID
;

select * from movietypes
;

/* 19b. return the list of Movie Type Description and their DVD Name, even if no DVD macthes the type */
select MT.MTypeDescrip as `Movie Type`, D.DVDName as `DVD Name`
	from MovieTypes as MT
	left outer join DVDs as D
	on MT.MTypeID = D.MTypeID
    ;

select MT.MTypeDescrip as `Movie Type`, D.DVDName as `DVD Name`
	from MovieTypes as MT
	left outer join DVDs as D
	on MT.MTypeID = D.MTypeID
    where D.DVDName is null
    ;
    
    
/* reverse the from clause in the previous query*/
select MT.MTypeDescrip as `Movie Type`, D.DVDName as `DVD Name`
	from MovieTypes as MT
	right outer join DVDs as D
	on MT.MTypeID = D.MTypeID
    -- where D.DVDName is null
    ;

/* 21. return the list of customers (customer name) and their orders */
select C.CustID as `Customer ID`,
	concat_ws(' ', C.CustFN, coalesce(C.CustMN, ' '), C.CustLN) as `Customer Name`,
    O.OrderID as `Order ID`
from Customers as C
inner join Orders as O
on  C.CustID = O.CustID 
;


select C.CUstID as `Customer ID`
from Customers as C
;

/* 23. return how many orders placed by each customer (customer name) */
select C.CustID as `Customer ID`,
	concat_ws(' ', C.CustFN, coalesce(C.CustMN, ' '), C.CustLN) as `Customer Name`,
    count(O.OrderID) as `Order ID`
from Customers as C
inner join Orders as O
on  C.CustID = O.CustID 
group by C.CustID, `Customer Name`
;


/* 24. List all customers who did not placed any order */
-- select C.CustID as `Customer ID`,
-- 	concat_ws(' ', C.CustFN, coalesce(C.CustMN, ' '), C.CustLN) as `Customer Name`,
--     from Customers as C
-- left join Orders as O
-- on  C.CustID = O.CustID 
-- where O.CustID
;



/* 22. insert yourself as a new customer */
insert into Customers (CustFN, CustLN)
values ('Fabiola', 'Faria')
;





/* 21. return the 
	DVD name, 
	Movie Type Description, 
	Studio Description,
	Status Description,
	Format Description, and
	Rating Description
	*/

select 
	D.DVDName as `DVD Name`, 
	MT.MTypeDescrip as `Movie Type Description`,
    S.StudDescrip as `Studio`,
    ST.StatDescrip as `Status`,
    F.FormDescrip as `Format`
	from DVDs as D
		inner join MovieTypes as MT
			on D.MTypeID = MT.MTypeID
		inner join Studios as S
			on D.StudID = S.StudID
		inner join Status as ST
			on D.StatID = ST.StatID
		inner join Formats as F
			on D.FormID = F.FormID
;



/* 22. return the available comedy DVD name, Movie Type Description, and the Studio Description */

;
/* return the director of the movie, movie name, studio name with status value is 'check out' */

 

/* return the rent time for each DVD rented by customer, using the datediff function 
Syntax:
for Microsoft SQL Server 
DATEDIFF (datePart , startDate , endDate)  
where datePart: year, month, day, hour, minute, and so on 

for MySQL
DATEDIFF (startDate , endDate)  
TimeDiff()
*/


/* DateDiff - return the value between two dates */

/* find how many days it took to return the dvd */
-- in MySQL 


/* find how many days it took to return the dvd */
-- in SQL Server



/* MySQL Built-In functions */
-- Data and time functions


/* Casting date and time */

/* DatePart function */



/* eomonth function returns the last day of the month */


/* DateAdd function */






/* Syntax:
	update schema_name.table_name
	set column_name = expression
*/




/* change the Date In to February 22, 2020 for the TransID = 1 */


/* set the Date In to Date Due + 3 days for the TransID = 2 */



/* show outer join */


/* Extraction and Position functions:
Using the LEFT, RIGHT and SUBSTRING functions
left([column_name], number)
right([column_name], number)
substring([column_name], start, length)
 */


/* return the word White, Christmas, and Chris from the DVD name with ID = 1 */



/* Len() returns the length of a value */


/* replace the . by / in the following string */




/* Changing word case: upper, lower functions */
/* change, in the result set, the dvd name to lower and upper case */ 