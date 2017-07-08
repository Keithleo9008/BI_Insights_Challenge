DECLARE @name VARCHAR(50) 

DECLARE db_cursor CURSOR FOR  
	SELECT distinct [flipper]
    FROM [dbo].[coin flippling]

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN   
      
	  Exec MaxConsecutiveHeadsFlipForPlayer  @name ,'H'
	  FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor






