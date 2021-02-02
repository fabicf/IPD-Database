/* Creating view objects in the flix database */

/* Script Date: February 1st, 2021
Developed by: Fabiola Faria
*/

-- switch to the Flix database
-- Syntax: use database_name;
use FCFlix
;

/* Partial Syntax:
create view view_name
	as
		select statement(s)
;
*/

/* create a view that returns  all movies produced by Columbia Pictures Studio */
create view ColumbiaPicturesView (MovieID, MovieName, NoOfDisks, YearReleased)
as
	select
		D.DVDID as `Movie ID`, 
		D.DVDName as `Movie Name`,
		D.NumDisks as `No. of Disks`,
		D.YearRlsd as `Year Released`
	from DVDs as D inner join Studios as S
		on D.StudID = S.StudID
	where S.StudDescrip = 'Columbia Pictures'
	;
    
select * 
from ColumbiaPicturesView
where YearReleased = 2019
;

/* modify ColumbiaPIcturesView view by adding the movie type description */ 
alter view ColumbiaPicturesView (MovieID, MovieName, NoOfDisks, YearReleased, Genre)
as
	select
		D.DVDID as `Movie ID`, 
		D.DVDName as `Movie Name`,
		D.NumDisks as `No. of Disks`,
		D.YearRlsd as `Year Released`,
        MT.MTypeDescrip as `Movie Type`
	from DVDs as D inner join Studios as S
		on D.StudID = S.StudID
        inner join MovieTypes as MT
        on D.MTypeID = MT.MTypeID
	where S.StudDescrip = 'Columbia Pictures'
	;

select * 
from ColumbiaPicturesView
where YearReleased = 2019
;

select MovieName, Genre
from ColumbiaPicturesView
;

/* delete a view 
drop object_type object_name
*/
drop view ColumbiaPicturesView
;


