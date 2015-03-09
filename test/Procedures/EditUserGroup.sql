--Just New UserGroup, NOT NECESSARY to update
CREATE PROCEDURE EditUserGroup
(
	@UserID INT,
	@GroupID INT
)
AS
	INSERT INTO UserGroup (UserID, GroupID)  
	VALUES (@UserID, @GroupID)