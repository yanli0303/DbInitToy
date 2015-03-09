CREATE PROCEDURE UserGetByAlias
(
	@Alias VARCHAR(20)
)
AS
	SELECT * FROM [User] WHERE Alias = @Alias