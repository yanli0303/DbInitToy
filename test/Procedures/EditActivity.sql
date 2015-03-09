CREATE PROCEDURE EditActivity
(
	@ActivityID INT,
	@Title NVARCHAR(500),
	@Description NVARCHAR(MAX),
	@StartTime DATETIME,
	@EndTime DATETIME,
	@PriorityID INT,
	@ImportanceID INT,
	@MaximumAttendees INT, --0 Mains not limited.
	@Place NVARCHAR(500),
	@OrganizerID INT,
	@PresenterID INT,
	@AllowQueue INT
)
AS
	IF @ActivityID <= 0 BEGIN--New Activity
		INSERT INTO Activity (Title, Description, StartTime, EndTime, PriorityID, 
					ImportanceID, MaximumAttendees, Place, OrganizerID, PresenterID, AllowQueue)
		VALUES (@Title, @Description, @StartTime, @EndTime, @PriorityID, 
				@ImportanceID, @MaximumAttendees, @Place, @OrganizerID, @PresenterID, @AllowQueue)
	END ELSE BEGIN
		UPDATE Activity 
		SET Title = @Title, Description = @Description, StartTime = @StartTime, EndTime = @EndTime, PriorityID = @PriorityID, 
			ImportanceID = @ImportanceID, MaximumAttendees = @MaximumAttendees, Place = @Place, OrganizerID = @OrganizerID, 
			PresenterID = @PresenterID, AllowQueue = @AllowQueue
		WHERE ActivityID = @ActivityID
	END