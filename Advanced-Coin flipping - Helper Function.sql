-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE MaxConsecutiveHeadsFlipForPlayer
	-- Add the parameters for the stored procedure here
	@PlayerName varchar(50),
	@SideSelection varchar(50)
AS
BEGIN
WIth OnePlayer as
(
	SELECT 
		cast(ROW_NUMBER()over(order by  [time of flip]) as int) as id
		,[time of flip]
		,[flipper]
		,[flip result]
	FROM [80Twenty].[dbo].[coin flippling]
	where flipper = @PlayerName
),
addMarkers as 
(
	Select 
		ROW_NUMBER()over(order by  [time of flip]) as id
		,[flipper]
		,[time of flip]
		,[flip result]
		,1 as Repetition 
		,1 as Marker 
	from OnePlayer
),
AnalayseConsecutiveFlips as
(
	--ANCHOR
	select top 1 cast(id as int) id,[flipper],[time of flip],[flip result],1 as Repetition ,1 as Marker  
	from addMarkers 
	order by id

	union all

	--Recursive Member
	select 
		a.id
		,a.[flipper]
		,a.[time of flip] 
		,a.[flip result]
		--Check consecutive and adjust markers
		, case when a.[flip result] = c.[flip result] then Repetition + 1 else 1 end  
		, case when a.[flip result] = c.[flip result] then c.Marker else  Marker + 1 end

	from 
	OnePlayer a
	inner join AnalayseConsecutiveFlips c 
	on a.id = c.id + 1

)
,FindLongChains as 
(
	select 
		*
		,ROW_NUMBER()over(partition by marker order by id desc) as lastBeforechainBroken 
	from AnalayseConsecutiveFlips 
	
)
--ANSWER
Select top 1
	[flipper] 
	,[flip result]
	,Repetition 
from FindLongChains 
where 
	lastBeforechainBroken=1
	and
	[flip result] = @SideSelection
order by Repetition desc
--Very Important to set max recusion with is set to 100 by default
OPTION(MAXRECURSION 1000) 

END
GO
