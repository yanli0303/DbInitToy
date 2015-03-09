CREATE PROCEDURE GetByID
(
	@IDColName VARCHAR(50),
    @IDColValue INT,
    @TableName VARCHAR(50)
)
AS
	DECLARE @SQL VARCHAR(200)
	SET @SQL = 'SELECT TOP 1 * FROM [' + @TableName + '] WHERE [' + @IDColName + '] = ' + CAST(@IDColValue AS VARCHAR(10))

	EXECUTE @SQL