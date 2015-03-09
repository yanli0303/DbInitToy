CREATE PROCEDURE DeleteByID
(
	@IDColName VARCHAR(50),
    @IDColValue INT,
    @TableName VARCHAR(50)
)
AS
	DECLARE @SQL VARCHAR(200)
	SET @SQL = 'DELETE FROM [' + @TableName + '] WHERE [' + @IDColName + '] = ' + CAST(@IDColValue AS VARCHAR(10))

	EXECUTE @SQL