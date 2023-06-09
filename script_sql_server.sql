USE [TP_BI_DW]
GO
/****** Object:  User [NT Service\MSSQLServerOLAPService]    Script Date: 30/05/2021 11:38:58 ******/
CREATE USER [NT Service\MSSQLServerOLAPService] FOR LOGIN [NT SERVICE\MSSQLServerOLAPService] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT Service\MSSQLServerOLAPService]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT Service\MSSQLServerOLAPService]
GO
/****** Object:  Table [dbo].[DimCustomer]    Script Date: 30/05/2021 11:38:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCustomer](
	[Customer_ID] [varchar](255) NOT NULL,
	[Customer_Name] [varchar](255) NULL,
 CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimLocation]    Script Date: 30/05/2021 11:38:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimLocation](
	[Location_ID] [varchar](255) NOT NULL,
	[Name] [varchar](255) NULL,
	[County] [varchar](255) NULL,
	[State_Code] [varchar](255) NULL,
	[State] [varchar](255) NULL,
	[Type] [varchar](255) NULL,
	[Latitude] [numeric](9, 6) NULL,
	[Longitude] [numeric](10, 6) NULL,
	[Population] [int] NULL,
	[Households] [int] NULL,
 CONSTRAINT [PK_DimLocation] PRIMARY KEY CLUSTERED 
(
	[Location_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimProduct]    Script Date: 30/05/2021 11:38:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProduct](
	[Product_ID] [varchar](255) NOT NULL,
	[Product_Name] [varchar](255) NULL,
	[Cost] [numeric](9, 2) NULL,
	[Original_Sale_Price] [numeric](9, 2) NULL,
	[Discount] [numeric](9, 2) NULL,
	[Current_Price] [numeric](9, 2) NULL,
	[Taxes] [numeric](9, 2) NULL,
 CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED 
(
	[Product_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSalesPeople]    Script Date: 30/05/2021 11:38:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSalesPeople](
	[Salesperson_ID] [varchar](255) NOT NULL,
	[Salesperson_Name] [varchar](255) NULL,
 CONSTRAINT [PK_DimSalesPeople] PRIMARY KEY CLUSTERED 
(
	[Salesperson_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTime]    Script Date: 30/05/2021 11:38:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTime](
	[Date] [date] NOT NULL,
	[Day] [tinyint] NOT NULL,
	[DaySuffix] [char](2) NOT NULL,
	[Weekday] [tinyint] NOT NULL,
	[WeekDayName] [varchar](10) NOT NULL,
	[WeekDayName_Short] [char](3) NOT NULL,
	[WeekDayName_FirstLetter] [char](1) NOT NULL,
	[DOWInMonth] [tinyint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[WeekOfMonth] [tinyint] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[MonthName] [varchar](10) NOT NULL,
	[MonthName_Short] [char](3) NOT NULL,
	[MonthName_FirstLetter] [char](1) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[Year] [int] NOT NULL,
	[MMYYYY] [char](6) NOT NULL,
	[MonthYear] [char](7) NOT NULL,
	[IsWeekend] [bit] NOT NULL,
 CONSTRAINT [PK_DimTime] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactSales]    Script Date: 30/05/2021 11:38:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactSales](
	[Order_ID] [varchar](255) NOT NULL,
	[Product_ID] [varchar](255) NULL,
	[Location_ID] [varchar](255) NULL,
	[Sales_Person_ID] [varchar](255) NULL,
	[Customer_ID] [varchar](255) NULL,
	[Purchase_Date] [date] NULL,
	[Quantity] [int] NULL,
	[Price] [int] NULL,
 CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED 
(
	[Order_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_DimCustomer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[DimCustomer] ([Customer_ID])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_DimCustomer]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_DimLocation] FOREIGN KEY([Location_ID])
REFERENCES [dbo].[DimLocation] ([Location_ID])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_DimLocation]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_DimProduct] FOREIGN KEY([Product_ID])
REFERENCES [dbo].[DimProduct] ([Product_ID])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_DimProduct]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_DimSalesPeople] FOREIGN KEY([Sales_Person_ID])
REFERENCES [dbo].[DimSalesPeople] ([Salesperson_ID])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_DimSalesPeople]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_FactSales_DimTime] FOREIGN KEY([Purchase_Date])
REFERENCES [dbo].[DimTime] ([Date])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_FactSales_DimTime]
GO
