IF OBJECT_ID ('dbo.Importance') IS NOT NULL
	DROP TABLE dbo.Importance
GO

CREATE TABLE Importance
(
	ImportanceID INT NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	Description NVARCHAR(500) NULL,

	CONSTRAINT PK_Importance PRIMARY KEY (ImportanceID ASC)
)
GO

INSERT INTO Importance (ImportanceID, Title) VALUES (3, 'Very Important')
INSERT INTO Importance (ImportanceID, Title) VALUES (2, 'Important')
INSERT INTO Importance (ImportanceID, Title) VALUES (1, 'Normal')
INSERT INTO Importance (ImportanceID, Title) VALUES (0, 'Not Important')
GO