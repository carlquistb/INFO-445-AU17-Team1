
create proc pGetRetailerLocationID
	(
		@RetailerName varchar(100),
		@LocationName varchar(100),
		@RetailerLocationID int output
	)
as
		declare @RetailerID int
		declare @LocationID int

		exec pGetLocationID @LocationName = @LocationName, @LocationID = @LocationID output
		exec pGetRetailerID @RetailerName = @RetailerName, @RetailerID = @RetailerID output

		set @RetailerLocationID = (select top 1 RetailerLocationID from RetailersLocations
									where RetailerID = @RetailerID and LocationID = @LocationID)
go

create proc pGetLocationID
	(
		@LocationName varchar(100),
		@LocationID int output
	)
as
	set @LocationID = (select top 1 LocationID from Locations where LocationName = @LocationName)
go

create proc pGetRetailerID
	(
		@RetailerName varchar(100),
		@RetailerID int output
	)
as
	set @RetailerID = (select top 1 RetailerID from Retailers where RetailerName = @RetailerName)
go

go

create proc pGetBookRetailerLocationID
	(
		@BookRetailerLocationID int output,
		@BookTitle varchar(100),
		@LocationName varchar(100),
		@RetailerName varchar(100)
	)
as
	declare @RetailerLocationID int
	declare @BookID int

	exec pGetBookID @BkTitle = @BookTitle, 
					@BkID = @BookID output
	exec pGetRetailerLocationID @RetailerName = @RetailerName, 
								@LocationName = @LocationName,
								@RetailerLocationID = @RetailerLocationID output

	set @BookRetailerLocationID = (select top 1 BookRetailerLocationID 
									from BooksRetailersLocations 
									where BookID = @BookID and RetailerLocationID = @RetailerLocationID)
go
