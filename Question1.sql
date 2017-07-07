
Create VIEW [dbo].[Q1]
as
With dateDate as 
(
SELECT 
convert(Date,Replace([date of birth],'_','-')) as [date of birth]
,[number of people]
 FROM [80Twenty].[dbo].[Q1_birthday_challenge3]
)
Select
	[date of birth]
	,dateDiff(year,[date of birth],getdate()) as Age
	,day([date of birth]) as [Day]
	,month([date of birth]) as [Month]
	,DATENAME(month, [date of birth]) AS 'Month Name'
	,DATENAME(year, [date of birth]) AS 'Year'
	,[number of people]
	--year([date of birth]) as [Year]
FROM dateDate
GO


