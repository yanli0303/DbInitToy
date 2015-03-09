CREATE PROCEDURE ActivityAttendeeGetByID
(
	@ActivityID INT,
	@AttendeeID INT
)
AS
	SELECT * FROM ActivityAttendee WHERE ActivityID = @ActivityID AND AttendeeID = @AttendeeID