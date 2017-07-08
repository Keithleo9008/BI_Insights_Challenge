--create table #t (Id int, Name char)

--insert into #t values
--(1, 'A'),
--(2, 'A'),
--(3, 'B'),
--(4, 'B'),
--(5, 'B'),
--(6, 'B'),
--(7, 'C'),
--(8, 'B'),
--(9, 'B')

--Select * from  #t

 ;With addMarkers as
(
	select 
		ROW_NUMBER()over(order by id) as id
		, name
		,1 as Repetition 
		,1 as Marker  
	from #t
)
, CTE as
(
	select top 1 cast(id as int) id, name,1 as Repetition ,1 as Marker  
	from addMarkers 
	order by id

	union all

	select 
		a.id 
		,a.name
		, case when a.name = c.name then Repetition + 1 else 1 end  
		, case when a.name = c.name then c.Marker else  Marker + 1 end
	from 
	#t a
	inner join CTE c 
	on a.id = c.id + 1

)
,CTE1 as
(
	select 
	*
		,ROW_NUMBER()over(partition by marker order by id desc) as rn 
	from cte c
)
select 
	Name
	,Repetition 
from cte1 
where 
	rn=1