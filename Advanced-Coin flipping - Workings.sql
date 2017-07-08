
	Drop table #OnePlayer

	SELECT 
		cast(ROW_NUMBER()over(order by  [time of flip]) as int) as id
		,[time of flip]
		,[flipper]
		,[flip result]
		INTO #OnePlayer
	  FROM [80Twenty].[dbo].[coin flippling]
	  where flipper = 'Helen'

	Drop table #addMarkers

	select 
		ROW_NUMBER()over(order by  [time of flip]) as id
		,[flipper]
		,[time of flip]
		,[flip result]
		,1 as Repetition 
		,1 as Marker 
	into #addMarkers
	from #OnePlayer


;
Drop table  #Results;
WITH AnalayseConsecutiveFlips as
(
	--ANCHOR
	select top 1 cast(id as int) id,[time of flip],[flip result],1 as Repetition ,1 as Marker  
	from #addMarkers 
	order by id

	union all

	--Recursive Member
	select 
		a.id
		,a.[time of flip] 
		,a.[flip result]
		--Check consecutive and adjust markers
		, case when a.[flip result] = c.[flip result] then Repetition + 1 else 1 end  
		, case when a.[flip result] = c.[flip result] then c.Marker else  Marker + 1 end

	from 
	#OnePlayer a
	inner join AnalayseConsecutiveFlips c 
	on a.id = c.id + 1

)
Select * 
INTO #Results
from AnalayseConsecutiveFlips OPTION  ( MAXRECURSION 1000 ) 

select * from #Results

Drop table  #FindLongChains;
	
select 
	*
	,ROW_NUMBER()over(partition by marker order by id desc) as lastBeforechainBroken 
INTO #FindLongChains
from #Results c
order by id

Select * FROM #FindLongChains

select 
	[flip result]
	,Repetition 
from #FindLongChains 
where 
	lastBeforechainBroken=1
	OPTION  ( MAXRECURSION 1000 )


--Find max for heads only

Select top 1 
	[flip result]
	,Repetition 
from #FindLongChains 
where 
	lastBeforechainBroken=1
	and
	[flip result] = 'H'
order by Repetition desc

