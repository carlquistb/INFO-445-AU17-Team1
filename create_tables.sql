/*
Team 1: Parker, Jake, and Brendan
INFO 445 AU17

description: This script will create BookPromotions and its tables.
*/

/******************create database************************/
use master
if exists (select name from sysdatabases where name='g1_BookPromotionsDB')
	drop database g1_BookPromotionsDB
go
create database g1_BookPromotionsDB
go

USE g1_BookPromotionsDB
GO

/******************Editions table*************************/
create table Editions (
	EditionID int
		identity(1,1)
		not null,
	EditionName nvarchar(100)
		not null,
	EditionDescription nvarchar(500)

	constraint pk_Editions primary key (EditionID)
	);
/******************Formats table**************************/
create table Formats (
	FormatID int
		identity(1,1)
		not null,
	FormatName nvarchar(100)
		not null,
	FormatDescription nvarchar(500)

	constraint pk_Formats primary key (FormatID)
	);
/******************Books table****************************/
create table Books (
	BookID int
		identity(1,1)
		not null,
	BookTitle nvarchar(100)
		not null,
	BookDescription nvarchar(500)

	constraint pk_Books primary key (BookID)
	);
/******************ReleaseDays table**********************/
create table ReleaseDays (
	ReleaseDayID int
		identity(1,1)
		not null,
	ReleaseDayDate date
		not null,
	BookID int
		not null,
	EditionID int
		not null
		foreign key
			references Editions(EditionID),
	FormatID int
		not null
		foreign key
			references  Formats(FormatID)

	constraint pk_ReleaseDays primary key (ReleaseDayID),
	constraint fk_ReleaseDays_Books foreign key (BookID) references Books (BookID),
	constraint fk_ReleaseDays_Editions foreign key (EditionID) references Editions (EditionID),
	constraint fk_ReleaseDays_Formats foreign key (FormatID) references Formats (FormatID)
	);
/******************Series table***************************/
create table Series (
	SeriesID int
		identity(1,1)
		not null,
	SeriesName nvarchar(100)
		not null,
	SeriesDescription nvarchar(500)

	constraint pk_Series primary key (SeriesID)
	);
/******************BooksSeries table*********************/
create table BooksSeries (
	BooksSeriesID int
		identity(1,1)
		not null,
	BookID int
		not null,
	SeriesID int
		not null

	constraint pk_BooksSeries primary key (BooksSeriesID),
	constraint fk_BooksSeries_Books foreign key (BookID) references Books(BookID),
	constraint fk_BooksSeries_Series foreign key (SeriesID) references Series(SeriesID)
	);
/******************Authors table**************************/
create table Authors (
	AuthorID int
		identity(1,1)
		not null,
	AuthorFirstName nvarchar(100)
		not null,
	AuthorLastName nvarchar(100)
		not null,
	AuthorDOB date

	constraint pk_Authors primary key (AuthorID)
	);
/******************BooksAuthors table*********************/
create table BooksAuthors (
	BooksAuthorID int
		identity(1,1)
		not null,
	BookID int
		not null,
	AuthorID int
		not null

	constraint pk_BooksAuthors primary key (BooksAuthorID),
	constraint fk_BooksAuthors_Books foreign key (BookID) references Books(BookID),
	constraint fk_BooksAuthors_Authors foreign key (AuthorID) references Authors(AuthorID)
	);
/******************Genres table***************************/
create table Genres (
	GenreID int
		identity(1,1)
		not null,
	GenreName nvarchar(100)
		not null,
	GenreDescription nvarchar(500)

	constraint pk_Genres primary key (GenreID)
	);
/******************GenresBooks table**********************/
create table GenresBooks (
	GenreBookID int
		identity(1,1)
		not null,
	GenreID int
		not null,
	BookID int
		not null

	constraint pk_GenresBooks primary key (GenreBookID),
	constraint fk_GenresBooks_Genres foreign key (GenreID) references Genres (GenreID),
	constraint fk_GenresBooks_Books foreign key (BookID) references Books (BookID)
	);
/******************States table***************************/
CREATE TABLE States (
	StateID int 
		IDENTITY(1,1) 
		NOT NULL,
	StateAbbreviation varchar(5) 
		NOT NULL,
	StateName varchar(100) 
		NOT NULL

	CONSTRAINT pk_States PRIMARY KEY (StateID)
	);
/******************Cities table***************************/
CREATE TABLE Cities (
	CityID int IDENTITY(1,1) NOT NULL,
	CityName varchar(100) NOT NULL,
	StateID int NOT NULL

	CONSTRAINT pk_Cities PRIMARY KEY (CityID),
	CONSTRAINT fk_Cities_States FOREIGN KEY (StateID) REFERENCES States (StateID)
	);
