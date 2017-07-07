
----------------------------------------------------------------------------------------------------------------------
-- Method 1 - For XML
----------------------------------------------------------------------------------------------------------------------

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


