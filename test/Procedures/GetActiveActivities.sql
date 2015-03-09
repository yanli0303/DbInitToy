CREATE PROCEDURE GetActiveActivities
AS
	SELECT *
	FROM Activity
	WHERE EndTime >= GetDate()
	ORDER BY Title ASC