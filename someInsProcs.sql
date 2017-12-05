alter proc pInsSynthRetailersLocations
	(
		@num int
	)
as
	declare @RetailerID int
	declare @LocationID int
	
	while @num > 0
	begin
		set @RetailerID = (select top 1 RetailerID from Retailers order by newid())
		set @LocationID = (select top 1 LocationID from Locations order by newid())

		begin tran  T1
			begin try
				insert into RetailersLocations
					(
						RetailerID, LocationID
					)
					values (@RetailerID, @LocationID)
				commit tran
			end try
			begin catch
				rollback tran T1
			end catch

		set @num = @num-1
	end
go

exec pInsSynthRetailersLocations @num = 500

go

create proc pInsSynthBooksRetailersLocations
	(
		@num int
	)
as
	declare @BookID int
	declare @RetailerLocationID int

	while @num > 0
	begin
		set @BookID = (select top 1 BookID from Books order by newid())
		set @RetailerLocationID = (select top 1 RetailerLocationID from RetailersLocations order by newid())
		
		begin tran
			begin try
				insert into BooksRetailersLocations
					(BookID, RetailerLocationID)
				values (@BookID, @RetailerLocationID)
			commit tran
			end try
			begin catch
				rollback tran
			end catch
		set @num = @num - 1
	end
go

create procedure pInsDailySalesData
	(
		@units_sold int,					--unitsSold
		@dollars_sold money,				--DollarsSold
		@date date,							--UtcDate
		@book_title nvarchar(100),			
		@location_name nvarchar(100),
		@retailer_name nvarchar(100)
	)
as
	--declare variables
	declare @book_retailer_location_id int

	--execute to set variables
	exec pGetBookRetailerLocationID
		@BookRetailerLocationID = @book_retailer_location_id output,
		@BookTitle = @book_title,
		@LocationName = @location_name,
		@RetailerName = @retailer_name

	begin try
		begin tran T1
			insert into DailySalesData
				(
					BookRetailerLocationID,
					UnitsSold, 
					DollarsSold, 
					UtcDate
				)
			values
				(
					@book_retailer_location_id,
					@units_sold,
					@dollars_sold,
					@date
				)
		commit tran T1
	end try
	begin catch
		rollback tran T1
	end catch
go
		