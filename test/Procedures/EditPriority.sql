CREATE PROCEDURE EditPriority
(
	@PriorityID INT,
	@Title VARCHAR(50),
	@Description NVARCHAR(500)
) 
AS
	IF @PriorityID <= 0 --New
		INSERT INTO Priority (Title, Description) VALUES (@Title, @Description)
	ELSE --Update
		UPDATE Priority 
		SET Title = @Title, Description = @Description
		WHERE PriorityID = @PriorityID