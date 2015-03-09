/*
	Summary: Get all users of a group
*/
CREATE PROCEDURE GetUsersOfGroup
(
	@GroupID INT
)
AS
	SELECT U.* 
	FROM UserGroup AS UG 
		INNER JOIN [User] AS U ON UG.UserID = U.UserID 
	WHERE UG.GroupID = @GroupID
	ORDER BY U.DisplayName ASC