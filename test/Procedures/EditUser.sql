CREATE PROCEDURE EditUser
(
	@UserID INT,
	@Alias VARCHAR(20),
	@DisplayName NVARCHAR(100),
	@Email NVARCHAR(100)
) 
AS
	IF @UserID <= 0 --New User
		INSERT INTO [User] (Alias, DisplayName, Email) 
		VALUES (@Alias, @DisplayName, @Email)
	ELSE --Update User Info
		UPDATE [User] 
		SET DisplayName = @DisplayName, Email = @Email , Alias = @Alias
		WHERE UserID = @UserID