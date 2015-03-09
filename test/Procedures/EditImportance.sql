CREATE PROCEDURE EditImportance
(
	@ImportanceID INT,
	@Title VARCHAR(50),
	@Description NVARCHAR(500)
) 
AS
	IF @ImportanceID <= 0 --New
		INSERT INTO Importance (Title, Description) VALUES (@Title, @Description)
	ELSE --Update
		UPDATE Importance 
		SET Title = @Title, Description = @Description
		WHERE ImportanceID = @ImportanceID