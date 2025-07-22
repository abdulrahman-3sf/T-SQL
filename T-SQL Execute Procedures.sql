------------------------
-- Execute Procedures --
------------------------

declare @PersonID int;

exec sp_AddNewPerson
	@FirstName = 'Ahmed',
	@LastName = 'Fasil',
	@Email = 'AhmedF@gmail.com',
	@NewPersonID = @PersonID output;

select @PersonID as NewPersonID;


--
exec sp_GetAllPeople;


--
exec sp_GetPersonByID
	@PersonID = 1;


--
DECLARE @ID INT = 1;  -- Example PersonID
DECLARE @FName NVARCHAR(100);
DECLARE @LName NVARCHAR(100);
DECLARE @Email NVARCHAR(255);
DECLARE @Found BIT;

EXEC sp_GetPersonByID2
    @PersonID = @ID,
    @FirstName = @FName OUTPUT,
    @LastName = @LName OUTPUT,
    @Email = @Email OUTPUT,
    @IsFound = @Found OUTPUT;

IF @Found = 1
    SELECT @FName as FirstName, @LName as LastName, @Email as Email;
ELSE
    PRINT 'Person not found';


--
exec sp_UpdatePerson
	@PersonID = 1,
	@FirstName = 'Ibrahem',
	@LastName = 'Saleh',
	@Email = 'ffff@gmail.com'


--
exec sp_DeletePerson
	@PersonID = 2;


--
declare @result int;

exec @result = sp_CheckPersonExists @PersonID = 1;

if @result = 1
	print 'Person exists.';
else
	print 'Person does not exists';


-- retrieve the text definition of a stored procedure
exec sp_helptext 'sp_CheckPersonExists';