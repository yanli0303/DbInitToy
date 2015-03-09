CREATE PROCEDURE ActivityAttendeeDeleteByID
(
	@ActivityID INT,
	@AttendeeID INT
)
AS
	DELETE FROM ActivityAttendee WHERE ActivityID = @ActivityID AND AttendeeID = @AttendeeID