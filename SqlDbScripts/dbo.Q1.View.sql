USE [80Twenty]
GO
/****** Object:  View [dbo].[Q1]    Script Date: 07/07/2017 8:34:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[Q1]
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
	,month([date of birth]) as [Month]
	,DATENAME(month, [date of birth]) AS 'Month Name'
	,DATENAME(year, [date of birth]) AS 'Year'
	,[number of people]
	--year([date of birth]) as [Year]
FROM dateDate
GO