/******************Retailers table************************/
CREATE TABLE Retailers (
	RetailerID int IDENTITY(1,1) NOT NULL,
	RetailerName varchar(100) NOT NULL,
	RetailerDesc varchar(250) NOT NULL

	CONSTRAINT pk_Retailers PRIMARY KEY (RetailerID)
	);
/******************Locations table************************/
CREATE TABLE Locations (
	LocationID int IDENTITY(1,1) NOT NULL,
	LocationName varchar(100) NOT NULL,
	StreetAddress varchar(100) NOT NULL,
	CityID int NOT NULL,
	ZipCode varchar(10) NOT NULL,
	RetailerID int NOT NULL

	CONSTRAINT pk_Locations PRIMARY KEY (LocationID),
	CONSTRAINT fk_Locations_Cities FOREIGN KEY (CityID) REFERENCES Cities (CityID),
	CONSTRAINT fk_Locations_Retailers FOREIGN KEY (RetailerID) REFERENCES Retailers (RetailerID)
	);
/******************BooksLocations*************************/
CREATE TABLE BooksLocations (
	BookLocationID int IDENTITY(1,1) NOT NULL,
	BookID int NOT NULL,
	LocationID int NOT NULL

	CONSTRAINT pk_BookLocation PRIMARY KEY (BookLocationID),
	CONSTRAINT fk_BookLocation_Books FOREIGN KEY (BookID) REFERENCES Books (BookID),
	CONSTRAINT fk_BookLocation_Location FOREIGN KEY (LocationID) REFERENCES Locations (LocationID)
	);
/******************DailySalesData table*******************/
CREATE TABLE DailySalesData (
	DailySalesID int IDENTITY(1,1) NOT NULL,
	BookLocationID int NOT NULL,
	UnitsSold int NOT NULL,
	DollarsSold money NOT NULL,
	UtcDate date NOT NULL

	CONSTRAINT pk_DailySalesData PRIMARY KEY (DailySalesID),
	CONSTRAINT fk_DailySalesData_BookLocation FOREIGN KEY (BookLocationID) REFERENCES BookLocation (BookLocationID)
	);
/******************Promos table***************************/
CREATE TABLE Promos (
	PromoID int IDENTITY(1,1) NOT NULL,
	PromoName varchar(150) NOT NULL,
	PromoBudget money NOT NULL,
	PromoDesc varchar(250) NOT NULL,
	PromoStartDate date NOT NULL,
	PromoEndDate date NOT NULL

	CONSTRAINT pk_Promos PRIMARY KEY (PromoID)
	);
/******************BooksPromos table**********************/
CREATE TABLE BooksPromos (
	BookPromoID int IDENTITY(1,1) NOT NULL,
	BookID int NOT NULL,
	PromoID int NOT NULL

	CONSTRAINT pk_BookPromos PRIMARY KEY (BookPromoID),
	CONSTRAINT fk_BookPromos_Books FOREIGN KEY (BookID) REFERENCES Books (BookID),
	CONSTRAINT fk_BookPromos_Promos FOREIGN KEY (PromoID) REFERENCES Promos (PromoID)
	);
/******************Expenses table*************************/
CREATE TABLE Expenses (
	ExpenseID int IDENTITY(1,1) NOT NULL,
	ExpenseName varchar(100) NOT NULL,
	ExpenseDesc varchar(250) NOT NULL,
	BookPromoID int  NOT NULL

	CONSTRAINT pk_Expense PRIMARY KEY (ExpenseID),
	CONSTRAINT fk_Expense_BookPromo FOREIGN KEY (BookPromoID) REFERENCES BookPromos (BookPromoID)
	);
/******************Categories table***********************/
CREATE TABLE Categories (
	CategoryID int IDENTITY(1,1) NOT NULL,
	CategoryName varchar(100) NOT NULL,
	CategoryDesc varchar(250) NOT NULL

	CONSTRAINT pk_CategoryID PRIMARY KEY (CategoryID)
	);
/******************PromosCategories table******************/
CREATE TABLE PromosCategories (
	PromoCategoryID int IDENTITY(1,1) NOT NULL,
	PromoID int NOT NULL,
	CategoryID int NOT NULL

	CONSTRAINT pk_PromoCategories PRIMARY KEY (PromoCategoryID),
	CONSTRAINT fk_PromoCategories_Promo FOREIGN KEY (PromoID) REFERENCES Promos (PromoID),
	CONSTRAINT fk_PromoCategories_Categories FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
	);

