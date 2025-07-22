-----------------------
-- Create Procedures --
-----------------------


-- AddNewPerson
create procedure sp_AddNewPerson
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Email nvarchar(50),
	@NewPersonID int output
as
begin
	insert into People (FirstName, LastName, Email) values (@FirstName, @LastName, @Email);

	set @NewPersonID = SCOPE_IDENTITY();
end


-- GetAllPeople
create procedure sp_GetAllPeople
as
begin
	select * from People;
end


-- GetPersonByID
create procedure sp_GetPersonByID
	@PersonID int
as
begin
	select * from People where PersonID = @PersonID;
end


-- GetPersonByID in other way
CREATE PROCEDURE sp_GetPersonByID2
    @PersonID INT,
    @FirstName NVARCHAR(100) OUTPUT,
    @LastName NVARCHAR(100) OUTPUT,
    @Email NVARCHAR(255) OUTPUT,
    @IsFound BIT OUTPUT  -- Additional parameter to indicate if a record was found
AS
BEGIN
    IF EXISTS(SELECT 1 FROM People WHERE PersonID = @PersonID)
		BEGIN
			SELECT 
				@FirstName = FirstName, 
				@LastName = LastName, 
				@Email = Email
			FROM People 
			WHERE PersonID = @PersonID;


			SET @IsFound = 1;  -- Set to 1 (true) if a record is found
		END
    ELSE
		BEGIN
			SET @IsFound = 0;  -- Set to 0 (false) if no record is found
		END
END


-- UpdatePerson
create procedure sp_UpdatePerson
	@PersonID int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Email nvarchar(50)
as
begin
	update People
	set Firstname = @FirstName, LastName = @LastName, Email = @Email
	where PersonID = @PersonID;
end


-- DeletePerson
create procedure sp_DeletePerson
	@PersonID int
as
begin
	delete from People where PersonID = @PersonID;
end


-- CheckPersonExists
create procedure sp_CheckPersonExists
	@PersonID int
as
begin
	if exists(select 1 from People where PersonID = @PersonID)
		return 1;
	else
		return 0;
end


-- Drop Procedure
drop procedure sp_CheckPersonExists;