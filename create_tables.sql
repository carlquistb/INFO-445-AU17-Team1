/*
Team 1: Parker, Jake, and Brendan
INFO 445 AU17

description: This script will create BookPromotions and it's tables.
*/

/******************create database************************/
use master
if exists (select name from sysdatabases where name='BookPromotionsDB')
	drop database BookPromotionsDB
go
create database BookPromotionsDB
go

/******************tblEditions table**********************/
create table tblEditions (
	EditionID int
		primary key
		identity(1,1)
		not null,
	EditionName nvarchar(100)
		not null,
	EditionDescription nvarchar(500)
)
/******************tblFormats table***********************/
create table tblFormats (
	FormatID int
		primary key
		identity(1,1)
		not null,
	FormatName nvarchar(100)
		not null,
	FormatDescription nvarchar(500)
)
/******************tblBooks table*************************/
create table tblBooks (
	BookID int
		primary key
		identity(1,1)
		not null,
	BookTitle nvarchar(100)
		not null,
	BookDescription nvarchar(500)
)
/******************tblReleaseDays table*******************/
create table tblReleaseDays (
	ReleaseDayID int
		primary key
		identity(1,1)
		not null,
	ReleaseDayDate date
		not null,
	ReleaseDayBookID int
		not null
		foreign key
			references tblBooks(BookID),
	ReleaseDayEditionID int
		not null
		foreign key
			references tblEditions(EditionID),
	ReleaseDayFormatID int
		not null
		foreign key
			references  tblFormats(FormatID)
)
/******************tblSeries table************************/
create table tblSeries (
	SeriesID int
		primary key
		identity(1,1)
		not null,
	SeriesName nvarchar(100)
		not null,
	SeriesDescription nvarchar(500)
)
/******************tblBooksSeries table******************/
create table tblBooksSeries (
	BooksSeriesID int
		primary key
		identity(1,1)
		not null,
	BookID int
		foreign key
			references tblBooks(Bookid)
		not null,
	SeriesID int
		foreign key
			references tblSeries(SeriesID)
		not null
)
/******************tblAuthors table***********************/
create table tblAuthors (
	AuthorID int
		primary key
		identity(1,1)
		not null,
	AuthorFirstName nvarchar(100)
		not null,
	AuthorLastName nvarchar(100)
		not null,
	AuthorDOB date
)
/******************tblBooksAuthors table******************/
create table tblBooksAuthors (
	BooksAuthorID int
		primary key
		identity(1,1)
		not null,
	BookID int
		foreign key
			references tblBooks(BookID)
		not null,
	AuthorID int
		foreign key
			references tblAuthors(AuthorID)
		not null
)
/******************tblGenres table************************/
create table tblGenres (
	GenreID int
		primary key
		identity(1,1)
		not null,
	GenreName nvarchar(100)
		not null,
	GenreDescription nvarchar(500)
)
/******************tblGenresBooks table*******************/
create table tblGenresBooks (
	GenreBookID int
		primary key
		identity(1,1)
		not null,
	GenreID int
		foreign key
			references tblGenres(GenreID)
		not null,
	BookID int
		foreign key
			references tblBooks(BookID)
		not null
)