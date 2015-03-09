IF OBJECT_ID ('dbo.Activity') IS NOT NULL
	DROP TABLE dbo.Activity
GO

CREATE TABLE Activity
(
	ActivityID INT IDENTITY NOT NULL,
	Title NVARCHAR(500) NOT NULL,
	Description NVARCHAR(MAX) NULL,
	StartTime DATETIME NULL,
	EndTime DATETIME NULL,
	PriorityID INT NOT NULL,-- DEFAULT (2)
	ImportanceID INT NOT NULL,-- DEFAULT (2)
	MaximumAttendees INT NOT NULL, --0 Mains not limited.
	Place NVARCHAR(500) NOT NULL,
	OrganizerID INT NOT NULL,
	PresenterID INT NULL,
	AllowQueue INT NOT NULL, --DEFAULT (1), 1 mains yes

	CONSTRAINT PK_Activity PRIMARY KEY (ActivityID ASC),
	CONSTRAINT FK_Activity_User_Organizer FOREIGN KEY (OrganizerID) REFERENCES [User](UserID),
	CONSTRAINT FK_Activity_User_Presenter FOREIGN KEY (PresenterID) REFERENCES [User](UserID)
)
GO;
go;
Go;
gO;
GO
go
Go
gO