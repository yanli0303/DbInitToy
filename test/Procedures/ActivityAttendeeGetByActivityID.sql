CREATE PROCEDURE ActivityAttendeeGetByActivityID
(
	@ActivityID INT
)
AS
	SELECT * FROM ActivityAttendee WHERE ActivityID = @ActivityID ORDER BY JoinTime ASC
