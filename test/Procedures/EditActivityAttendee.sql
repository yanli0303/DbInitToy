CREATE PROCEDURE EditActivityAttendee
(
	@ActivityID INT,
	@AttendeeID INT,
	@JoinTime DATETIME,
	@IsCancelled INT, --0 mains NO.
	@CancelledTime DATETIME,
	@CancelledReason NVARCHAR(1024),
	@AttendeeSupervisorID INT
) 
AS
	DECLARE @IsExist INT
	SELECT @IsExist = COUNT(*) FROM ActivityAttendee WHERE ActivityID = @ActivityID AND AttendeeID = @AttendeeID

	IF @IsExist = 0 BEGIN--Insert		
		DECLARE @MaxAttendees INT, @AllowQueue INT
		SELECT @MaxAttendees = MaximumAttendees, @AllowQueue = AllowQueue FROM Activity WHERE ActivityID = @ActivityID

		IF @AllowQueue = 1 BEGIN
			INSERT INTO ActivityAttendee (ActivityID, AttendeeID, JoinTime, IsCancelled)
			VALUES (@ActivityID, @AttendeeID, @JoinTime, 0)
		END ELSE BEGIN
			DECLARE @CurAttendeeCount INT
			SELECT @CurAttendeeCount = COUNT(*) FROM ActivityAttendee WHERE ActivityID = @ActivityID AND IsCancelled = 0

			IF @CurAttendeeCount < @MaxAttendees BEGIN
				INSERT INTO ActivityAttendee (ActivityID, AttendeeID, JoinTime, IsCancelled)
				VALUES (@ActivityID, @AttendeeID, @JoinTime, 0)
			END ELSE BEGIN --@AllowQueue = 0(false) AND @CurAttendeeCount >= @MaxAttendees
				RETURN
			END
		END
	END ELSE BEGIN --Update
		UPDATE ActivityAttendee
		SET JoinTime = @JoinTime, IsCancelled = @IsCancelled, CancelledTime = @CancelledTime, 
			CancelledReason = @CancelledReason, AttendeeSupervisorID = @AttendeeSupervisorID
		WHERE ActivityID = @ActivityID AND AttendeeID = @AttendeeID
	END