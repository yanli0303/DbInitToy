/*
	Summary: Get all the groups that the specified user is in.
*/
CREATE PROCEDURE GetGroupsOfUser
(
	@UserID INT
)
AS
	SELECT G.* 
	FROM UserGroup AS UG 
		INNER JOIN [Group] AS G ON UG.GroupID = G.GroupID
	WHERE UG.UserID = @UserID
	ORDER BY G.Title ASC