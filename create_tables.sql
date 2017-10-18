/*
Team 1: Parker, Jake, and Brendan
INFO 445 AU17

description: This script will create BookPromotions and its tables.
*/

/******************create database************************/
use master
if exists (select name from sysdatabases where name='BookPromotionsDB')
	drop database BookPromotionsDB
go
create database BookPromotionsDB
go

USE BookPromotionsDB
GO

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

CREATE TABLE tblStates (
	StateID int IDENTITY(1,1),
	StateAbbreviation varchar(5),
	StateName varchar(100)

	CONSTRAINT pk_States PRIMARY KEY (StateID)
	);

CREATE TABLE tblCities (
	CityID int IDENTITY(1,1),
	CityName varchar(100),
	StateID int

	CONSTRAINT pk_Cities PRIMARY KEY (CityID),
	CONSTRAINT fk_Cities_States FOREIGN KEY (StateID) REFERENCES tblStates (StateID)
	);

CREATE TABLE tblRetailers (
	RetailerID int IDENTITY(1,1),
	RetailerName varchar(100),
	RetailerDesc varchar(250)

	CONSTRAINT pk_Retailers PRIMARY KEY (RetailerID)
	);

CREATE TABLE tblLocations (
	LocationID int IDENTITY(1,1),
	LocationName varchar(100),
	StreetAddress varchar(100),
	CityID int,
	ZipCode varchar(10),
	RetailerID int

	CONSTRAINT pk_Locations PRIMARY KEY (LocationID),
	CONSTRAINT fk_Locations_Cities FOREIGN KEY (CityID) REFERENCES tblCities (CityID),
	CONSTRAINT fk_Locations_Retailers FOREIGN KEY (RetailerID) REFERENCES tblRetailers (RetailerID)
	);

CREATE TABLE tblBookLocation (
	BookRetailerLocationID int IDENTITY(1,1),
	BookID int,
	LocationID int

	CONSTRAINT pk_BookLocation PRIMARY KEY (BookRetailerLocationID),
	CONSTRAINT fk_BookLocation_Books FOREIGN KEY (BookID) REFERENCES tblBooks (BookID),
	CONSTRAINT fk_BookLocation_Location FOREIGN KEY (LocationID) REFERENCES tblLocations (LocationID)
	);

CREATE TABLE tblPromos (
	PromoID int IDENTITY(1,1),
	PromoName varchar(150),
	PromoBudget money,
	PromoDesc varchar(250),
	PromoStartDate date,
	PromoEndDate date

	CONSTRAINT pk_Promos PRIMARY KEY (PromoID)
	);

CREATE TABLE tblBookPromos (
	BookPromoID int IDENTITY(1,1),
	BookID int,
	PromoID int

	CONSTRAINT pk_BookPromos PRIMARY KEY (BookPromoID),
	CONSTRAINT fk_BookPromos_Books FOREIGN KEY (BookID) REFERENCES tblBooks (BookID),
	CONSTRAINT fk_BookPromos_Promos FOREIGN KEY (PromoID) REFERENCES tblPromos (PromoID)
	);

CREATE TABLE tblCategories (
	CategoryID int IDENTITY(1,1),
	CategoryName varchar(100),
	CategoryDesc varchar(250)

	CONSTRAINT pk_CategoryID PRIMARY KEY (CategoryID)
	);

CREATE TABLE tblPromoCategories (
	PromoCategoryID int IDENTITY(1,1),
	PromoID int,
	CategoryID int

	CONSTRAINT pk_PromoCategories PRIMARY KEY (PromoCategoryID),
	CONSTRAINT fk_PromoCategories_Promo FOREIGN KEY (PromoID) REFERENCES tblPromos (PromoID),
	CONSTRAINT fk_PromoCategories_Categories FOREIGN KEY (CategoryID) REFERENCES tblCategories (CategoryID)
	);

