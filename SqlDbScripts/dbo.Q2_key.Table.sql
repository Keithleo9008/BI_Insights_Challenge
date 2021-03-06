USE [80Twenty]
GO
/****** Object:  Table [dbo].[Q2_key]    Script Date: 07/07/2017 8:34:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Q2_key](
	[lookup] [varchar](50) NULL,
	[descr] [varchar](50) NULL
) ON [PRIMARY]

GO
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'1', N'20-29')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'2', N'30-39')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'3', N'40-49')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'4', N'50-59')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'5', N'male')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'6', N'female')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'7', N'none')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'8', N'primary')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'9', N'secondary')
INSERT [dbo].[Q2_key] ([lookup], [descr]) VALUES (N'10', N'tertiary')
