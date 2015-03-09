IF OBJECT_ID ('dbo.Priority') IS NOT NULL
	DROP TABLE dbo.Priority
GO

CREATE TABLE Priority
(
	PriorityID INT NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Description NVARCHAR(500) NULL,
	
	CONSTRAINT PK_Priority PRIMARY KEY (PriorityID ASC)
)
GO

INSERT INTO Priority (PriorityID, Title) VALUES (0, 'Urgent')
INSERT INTO Priority (PriorityID, Title) VALUES (1, 'Above Normal')
INSERT INTO Priority (PriorityID, Title) VALUES (2, 'Normal')
INSERT INTO Priority (PriorityID, Title) VALUES (3, 'Below Normal')
INSERT INTO Priority (PriorityID, Title) VALUES (4, 'Low')
GO