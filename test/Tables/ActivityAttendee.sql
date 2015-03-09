IF OBJECT_ID ('dbo.ActivityAttendee') IS NOT NULL
	DROP TABLE dbo.ActivityAttendee
GO

CREATE TABLE ActivityAttendee
(
	ActivityID INT NOT NULL,
	AttendeeID INT NOT NULL,
	JoinTime DATETIME NOT NULL,
	IsCancelled INT NOT NULL, --0 mains NO.
	CancelledTime DATETIME NULL,
	CancelledReason NVARCHAR(1024) NULL,
	AttendeeSupervisorID INT NULL,
	
	CONSTRAINT PK_ActivityAttendee PRIMARY KEY(ActivityID ASC, AttendeeID ASC),
	CONSTRAINT FK_ActivityAttendee_Activity FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID),
	CONSTRAINT FK_ActivityAttendee_User_AttendeeID FOREIGN KEY (AttendeeID) REFERENCES [User](UserID),
	CONSTRAINT FK_ActivityAttendee_User_AttendeeSupervisorID FOREIGN KEY (AttendeeSupervisorID) REFERENCES [User](UserID)
)
GO