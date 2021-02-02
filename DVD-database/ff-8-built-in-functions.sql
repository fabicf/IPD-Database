/* Using MySQL Built-In Functions in the flix database */

/* Script Date: February 1st, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/*
COMPARISON AND CONVERTING FUNCTIONS
greatest() | least() | coalesce | isNull() | interval() strCmp | ...
*/

/* what is the greatest value of 2, 3, 10*/
select greatest(2, 3, 10) as `The greatest value`
;

select greatest('a', 'b', 'aa', 'ab', 'bb') as `The greatest value`
;

/* the coalesce funtion returns the first value in the list that is not null */
select coalesce(3, null, '', 4, null) as `coaslesce first value`
;

/* CONTROL FLOW FUNCTIONS
if() | isNullif() | case() | cast() */

/* if ( (condition), 'true_value', 'false_value') */
select if ( (8 >= 60), 'passed the course', 'failed the course') as `if() function`;

/* show the status description from the table DVD */
select 
	DVDName, StatID,
    if ((StatID = 's1'), 'Check Out', if ( (StatID = 'S2'), 'Available', 'N/A')) as `DVD Status`
from DVDs
;

/* isNull() returns a value of 1 if the expression is evaluated to isnull, 
otherwise it retuns zero */
select isnull(1 * null) as `isNull() Function`
;

/* ifNull() evaluates the expression wheter i is equal to null */
select ifNull( (10 * null), 'incorret expression') as `ifnull function`
;

/*nullIf() returns null if expression1 equals to expression2, otherwise it returns expression1   */
select nullif((10 - 20), (20 - 10)) as `nullif function`
;

/* strcomp compares string values. It returns zero if the expression 1 equals expression2
if exp1 < expr2 ==> -1
if exp1 > exp2 ==> 1
if exp1 = exp2 ==> 0 */

select strcmp('big', 'bigger') as `strcomp function`;


/* STRING FUNCTIONS
ASCII() | char_length() | concat() | concat_ws |  lcase() | lower() | ucase() | upper() | left() | right() | substring() | ... */

/* some of string functions:
	left([column_name], number),
    rught([column_name], number),
    and substring([column_name], start, stop)
*/

select * from dvds;

select DVDName,
	left(DVDName, 5) as `left function`,
    right(DVDName, 9) as `right function`,
    substring(DVDName, 7, 5) as `mi function`
from DVDs
where DVDID = 1
;


/* 
case()
case
	case when expression then result
    case when expression then result
    ...[else result]
end
*/

select DVDName, RatingID as `Ratings`,
	case
		when RatingID = 'R' then ' under 17, requires adult permission'
        when RatingID = 'X' then 'no one 17 and under'
        when RatingID = 'NR' then 'use discretion when rating'
        else 'ok to rent minors'
	end as `policy`
from DVDs
;


/* some date functions */
select
	TransID, DateOut,
    date(DateOut) as `the date`,
    day(DateOut) as ` the day`,
    month(DateOut) as ` the month`,
    year(DateOut) as ` the year`,
    dayname(DateOut) as ` the day name`,
    dayofmonth(DateOut) as ` the day of month`,
    dayofweek(DateOut) as ` the day of week`,
    dayofyear(DateOut) as ` the day of year`,
    monthname(DateOut) as ` the month name`
from Transactions
;

/*
DateDiff(<endDate>, <startDate>)
TimeDiff(<endTime>, <startTime>)
*/

/* update the date in for the Trsaction id 1, 2 nd 3 to current date
*/
update transactions
	set dateIn = current_date()
    where TransID in (1, 2, 3)
;

/* how long it took to return a dvd*/
select 
	T.DVDID, D.DVDName, T.DateOut, DateDue, DateIn,
    abs(datediff(DateIn, DateOut)) as `numb of days`
from Transactions as T
	inner join DVDs as D
		on D.DVDID = T.DVDID
;

/*convert functions
cast(expression as data_type)
convert(expression, data_type)
*/

select cast(20210201 as date) as `cast date`;

select convert('20210201', date) as `convert date`;
/*
create function function_name([param1, param2, ...])
return data_type [characristics]
function_body
*/

/* find the number of the daus of a dvd rent*/
delimiter //
create function getRentedDays(startDate date)
returns int deterministic
	begin
		-- declare a variable
        declare endDate date;
        -- compute variable
        select current_date() into endDate;
        -- return computed value to caller
        return day(endDate) - day(startDate);
    end
// delimiter ;

select
	TransID, OrderID, getRentedDays(DateOut) as `numb of days rented`
from Transactions
where OrderID = 1
;




