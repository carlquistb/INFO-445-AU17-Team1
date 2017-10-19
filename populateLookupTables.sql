/*
Team 1: Parker, Jake, and Brendan
INFO 445 AU17

Description: This script will populate our lookup tables.

lookup tables:
	States
	Genres
	Formats
	Editions
	PromoCategories
*/

use g1_BookPromotionsDB
go

-- steal state data from UNIVERSITY.
insert into States 
	select distinct
		right(StudentPermState,2),
		substring(StudentPermState,0,len(StudentPermState)-3)
	from [UNIVERSITY].[dbo].[tblSTUDENT]

-- generate Genre data.
insert into Genres
	(GenreName)
values
	('Science fiction'),
	('Satire'),
	('Drama'),
	('Action and Adventure'),
	('Romance'),
	('Mystery'),
	('Horror'),
	('Self help'),
	('Health'),
	('Guide'),
	('Travel'),
	('Childrens'),
	('Religion, Spirituality & New Age'),
	('Science'),
	('History'),
	('Math'),
	('Anthology'),
	('Poetry'),
	('Encyclopedias'),
	('Dictionaries'),
	('Comics'),
	('Art'),
	('Cookbooks'),
	('Diaries'),
	('Journals'),
	('Prayer books'),
	('Biographies'),
	('Autobiographies'),
	('Fantasy')