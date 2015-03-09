CREATE PROCEDURE UserGroupDeleteByID
(
	@UserID INT,
	@GroupID INT
)
AS
	DELETE FROM UserGroup WHERE UserID = @UserID AND GroupID = @GroupID 