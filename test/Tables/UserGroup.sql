IF OBJECT_ID ('dbo.UserGroup') IS NOT NULL
	DROP TABLE dbo.UserGroup
GO

CREATE TABLE UserGroup
(
	UserID INT NOT NULL,
	GroupID INT NOT NULL,

	CONSTRAINT PK_UserGroup PRIMARY KEY (UserID ASC, GroupID ASC),
	CONSTRAINT FK_UserGroup_User FOREIGN KEY (UserID) REFERENCES [User](UserID),
	CONSTRAINT FK_UserGroup_Group FOREIGN KEY (GroupID) REFERENCES [Group](GroupID)
)
GO