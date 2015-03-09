CREATE PROCEDURE EditGroup
(
	@GroupID INT,
	@Title NVARCHAR(100),
	@CreatedBy INT,
	@Description NVARCHAR(500)
)
AS
	IF @GroupID <= 0 --New
		INSERT INTO [Group] (Title, CreatedBy, Description)
		VALUES (@Title, @CreatedBy, @Description)
	ELSE --Update
		UPDATE [Group]
		SET Title = @Title, CreatedBy = @CreatedBy, Description = @Description
		WHERE GroupID = @GroupID