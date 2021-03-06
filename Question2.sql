
----------------------------------------------------------------------------------------------------------------------
-- Method 1 
----------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------
-- Ageband 
------------------------------------------------------------------

with aggregated as
(
	SELECT [ageband],
			count(*) as [Count],
		    STUFF((SELECT ',' + rtrim(convert(char(10),[id]))
				FROM   [80Twenty].[dbo].[Q2_survey] b
				WHERE  a.[ageband] = b.[ageband]
				FOR XML PATH('')),1,1,'') as [Id's]
	FROM [80Twenty].[dbo].[Q2_survey] a
	GROUP BY [ageband]
)
Select 
	B.[descr], A.[Count], A.[Id's]
FROM aggregated a
	left Outer join [80Twenty].[dbo].[Q2_key] as b
	on a.ageband = b.lookup

------------------------------------------------------------------
-- Gender 
------------------------------------------------------------------

with aggregated as
(
	SELECT [gender],
			count(*) as [Count],
		    STUFF((SELECT ',' + rtrim(convert(char(10),[id]))
				FROM   [80Twenty].[dbo].[Q2_survey] b
				WHERE  a.[gender] = b.[gender]
				FOR XML PATH('')),1,1,'') as [Id's]
	FROM [80Twenty].[dbo].[Q2_survey] a
	GROUP BY [gender]
)
Select 
	B.[descr], A.[Count], A.[Id's]
FROM aggregated a
	left Outer join [80Twenty].[dbo].[Q2_key] as b
	on a.[gender] = b.lookup


------------------------------------------------------------------
-- Education 
------------------------------------------------------------------

with aggregated as
(
	SELECT [education],
			count(*) as [Count],
		    STUFF((SELECT ',' + rtrim(convert(char(10),[id]))
				FROM   [80Twenty].[dbo].[Q2_survey] b
				WHERE  a.[education] = b.[education]
				FOR XML PATH('')),1,1,'') as [Id's]
	FROM [80Twenty].[dbo].[Q2_survey] a
	GROUP BY [education]
)
Select 
	B.[descr], A.[Count], A.[Id's]
FROM aggregated a
	left Outer join [80Twenty].[dbo].[Q2_key] as b
	on a.[education] = b.lookup

----------------------------------------------------------------------------------------------------------------------
-- Method 2 - Dynamic Parametrised Sql
----------------------------------------------------------------------------------------------------------------------

-- Not yet implemented