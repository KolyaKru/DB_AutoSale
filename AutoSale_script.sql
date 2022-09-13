USE [master]
GO
/****** Object:  Database [AutoSale]    Script Date: 02.04.2022 14:40:00 ******/
CREATE DATABASE [AutoSale]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AutoSale', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AutoSale.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AutoSale_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AutoSale_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AutoSale] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AutoSale].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AutoSale] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AutoSale] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AutoSale] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AutoSale] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AutoSale] SET ARITHABORT OFF 
GO
ALTER DATABASE [AutoSale] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AutoSale] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AutoSale] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AutoSale] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AutoSale] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AutoSale] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AutoSale] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AutoSale] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AutoSale] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AutoSale] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AutoSale] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AutoSale] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AutoSale] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AutoSale] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AutoSale] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AutoSale] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AutoSale] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AutoSale] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AutoSale] SET  MULTI_USER 
GO
ALTER DATABASE [AutoSale] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AutoSale] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AutoSale] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AutoSale] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AutoSale] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AutoSale] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'AutoSale', N'ON'
GO
ALTER DATABASE [AutoSale] SET QUERY_STORE = OFF
GO
USE [AutoSale]
GO
/****** Object:  User [Kolya]    Script Date: 02.04.2022 14:40:01 ******/
CREATE USER [Kolya] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Kolya]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cars](
	[IDCar] [int] NOT NULL,
	[IDType] [int] NOT NULL,
	[IDSupplierMark] [int] NOT NULL,
	[Mark] [varchar](20) NULL,
	[Model] [varchar](20) NOT NULL,
	[Year] [int] NOT NULL,
	[Generation] [varchar](20) NOT NULL,
	[MileAge] [int] NOT NULL,
	[Engine] [numeric](2, 1) NOT NULL,
	[TypeEngine] [varchar](10) NOT NULL,
	[HorsePower] [int] NOT NULL,
	[GearBox] [varchar](10) NOT NULL,
	[Transmission] [varchar](10) NOT NULL,
	[Equipment] [varchar](40) NOT NULL,
	[VIN] [varchar](20) NOT NULL,
	[Price] [numeric](10, 0) NOT NULL,
	[Photo] [image] NULL,
 CONSTRAINT [PK_Cars] PRIMARY KEY CLUSTERED 
(
	[IDCar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Types]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Types](
	[IDType] [int] NOT NULL,
	[Category] [varchar](30) NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_Types] PRIMARY KEY CLUSTERED 
(
	[IDType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[View_CarsAutoSale]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_CarsAutoSale]
AS
SELECT        TOP (100) PERCENT dbo.Cars.Mark AS Марка, dbo.Cars.Model AS Модель, dbo.Types.Category AS [Тип кузова], dbo.Cars.Year AS Год, 
                         dbo.Cars.Generation AS Поколение, dbo.Cars.MileAge AS Пробег, dbo.Cars.Engine AS [Объём двигателя], dbo.Cars.TypeEngine AS [Тип двигателя], 
                         dbo.Cars.HorsePower AS Мощность, dbo.Cars.GearBox AS [Коробка передач], dbo.Cars.Transmission AS Привод, dbo.Cars.Equipment AS Комплектация, 
                         dbo.Cars.VIN, dbo.Cars.Price AS [Цена, $]
FROM            dbo.Cars INNER JOIN
                         dbo.Types ON dbo.Cars.IDType = dbo.Types.IDType
GO
/****** Object:  Table [dbo].[Ordered]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ordered](
	[IDOrder] [int] NOT NULL,
	[IDCar] [int] NOT NULL,
	[DiscountPercent] [numeric](3, 1) NULL,
	[Discount] [numeric](10, 1) NULL,
	[TotalPrice] [numeric](10, 1) NULL,
 CONSTRAINT [PK_Ordered] PRIMARY KEY CLUSTERED 
(
	[IDOrder] ASC,
	[IDCar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clients](
	[IDClient] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[SurName] [varchar](20) NOT NULL,
	[Address] [varchar](60) NOT NULL,
	[City] [varchar](20) NOT NULL,
	[IIndex] [varchar](20) NOT NULL,
	[Telephone] [varchar](50) NOT NULL,
	[Country] [varchar](30) NOT NULL,
	[Fax] [varchar](30) NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[IDOrder] [int] NOT NULL,
	[IDClient] [int] NOT NULL,
	[IDEmployee] [int] NOT NULL,
	[DateAccomodation] [date] NULL,
	[DatePurpose] [date] NOT NULL,
	[DateExecution] [date] NOT NULL,
	[IDDelivery] [int] NOT NULL,
	[CostDelivery] [numeric](10, 1) NOT NULL,
	[Address] [varchar](60) NULL,
	[CityAddressee] [varchar](20) NULL,
	[IndexAddressee] [varchar](10) NULL,
	[CountryAddressee] [varchar](20) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[IDOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[View_ClientsOrderedCars]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ClientsOrderedCars]
AS
SELECT        dbo.Clients.Name AS Имя, dbo.Clients.SurName AS Фамилия, dbo.Clients.Telephone AS Телефон, dbo.Cars.Mark AS Марка, dbo.Cars.Model AS Модель
FROM            dbo.Clients INNER JOIN
                         dbo.Orders ON dbo.Clients.IDClient = dbo.Orders.IDClient INNER JOIN
                         dbo.Ordered ON dbo.Orders.IDOrder = dbo.Ordered.IDOrder INNER JOIN
                         dbo.Cars ON dbo.Ordered.IDCar = dbo.Cars.IDCar
GO
/****** Object:  View [dbo].[View_TotalPriceOrderedClients]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_TotalPriceOrderedClients]
AS
SELECT        dbo.Clients.Name AS 'Имя', dbo.Clients.SurName AS 'Фамилия', SUM(dbo.Ordered.TotalPrice) AS 'Общая стоимость заказа, $'
FROM            dbo.Orders INNER JOIN
                         dbo.Clients ON dbo.Orders.IDClient = dbo.Clients.IDClient INNER JOIN
                         dbo.Ordered ON dbo.Orders.IDOrder = dbo.Ordered.IDOrder INNER JOIN
                         dbo.Cars ON dbo.Ordered.IDCar = dbo.Cars.IDCar
GROUP BY dbo.Clients.Name, dbo.Clients.SurName
GO
/****** Object:  View [dbo].[View_CarsOrdered]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_CarsOrdered]
AS
SELECT        dbo.Cars.Mark AS 'Марка', dbo.Cars.Model AS 'Модель', dbo.Cars.Year AS 'Год', dbo.Cars.VIN, dbo.Cars.Price AS 'Цена'
FROM            dbo.Orders INNER JOIN
                         dbo.Ordered ON dbo.Orders.IDOrder = dbo.Ordered.IDOrder INNER JOIN
                         dbo.Cars ON dbo.Ordered.IDCar = dbo.Cars.IDCar
GO
/****** Object:  Table [dbo].[SuppliersMarks]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SuppliersMarks](
	[IDSupplierMark] [int] NOT NULL,
	[Mark] [varchar](40) NOT NULL,
	[City] [varchar](20) NOT NULL,
	[IIndex] [varchar](20) NOT NULL,
	[Telephone] [varchar](50) NOT NULL,
	[Country] [varchar](30) NOT NULL,
	[Fax] [varchar](30) NULL,
 CONSTRAINT [PK_SuppliersMarks] PRIMARY KEY CLUSTERED 
(
	[IDSupplierMark] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[View_SuppliersMarksUSA]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SuppliersMarksUSA]
AS
SELECT        Mark AS 'Марка', City AS 'Город', IIndex AS 'Индекс', Telephone AS 'Телефон', Fax
FROM            dbo.SuppliersMarks
WHERE        (Country = 'США')
GO
/****** Object:  Table [dbo].[Deliveries]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Deliveries](
	[IDDelivery] [int] NOT NULL,
	[Title] [varchar](30) NOT NULL,
	[Telephone] [varchar](40) NOT NULL,
 CONSTRAINT [PK_Deliveries] PRIMARY KEY CLUSTERED 
(
	[IDDelivery] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[IDEmployee] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[SurName] [varchar](20) NOT NULL,
	[DateBirth] [date] NOT NULL,
	[DateHiring] [date] NOT NULL,
	[Address] [varchar](60) NOT NULL,
	[City] [varchar](20) NOT NULL,
	[IIndex] [varchar](10) NULL,
	[Country] [varchar](20) NOT NULL,
	[HomeTelephone] [varchar](30) NOT NULL,
	[AddTelephone] [varchar](30) NULL,
	[Photo] [text] NULL,
	[Note] [text] NULL,
	[Specialty] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[IDEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (1, 3, 1, N'Dodge', N'Challenger', 2018, N'III', 36500, CAST(6.4 AS Numeric(2, 1)), N'Бензин', 492, N'Автомат', N'Задний', N'R/T', N'2D4FV47T06H116955', CAST(70500 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (2, 4, 2, N'Ford', N'F-150', 2021, N'VII', 10, CAST(3.5 AS Numeric(2, 1)), N'Бензин', 375, N'Автомат', N'Полный', N'Super Crew', N'WF0VXXBDFV5R52021', CAST(100000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (3, 1, 3, N'BMW', N'520d', 2015, N'VI', 107000, CAST(2.0 AS Numeric(2, 1)), N'Дизель', 190, N'Автомат', N'Задний', N'Professional', N'WBADM6343YGU11738', CAST(23300 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (4, 11, 4, N'Mersedes-Benz', N'E300', 2021, N'V', 0, CAST(2.0 AS Numeric(2, 1)), N'Бензин', 249, N'Автомат', N'Задний', N'Sport', N'WDB1240191J016310', CAST(108000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (5, 5, 5, N'Jeep', N'Grand-Cherokee', 2018, N'IV(WK2)', 17000, CAST(6.2 AS Numeric(2, 1)), N'Бензин', 717, N'Автомат', N'Полный', N'Treackhawk', N'1C3H8B3R08Y132923', CAST(106000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (6, 5, 6, N'Land-Rover', N'Velar', 2018, N'I', 24000, CAST(2.0 AS Numeric(2, 1)), N'Бензин', 250, N'Автомат', N'Полный', N'R-Dynamic S', N'SALLMAM24AA328388', CAST(59700 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (7, 7, 7, N'Volvo', N'XC70', 2013, N'II', 67000, CAST(2.4 AS Numeric(2, 1)), N'Дизель', 163, N'Автомат', N'Полный', N'Kinetic', N'YV1744845K2659851', CAST(25570 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (8, 11, 8, N'Porsche', N'911', 2021, N'VIII', 0, CAST(3.0 AS Numeric(2, 1)), N'Бензин', 450, N'Робот', N'Полный', N'Targa 4S', N'WP0ZZZ99Z9S702047', CAST(244717 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (9, 2, 9, N'Mazda', N'3', 2011, N'II(BL)', 233900, CAST(1.6 AS Numeric(2, 1)), N'Бензин', 105, N'Механика', N'Передний', N'Active+', N'JMZGE124500024869', CAST(6390 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (10, 10, 10, N'Toyota', N'Alphard', 2015, N'III', 147000, CAST(2.5 AS Numeric(2, 1)), N'Гибрид', 152, N'Вариатор', N'Полный', N'Executive Lounge', N'TEBX9FJ6FK205291', CAST(32200 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (11, 6, 11, N'Cadillac', N'XT5', 2016, N'I', 41122, CAST(3.7 AS Numeric(2, 1)), N'Бензин', 314, N'Автомат', N'Полный', N'Comfort', N'1G1BL81E1LA325364', CAST(37600 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (12, 7, 12, N'Audi', N'RS6', 2014, N'III(C7)', 44000, CAST(4.0 AS Numeric(2, 1)), N'Бензин', 560, N'Автомат', N'Полный', N'Quattro Tiptronic', N'WAUZZZ8K0BA003806', CAST(61260 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (13, 2, 13, N'Subaru', N'Impresa WRX STi', 2011, N'III', 93950, CAST(2.5 AS Numeric(2, 1)), N'Бензин', 300, N'Механика', N'Полный', N'MT-AE', N'JF1BE5LJ3RG132569', CAST(20000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (14, 9, 14, N'Volkswagen', N'Crafter', 2014, N'I', 247500, CAST(2.0 AS Numeric(2, 1)), N'Дизель', 143, N'Механика', N'Задний', N'Kombi 3', N'WVGZZZ7LZ8D066977', CAST(17400 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (15, 5, 14, N'Volkswagen', N'Teramont', 2019, N'I', 27000, CAST(3.6 AS Numeric(2, 1)), N'Бензин', 249, N'Автомат', N'Полный', N'StarLine', N'WVGZZZ7LZ8D789632', CAST(44000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (16, 1, 3, N'BMW', N'M5 F90', 2018, N'VI', 41000, CAST(4.4 AS Numeric(2, 1)), N'Бензин', 600, N'Автомат', N'Полный', N'Perfomance', N'WBAFM6355YGU11737', CAST(91000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (17, 3, 2, N'Ford', N'Mustang', 2017, N'VI', 48000, CAST(2.3 AS Numeric(2, 1)), N'Бензин', 317, N'Автомат', N'Задний', N'Comfort', N'WF0VXXBDFV5R52017', CAST(28000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (18, 4, 1, N'Dodge', N'RAM', 2014, N'IV', 138000, CAST(5.7 AS Numeric(2, 1)), N'Бензин', 375, N'Автомат', N'Полный', N'Crew Cab', N'2D4FV47T06H456789', CAST(53500 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (19, 5, 5, N'Jeep', N'Wrangler', 2018, N'IV(JL)', 45000, CAST(2.0 AS Numeric(2, 1)), N'Бензин', 272, N'Автомат', N'Полный', N'GT Plus', N'1C3H8B3R08Y123456', CAST(39990 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (20, 5, 6, N'Land-Rover', N'Vogue', 2019, N'IV', 65000, CAST(3.0 AS Numeric(2, 1)), N'Бензин', 249, N'Автомат', N'Полный', N'SE', N'SALLMAM24AA132596', CAST(94900 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (21, 1, 9, N'Mazda', N'6', 2015, N'III(GJ)', 19500, CAST(2.5 AS Numeric(2, 1)), N'Бензин', 192, N'Автомат', N'Передний', N'Supreme Plus', N'JMZGJ124500085869', CAST(22700 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (22, 5, 7, N'Volvo', N'XC90', 2012, N'I', 178000, CAST(2.4 AS Numeric(2, 1)), N'Дизель', 200, N'Автомат', N'Полный', N'Executive', N'YV1744845K265555', CAST(22000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (23, 2, 8, N'Porsche', N'Panamera', 2015, N'I', 84000, CAST(3.6 AS Numeric(2, 1)), N'Бензин', 310, N'Робот', N'Полный', N'Bose', N'WP0ZZZ99Z9S708541', CAST(44700 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (24, 1, 10, N'Toyota', N'Camry', 2018, N'VIII(XV70)', 42000, CAST(3.5 AS Numeric(2, 1)), N'Бензин', 249, N'Автомат', N'Передний', N'Direct', N'TEBX9FJ6FK794613', CAST(32000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (25, 5, 4, N'Mersedes-Benz', N'G500', 2011, N'II', 194000, CAST(5.5 AS Numeric(2, 1)), N'Бензин', 388, N'Автомат', N'Полный', N'Rare', N'WDB1240191J0746352', CAST(39000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (26, 5, 11, N'Cadillac', N'Escalade', 2016, N'IV', 42530, CAST(6.2 AS Numeric(2, 1)), N'Бензин', 409, N'Автомат', N'Полный', N'Platinum', N'1G1BL81E1LA741258', CAST(50600 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (27, 1, 13, N'Subaru', N'Impresa WRX STi', 2014, N'I', 130000, CAST(2.5 AS Numeric(2, 1)), N'Бензин', 300, N'Механика', N'Полный', N'MT', N'JL1BE5LJ3RG165418', CAST(23400 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (28, 1, 14, N'Volkswagen', N'Polo', 2016, N'V', 97500, CAST(1.6 AS Numeric(2, 1)), N'Бензин', 110, N'Автомат', N'Передний', N'Luxe', N'WVGZZZ7LZ8D0698745', CAST(8500 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (29, 5, 1, N'Dodge', N'Durango', 2019, N'III', 53700, CAST(3.6 AS Numeric(2, 1)), N'Бензин', 294, N'Автомат', N'Задний', N'GT', N'2D4FV47T06H452178', CAST(51000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (30, 1, 10, N'Toyota', N'Accord', 2020, N'X', 8500, CAST(1.5 AS Numeric(2, 1)), N'Бензин', 192, N'Вариатор', N'Передний', N'HEV-EX', N'JHMEG33200S123456', CAST(33960 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Cars] ([IDCar], [IDType], [IDSupplierMark], [Mark], [Model], [Year], [Generation], [MileAge], [Engine], [TypeEngine], [HorsePower], [GearBox], [Transmission], [Equipment], [VIN], [Price], [Photo]) VALUES (31, 3, 1, N'Dodge', N'Charger', 2014, N'VI(LD)', 92000, CAST(6.4 AS Numeric(2, 1)), N'Бензин', 477, N'Автомат', N'Задний', N'SRT-8', N'2D4FV47T06H789654', CAST(34000 AS Numeric(10, 0)), NULL)
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (1, N'Андрей', N'Ханавин', N'ул. Бергуса 8', N'Лулео', N'S-958 22', N'0921-12 34 65', N'Швеция', N'0921-12')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (2, N'Виктория', N'Асворд', N'ул. Цикровая 33', N'Лондон', N'ЕС2 5N4T', N'(171) 555-1212', N'Великобритания', NULL)
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (3, N'Андрей', N'Шпак', N'ул. Кирова 33', N'Минск', N'220045', N'(33) 648-98-67', N'Беларусь', N'(33) 648-98-67')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (4, N'Лидия', N'Кулаева', N'ул. Эдальго 29', N'Берн', N'3012', N'0452-076545', N'Швейцария', NULL)
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (5, N'Роланд', N'Мендель', N'ул. Кировская 6', N'Трасс', N'8010', N'7675-3425', N'Авария', N'7675-3426')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (6, N'Мария', N'Ларсон', N'ул. Коргатая 24', N'Стокгольм', N'S-844 67', N'0695-34 67 2', N'Швеция', NULL)
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (7, N'Питер', N'Франкен', N'Берлинская пл. 43', N'Мюнхен', N'80805', N'089-0877310', N'Термания', N'089-087745')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (8, N'Мария', N'Хосе', N'ул. Палое 5', N'Каракас', N'108', N'(2) 283-295 Г', N'Венесуэла', N'(2) 283-3397')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (9, N'Николай', N'Бурлаков', N'ул. Краснознамёная 99', N'Брест', N'224001', N'(44) 666-99-66', N'Беларусь', N'(33) 648-99-67')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (10, N'Карлос', N'Хемандос', N'ул. Карлос 22', N'Сан-Кристобаль', N'5022', N'(5) 555-1340', N'Венесуэла', N'(5) 555-1948')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (11, N'Патрисия', N'Кемма', N'Джонстоун шоссе 8', N'Корк', N'4111', N'2967 542', N'Ирландия', N'2967 3333')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (12, N'Максим', N'Анищенко', N'Бодиварская 52', N'Bаркисимею', N'3508', N'(9) 331-6954', N'Венесуэла', N'(9) 331-7256')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (13, N'Джовани', N'Ровелли', N'ул. Людовика 22', N'Бергамо', N'24100', N'035-640230', N'Италия', N'035-640231')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (14, N'Александр', N'Боровик', N'ул. Беринговая 2743', N'Анкоридж', N'99508', N'(907) 555-7584', N'США', N'(907) 555- 2880')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (15, N'Игнат', N'Довидовский', N'Тачерстрасе 10', N'Берлин', N'01307', N'0372-035 188', N'Германия', NULL)
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (16, N'Андрей', N'Савельев', N'ул. Провинциальная 124', N'Реджио-Эмилио', N'42100', N'0522-556721', N'Италия', N'0522-556722')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (17, N'Юрий', N'Макаров', N'ул. Виа 11', N'Мадрид', N'28001', N'(91) 745 6200', N'Испания', N'(91) 745 6210')
GO
INSERT [dbo].[Clients] ([IDClient], [Name], [SurName], [Address], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (18, N'Александр', N'Гронский', N'ул. Кастро 414', N'Сан-Пауло', N'05634-030', N'(11) 555-2167', N'Бразилия', N'(11) 555-2168')
GO
INSERT [dbo].[Deliveries] ([IDDelivery], [Title], [Telephone]) VALUES (1, N'Домой (курьер)', N'(33) 972-98-31')
GO
INSERT [dbo].[Deliveries] ([IDDelivery], [Title], [Telephone]) VALUES (2, N'Пункт выдачи', N'(29) 211-99-31')
GO
INSERT [dbo].[Deliveries] ([IDDelivery], [Title], [Telephone]) VALUES (3, N'В наличии', N'(44) 696-99-66')
GO
INSERT [dbo].[Employees] ([IDEmployee], [Name], [SurName], [DateBirth], [DateHiring], [Address], [City], [IIndex], [Country], [HomeTelephone], [AddTelephone], [Photo], [Note], [Specialty]) VALUES (1, N'Николай', N'Бурлаков', CAST(N'1998-06-07' AS Date), CAST(N'2008-05-01' AS Date), N'ул. Краснознамёная 99', N'Брест', N'224001', N'Беларусь', N'(44) 666-99-66', N'(33) 666-99-66', NULL, NULL, N'Директор')
GO
INSERT [dbo].[Employees] ([IDEmployee], [Name], [SurName], [DateBirth], [DateHiring], [Address], [City], [IIndex], [Country], [HomeTelephone], [AddTelephone], [Photo], [Note], [Specialty]) VALUES (2, N'Анна', N'Крылова', CAST(N'1999-01-09' AS Date), CAST(N'2018-03-05' AS Date), N'ул. Лесная 12-456', N'Минск', N'105001', N'Беларусь', N'(017) 555-1189', N'124-2344', NULL, NULL, N'Администратор')
GO
INSERT [dbo].[Employees] ([IDEmployee], [Name], [SurName], [DateBirth], [DateHiring], [Address], [City], [IIndex], [Country], [HomeTelephone], [AddTelephone], [Photo], [Note], [Specialty]) VALUES (3, N'Мария', N'Белова', CAST(N'1992-12-08' AS Date), CAST(N'2008-05-01' AS Date), N'ул. Нефтяников 14-4', N'Минск', N'122981', N'Беларусь', N'(017) 555-9857', N'124-5467', NULL, NULL, N'Менеджер')
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11010, 2, CAST(0.0 AS Numeric(3, 1)), CAST(0.0 AS Numeric(10, 1)), CAST(1000000.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11010, 11, CAST(5.0 AS Numeric(3, 1)), CAST(1880.0 AS Numeric(10, 1)), CAST(35720.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11011, 21, CAST(5.0 AS Numeric(3, 1)), CAST(1135.0 AS Numeric(10, 1)), CAST(21565.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11012, 9, CAST(12.5 AS Numeric(3, 1)), CAST(798.8 AS Numeric(10, 1)), CAST(5591.2 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11013, 10, CAST(10.0 AS Numeric(3, 1)), CAST(3220.0 AS Numeric(10, 1)), CAST(28980.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11014, 3, CAST(10.0 AS Numeric(3, 1)), CAST(2330.0 AS Numeric(10, 1)), CAST(20970.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11015, 6, CAST(5.0 AS Numeric(3, 1)), CAST(2985.0 AS Numeric(10, 1)), CAST(56715.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11016, 16, CAST(5.0 AS Numeric(3, 1)), CAST(4550.0 AS Numeric(10, 1)), CAST(86450.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11017, 12, CAST(5.0 AS Numeric(3, 1)), CAST(3063.0 AS Numeric(10, 1)), CAST(58197.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11018, 14, CAST(12.5 AS Numeric(3, 1)), CAST(2175.0 AS Numeric(10, 1)), CAST(15225.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11019, 25, CAST(10.0 AS Numeric(3, 1)), CAST(3900.0 AS Numeric(10, 1)), CAST(35100.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11020, 30, CAST(0.0 AS Numeric(3, 1)), CAST(0.0 AS Numeric(10, 1)), CAST(33960.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11021, 1, CAST(5.0 AS Numeric(3, 1)), CAST(3525.0 AS Numeric(10, 1)), CAST(66975.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Ordered] ([IDOrder], [IDCar], [DiscountPercent], [Discount], [TotalPrice]) VALUES (11021, 31, CAST(7.5 AS Numeric(3, 1)), CAST(2550.0 AS Numeric(10, 1)), CAST(31450.0 AS Numeric(10, 1)))
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11010, 16, 2, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 2, CAST(28.7 AS Numeric(10, 1)), N'Тачеретрасс 10', N'Лондон', N'WX3 6FW', N'Великобритания')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11011, 6, 1, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 1, CAST(318.0 AS Numeric(10, 1)), N'ул. Мойте 34', N'Берлин', N'12209', N'Германия')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11012, 7, 2, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 3, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11013, 17, 3, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 1, CAST(33.0 AS Numeric(10, 1)), N'ул.Каталаяа 23', N'Мадрид', N'2800Г', N'Испания')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11014, 14, 2, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 3, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11015, 18, 1, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 2, CAST(4.6 AS Numeric(10, 1)), N'Бразильская пл. 442', N'Ставерен', N'4110', N'Норвегия')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11016, 7, 2, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 2, CAST(33.8 AS Numeric(10, 1)), N'ул. Джардем 32', N'Мюнхен', N'80805', N'Германия')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11017, 5, 3, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 2, CAST(754.0 AS Numeric(10, 1)), N'ул. Мерхеместа, 369', N'Юджин', N'97403', N'США')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11018, 16, 2, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 2, CAST(11.7 AS Numeric(10, 1)), N'Тачерстрасс 10', N'Лондон', N'WX3 6FW', N'Великобритания')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11019, 3, 3, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 3, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11020, 8, 1, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 2, CAST(43.3 AS Numeric(10, 1)), N'ул. Кэш 32 Г', N'Сан-Пауло', N'05432-043', N'Бразилия')
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11021, 9, 1, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-05' AS Date), CAST(N'2021-05-01' AS Date), 3, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Orders] ([IDOrder], [IDClient], [IDEmployee], [DateAccomodation], [DatePurpose], [DateExecution], [IDDelivery], [CostDelivery], [Address], [CityAddressee], [IndexAddressee], [CountryAddressee]) VALUES (11022, 5, 1, CAST(N'2021-05-19' AS Date), CAST(N'2021-03-08' AS Date), CAST(N'2021-03-09' AS Date), 3, CAST(0.0 AS Numeric(10, 1)), N'fas', N'asf', N'fas', N'saf')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (1, N'Dodge', N'Оберн-Хиллз', N'MI-48321', N'+1(248) 248-1047', N'США', N'+1(248) 248-1047')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (2, N'Ford', N'Дирборн', N'MI-48120', N'+1(313) 358-1849', N'США', N'+1(313) 358-1849')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (3, N'BMW', N'Мюнхен', N'80331', N'+49(89) 858-1669', N'Германия', N'+49(89) 858-1669')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (4, N'Mersedes-Benz', N'Штутгард', N'70173', N'+49(711) 631-8523', N'Германия', N'+49(711) 631-8523')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (5, N'Jeep', N'Толидо', N'OH-43601', N'+1(419) 568-9761', N'США', N'+1(419) 568-9761')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (6, N'Land-Rover', N'Уитни', N'OX28 1AA', N'+44(1993) 658-4654', N'Великобритания', N'+44(1993) 658-4654')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (7, N'Volvo', N'Гётеборг', N'405 30', N'+46(31) 888-9881', N'Швеция', N'+46(31) 888-9881')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (8, N'Porsche', N'Штудгард', N'70175', N'+49(711) 632-8628', N'Германия', N'+49(711) 632-8628')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (9, N'Mazda', N'Футю', N'183-0000', N'+81 (423) 596-3963', N'Япония', N'+81 (423) 596-3963')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (10, N'Toyota', N'Тоёта', N'471-8501', N'+81 (0565) 896-7963', N'Япония', N'+81 (0565) 896-7963')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (11, N'Cadillac', N'Детройт', N'MI-48201', N'+1(313) 654-4254', N'США', N'+1(313) 654-4254')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (12, N'Audi', N'Ингольштадт', N'85049', N'+49(0849) 688-8774', N'Германия', N'+49(0849) 688-8774')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (13, N'Subaru', N'Щибуя', N'150-8010', N'+81(3) 456-9862', N'Япония', N'+81(3) 456-9862')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (14, N'Volkswagen', N'Вольфсбург', N'38440', N'+49(5361) 633-6453', N'Германия', N'+49(5361) 633-6453')
GO
INSERT [dbo].[SuppliersMarks] ([IDSupplierMark], [Mark], [City], [IIndex], [Telephone], [Country], [Fax]) VALUES (15, N'Nissan', N'Иокогама', N'221-0001', N'+81 (995) 976-1315', N'Япония', N'+81 (423) 596-3963')
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (1, N'Седан', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (2, N'Хэтчбэк', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (3, N'Купе', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (4, N'Пикап', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (5, N'Внедорожник', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (6, N'Кроссовер', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (7, N'Универсал', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (8, N'Лимузин', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (9, N'Фургон', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (10, N'Минивэн', NULL)
GO
INSERT [dbo].[Types] ([IDType], [Category], [Description]) VALUES (11, N'Кабриолет', NULL)
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [FK_Cars_SuppliersMarks] FOREIGN KEY([IDSupplierMark])
REFERENCES [dbo].[SuppliersMarks] ([IDSupplierMark])
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [FK_Cars_SuppliersMarks]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [FK_Cars_Types] FOREIGN KEY([IDType])
REFERENCES [dbo].[Types] ([IDType])
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [FK_Cars_Types]
GO
ALTER TABLE [dbo].[Ordered]  WITH CHECK ADD  CONSTRAINT [FK_Ordered_Cars] FOREIGN KEY([IDCar])
REFERENCES [dbo].[Cars] ([IDCar])
GO
ALTER TABLE [dbo].[Ordered] CHECK CONSTRAINT [FK_Ordered_Cars]
GO
ALTER TABLE [dbo].[Ordered]  WITH CHECK ADD  CONSTRAINT [FK_Ordered_Orders] FOREIGN KEY([IDOrder])
REFERENCES [dbo].[Orders] ([IDOrder])
GO
ALTER TABLE [dbo].[Ordered] CHECK CONSTRAINT [FK_Ordered_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Clients] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Clients]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Deliveries] FOREIGN KEY([IDDelivery])
REFERENCES [dbo].[Deliveries] ([IDDelivery])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Deliveries]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([IDEmployee])
REFERENCES [dbo].[Employees] ([IDEmployee])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [CK_CarsEngine] CHECK  (([Engine]>(0)))
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [CK_CarsEngine]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [CK_CarsHorsePower] CHECK  (([HorsePower]>(0)))
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [CK_CarsHorsePower]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [CK_CarsMileAge] CHECK  (([MileAge]>=(0)))
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [CK_CarsMileAge]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [CK_CarsPrice] CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [CK_CarsPrice]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD  CONSTRAINT [CK_CarsYear] CHECK  (([Year]>=(2010)))
GO
ALTER TABLE [dbo].[Cars] CHECK CONSTRAINT [CK_CarsYear]
GO
/****** Object:  StoredProcedure [dbo].[CountClients]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[CountClients]
AS
SET NOCOUNT ON
SELECT  COUNT (IDClient) AS 'Количество клиентов'  
FROM dbo.Clients

 
GO
/****** Object:  StoredProcedure [dbo].[DateOrders]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[DateOrders]  
@datebegin date,
@dateend date
As
Set NOCOUNT ON
Select  IDOrder 'Номер заказа', IDClient as 'Номер клиента' ,DateAccomodation as 'Дата заказа' From dbo.Orders 
Where DateAccomodation BETWEEN @datebegin and @dateend
 
GO
/****** Object:  StoredProcedure [dbo].[SelectCar]    Script Date: 02.04.2022 14:40:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SelectCar]
@mark varchar (20)
As
Set NOCOUNT ON
Select Mark as 'Марка', Model as 'Модель', Types.Category as 'Тип кузова',
Year as 'Год', Generation as 'Поколение', MileAge as 'Пробег', Engine as 'Объём двигателя',
TypeEngine as 'Тип двигателя', GearBox as 'Коробка передач', Transmission as 'Привод', 
Equipment as 'Комплектация', VIN, Price as 'Цена, $'  
From Cars join Types
On Types.IDType = Cars.IDType
Where Cars.Mark = @mark 
 
GO
/****** Object:  Statistic [_WA_Sys_00000002_0F2D40CE]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_0F2D40CE] ON [dbo].[Cars]([IDType]) WITH STATS_STREAM = 0x0100000001000000000000000000000078F08A5500000000C3020000000000008302000000000000380300003800000004000A000000000000000000000000000700000008EE090018AD00001F000000000000001F00000000000000ABAAAA3ECDCCCC3D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000090000000100000014000000000080400000F841000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000017010000000000001F0100000000000048000000000000005F0000000000000076000000000000008D00000000000000A400000000000000BB00000000000000D200000000000000E9000000000000000001000000000000100014000000E040000000000000803F0100000004000010001400000040400000404000004040030000000400001000140000000040000000000000803F040000000400001000140000001041000000000000803F05000000040000100014000000803F000000000000803F060000000400001000140000000040000000000000803F07000000040000100014000000803F000000000000803F09000000040000100014000000803F000000000000803F0A0000000400001000140000000040000000000000803F0B0000000400001F00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000002_22AA2996]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_22AA2996] ON [dbo].[Cars]([IDType]) WITH STATS_STREAM = 0x010000000100000000000000000000002B34986900000000D3020000000000009302000000000000380300003800000004000A0000000000000000001F00000007000000C5ACF0006BAE00001F000000000000001F00000000000000ABAAAA3ECDCCCC3D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000090000000100000014000000000080400000F841000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001104000000000000000000000000000017010000000000001F01000000000000270100000000000048000000000000005F0000000000000076000000000000008D00000000000000A400000000000000BB00000000000000D200000000000000E9000000000000000001000000000000100014000000E040000000000000803F0100000004000010001400000040400000404000004040030000000400001000140000000040000000000000803F040000000400001000140000001041000000000000803F05000000040000100014000000803F000000000000803F060000000400001000140000000040000000000000803F07000000040000100014000000803F000000000000803F09000000040000100014000000803F000000000000803F0A0000000400001000140000000040000000000000803F0B0000000400001F000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_0F2D40CE]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000003_0F2D40CE] ON [dbo].[Cars]([IDSupplierMark]) WITH STATS_STREAM = 0x01000000010000000000000000000000C0E569B800000000C3020000000000008302000000000000380300003800000004000A000000000000000000380000000700000008EE090018AD00001F000000000000001F00000000000000E9A20B3F8988883D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000090000000100000014000000000080400000F841000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000017010000000000001F0100000000000048000000000000005F0000000000000076000000000000008D00000000000000A400000000000000BB00000000000000D200000000000000E90000000000000000010000000000001000140000008040000000000000803F010000000400001000140000000040000000400000004003000000040000100014000000004000000040000000400500000004000010001400000000400000004000000040070000000400001000140000000040000000400000004009000000040000100014000000004000000040000000400B0000000400001000140000004040000000000000803F0C0000000400001000140000000040000000000000803F0D000000040000100014000000803F0000803F0000803F0F0000000400001F00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_22AA2996]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000003_22AA2996] ON [dbo].[Cars]([IDSupplierMark]) WITH STATS_STREAM = 0x01000000010000000000000000000000ECF6934E00000000F202000000000000B202000000000000380300003800000004000A0000000000000000000000000007000000C4ACF0006BAE00001F000000000000001F000000000000000000003F2549923D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A0000000A0000000100000014000000000080400000F841000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001104000000000000000000000000000036010000000000003E010000000000004601000000000000500000000000000067000000000000007E000000000000009500000000000000AC00000000000000C300000000000000DA00000000000000F10000000000000008010000000000001F010000000000001000140000008040000000000000803F0100000004000010001400000000400000004000000040030000000400001000140000000040000000400000004005000000040000100014000000004000000040000000400700000004000010001400000000400000004000000040090000000400001000140000004040000000000000803F0A0000000400001000140000000040000000000000803F0B000000040000100014000000803F000000000000803F0C0000000400001000140000000040000000000000803F0D0000000400001000140000004040000000000000803F0E0000000400001F000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000004_0F2D40CE]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000004_0F2D40CE] ON [dbo].[Cars]([Mark]) WITH STATS_STREAM = 0x010000000100000000000000000000006C03A537000000002B04000000000000EB03000000000000A7020000A7000000140000000000000015D000000000000007000000731266012AAD00001F000000000000001F00000000000000CDCCCC3E2549923D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0000000C00000001000000100000002184D0400000F841000000002184D040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000000000000000000000000000C40100000000000077020000000000007F0200000000000060000000000000007B000000000000009500000000000000B400000000000000D000000000000000EB000000000000000C0100000000000028010000000000004C010000000000006A010000000000008701000000000000A801000000000000300010000000803F000000000000803F04000001001B00417564693000100000000040000000000000803F04000001001A00424D573000100000000040000000000000803F04000001001F00436164696C6C61633000100000008040000000000000803F04000001001C00446F6467653000100000000040000000000000803F04000001001B00466F726430001000000000400000004000000040040000010021004C616E642D526F7665723000100000000040000000000000803F04000001001C004D617A64613000100000000040000000000000803F040000010024004D657273656465732D42656E7A3000100000000040000000000000803F04000001001E00506F72736368653000100000000040000000000000803F04000001001D005375626172753000100000004040000040400000404004000001002100566F6C6B73776167656E3000100000000040000000000000803F04000001001C00566F6C766FFF01000000000000000B0000000B000000280000002800000000000000000000004300000041756469436164696C6C6163446F646765466F72644A6565704D617A6461657273656465732D42656E7A506F7273636865546F796F7461566F6C6B73776167656E766F0E00000040000000008104000000810804000081050C000081041100008104150000C00119000081041A0000010C1E000081072A00008106310000400337000081073A00000102410000001F00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000005_0F2D40CE]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000005_0F2D40CE] ON [dbo].[Cars]([Model]) WITH STATS_STREAM = 0x01000000010000000000000000000000138391B10000000095060000000000005506000000000000A7030000A7000000140000000000000015D0000021004C6107000000691266012AAD00001F000000000000001F000000000000000000803F8988083D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001D0000001D00000001000000100000004A29C5400000F841000000004A29C5400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000002E04000000000000E104000000000000E904000000000000E80000000000000000010000000000001B0100000000000033010000000000004D010000000000006A010000000000008801000000000000A401000000000000C501000000000000E30100000000000001020000000000001F020000000000003A02000000000000590200000000000074020000000000009902000000000000BF02000000000000DC02000000000000FA02000000000000190300000000000034030000000000004E0300000000000068030000000000008703000000000000A303000000000000BF03000000000000DE03000000000000F9030000000000001404000000000000300010000000803F000000000000803F0400000100180033300010000000803F000000000000803F04000001001B0035323064300010000000803F000000000000803F0400000100180036300010000000803F000000000000803F04000001001A00393131300010000000803F000000000000803F04000001001D004163636F7264300010000000803F000000000000803F04000001001E00416C7068617264300010000000803F000000000000803F04000001001C0043616D7279300010000000803F000000000000803F040000010021004368616C6C656E676572300010000000803F000000000000803F04000001001E0043686172676572300010000000803F000000000000803F04000001001E0043726166746572300010000000803F000000000000803F04000001001E00447572616E676F300010000000803F000000000000803F04000001001B0045333030300010000000803F000000000000803F04000001001F00457363616C616465300010000000803F0000803F0000803F04000001001B0047353030300010000000803F000000000000803F040000010025004772616E642D436865726F6B65653000100000000040000000000000803F04000001002600496D70726573612057525820535469300010000000803F000000000000803F04000001001D004D3520463930300010000000803F000000000000803F04000001001E004D757374616E67300010000000803F000000000000803F04000001001F0050616E616D657261300010000000803F000000000000803F04000001001B00506F6C6F300010000000803F000000000000803F04000001001A0052414D300010000000803F000000000000803F04000001001A00525336300010000000803F000000000000803F04000001001F00546572616D6F6E74300010000000803F000000000000803F04000001001C0056656C6172300010000000803F000000000000803F04000001001C00566F677565300010000000803F000000000000803F04000001001F005772616E676C6572300010000000803F000000000000803F04000001001B0058433730300010000000803F000000000000803F04000001001B0058433930300010000000803F000000000000803F04000001001A00585435FF01000000000000000B0000000B00000028000000280000000000000000000000480000003339313143616D7279726166746572457363616C6164654772616E642D436865726F6B6565496D7072657361205752582053546950616E616D657261525336566F677565584339300D000000400000000081010000008103010000C0010400008104050000010609000081080F0000810E170000810F250000810834000081033C000081053F00000104440000001F00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000007_0F2D40CE]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000007_0F2D40CE] ON [dbo].[Cars]([Generation]) WITH STATS_STREAM = 0x0100000001000000000000000000000045A54FA700000000D4030000000000009403000000000000A7030080A7000000140000000000000015D000005843393007000000681266012AAD00001F000000000000001F000000000000000000803F0000803D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0000000C0000000100000010000000841042400000F8410000000084104240000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000000000000000000000000000A10100000000000020020000000000002802000000000000600000000000000078000000000000009100000000000000AE00000000000000C800000000000000E600000000000000FF000000000000001D0100000000000035010000000000004E0100000000000068010000000000008901000000000000300010000000E040000000000000803F04000001001800493000100000000040000000000000803F040000010019004949300010000000803F000000000000803F04000001001D00494928424C293000100000008040000000000000803F04000001001A00494949300010000000803F0000803F0000803F04000001001E0049494928474A293000100000004040000000000000803F040000010019004956300010000000803F0000803F0000803F04000001001E00495628574B32293000100000000040000000000000803F04000001001800563000100000004040000000000000803F040000010019005649300010000000803F0000803F0000803F04000001001A00564949300010000000803F0000803F0000803F0400000100210056494949285856373029300010000000803F000000000000803F0400000100180058FF01000000000000000B00000009000000280000002800000000000000000000001E000000494928424C2928474A295628574B32295649284C442949492858563730290B0000004000000000C301000000C00101000081040200004101000000010406000041010A000001050B0000410210000081041200000108160000001F00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000010_0F2D40CE]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000010_0F2D40CE] ON [dbo].[Cars]([Price]) WITH STATS_STREAM = 0x01000000010000000000000000000000DFBA8E6300000000C00500000000000080050000000000006C0300006C00000009000A0000000000000000000400000107000000C47C33012AAD00001F000000000000001F000000000000000000803F0821043D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001D0000001D0000000100000019000000000010410000F841000000000000104100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000014040000000000001C04000000000000E800000000000000040100000000000020010000000000003C01000000000000580100000000000074010000000000009001000000000000AC01000000000000C801000000000000E40100000000000000020000000000001C020000000000003802000000000000540200000000000070020000000000008C02000000000000A802000000000000C402000000000000E002000000000000FC020000000000001803000000000000340300000000000050030000000000006C030000000000008803000000000000A403000000000000C003000000000000DC03000000000000F803000000000000100019000000803F000000000000803F01F618000000000000040000100019000000803F000000000000803F013421000000000000040000100019000000803F000000000000803F01F843000000000000040000100019000000803F000000000000803F01204E000000000000040000100019000000803F000000000000803F01F055000000000000040000100019000000803F0000803F0000803F01045B000000000000040000100019000000803F000000000000803F01685B000000000000040000100019000000803F0000803F0000803F01606D000000000000040000100019000000803F000000000000803F01007D000000000000040000100019000000803F000000000000803F01C87D000000000000040000100019000000803F000000000000803F01A884000000000000040000100019000000803F000000000000803F01D084000000000000040000100019000000803F000000000000803F01E092000000000000040000100019000000803F000000000000803F015898000000000000040000100019000000803F000000000000803F01369C000000000000040000100019000000803F000000000000803F01E0AB000000000000040000100019000000803F000000000000803F019CAE000000000000040000100019000000803F000000000000803F01A8C5000000000000040000100019000000803F000000000000803F0138C7000000000000040000100019000000803F000000000000803F01FCD0000000000000040000100019000000803F000000000000803F0134E9000000000000040000100019000000803F000000000000803F014CEF000000000000040000100019000000803F000000000000803F016413010000000000040000100019000000803F000000000000803F017863010000000000040000100019000000803F000000000000803F01B472010000000000040000100019000000803F000000000000803F01109E010000000000040000100019000000803F000000000000803F01E0A5010000000000040000100019000000803F000000000000803F01EDBB030000000000040000100019000000803F000000000000803F0140420F00000000000400001F00000000000000
GO
/****** Object:  Statistic [PK_Cars]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Cars]([PK_Cars]) WITH STATS_STREAM = 0x0100000001000000000000000000000032469C1B000000009C030000000000005C03000000000000380300003800000004000A0000000000000000001F0000000700000004EE090018AD00001F000000000000001F000000000000000000803F0821043D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000000100000014000000000080400000F8410000000000008040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000F001000000000000F80100000000000080000000000000009700000000000000AE00000000000000C500000000000000DC00000000000000F3000000000000000A01000000000000210100000000000038010000000000004F0100000000000066010000000000007D010000000000009401000000000000AB01000000000000C201000000000000D901000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F03000000040000100014000000803F0000803F0000803F05000000040000100014000000803F0000803F0000803F07000000040000100014000000803F0000803F0000803F09000000040000100014000000803F0000803F0000803F0B000000040000100014000000803F0000803F0000803F0D000000040000100014000000803F0000803F0000803F0F000000040000100014000000803F0000803F0000803F11000000040000100014000000803F0000803F0000803F13000000040000100014000000803F0000803F0000803F15000000040000100014000000803F0000803F0000803F17000000040000100014000000803F0000803F0000803F19000000040000100014000000803F0000803F0000803F1B000000040000100014000000803F0000803F0000803F1D000000040000100014000000803F0000803F0000803F1F0000000400001F00000000000000, ROWCOUNT = 31, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_5070F446]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_5070F446] ON [dbo].[Clients]([Name]) WITH STATS_STREAM = 0x01000000010000000000000000000000590E0C76000000002C04000000000000EC03000000000000A7030000A7000000140000000000000015D000000000000007000000A27C33012AAD0000120000000000000012000000000000000000803F2549923D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D0000000D00000001000000100000008EE3C84000009041000000008EE3C840000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000000000000000000000000000E2010000000000007802000000000000800200000000000068000000000000008800000000000000A500000000000000C300000000000000DF00000000000000FC000000000000001801000000000000350100000000000051010000000000006F010000000000008E01000000000000AA01000000000000C7010000000000003000100000000040000000000000803F04000001002000C0EBE5EAF1E0EDE4F03000100000004040000000000000803F04000001001D00C0EDE4F0E5E9300010000000803F0000803F0000803F04000001001E00C4E6EEE2E0EDE8300010000000803F000000000000803F04000001001C00C8E3EDE0F2300010000000803F000000000000803F04000001001D00CAE0F0EBEEF1300010000000803F000000000000803F04000001001C00CBE8E4E8FF300010000000803F000000000000803F04000001001D00CCE0EAF1E8EC3000100000000040000000000000803F04000001001C00CCE0F0E8FF300010000000803F000000000000803F04000001001E00CDE8EAEEEBE0E9300010000000803F000000000000803F04000001001F00CFE0F2F0E8F1E8FF300010000000803F000000000000803F04000001001C00CFE8F2E5F0300010000000803F000000000000803F04000001001D00D0EEEBE0EDE4300010000000803F000000000000803F04000001001B00DEF0E8E9FF01000000000000000A000000090000002800000028000000000000000000000035000000C0EBE5EAF1E0EDE4F0EDE4F0E5E9C4E6EEE2E0EDE8CAE0F0EBEEF1CBE8E4E8FFCCE0F0E8FFCDE8EAEEEBE0E9CFE8F2E5F0DEF0E8E90B0000004000000000C0010000008108010000020509000081070E0000810615000081051B00008105200000810725000081052C00000104310000001200000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_5070F446]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000003_5070F446] ON [dbo].[Clients]([SurName]) WITH STATS_STREAM = 0x010000000100000000000000000000009368955F000000000305000000000000C304000000000000A7030000A7000000140000000000000015D000000000000007000000B27C33012AAD00001200000000000000120000000000000000000000398E633D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000120000000100000010000000E438DE400000904100000000E438DE40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000000000000000000000000000AB020000000000004F0300000000000057030000000000009000000000000000AF00000000000000CC00000000000000EA00000000000000090100000000000028010000000000004A0100000000000066010000000000008401000000000000A101000000000000BF01000000000000DD01000000000000FB010000000000001A020000000000003802000000000000560200000000000075020000000000009002000000000000300010000000803F000000000000803F04000001001F00C0EDE8F9E5EDEAEE300010000000803F000000000000803F04000001001D00C0F1E2EEF0E4300010000000803F000000000000803F04000001001E00C1EEF0EEE2E8EA300010000000803F000000000000803F04000001001F00C1F3F0EBE0EAEEE2300010000000803F000000000000803F04000001001F00C3F0EEEDF1EAE8E9300010000000803F000000000000803F04000001002200C4EEE2E8E4EEE2F1EAE8E9300010000000803F000000000000803F04000001001C00CAE5ECECE0300010000000803F000000000000803F04000001001E00CAF3EBE0E5E2E0300010000000803F000000000000803F04000001001D00CBE0F0F1EEED300010000000803F000000000000803F04000001001E00CCE0EAE0F0EEE2300010000000803F000000000000803F04000001001E00CCE5EDE4E5EBFC300010000000803F000000000000803F04000001001E00D0EEE2E5EBEBE8300010000000803F000000000000803F04000001001F00D1E0E2E5EBFCE5E2300010000000803F000000000000803F04000001001E00D4F0E0EDEAE5ED300010000000803F000000000000803F04000001001E00D5E0EDE0E2E8ED300010000000803F000000000000803F04000001001F00D5E5ECE0EDE4EEF1300010000000803F000000000000803F04000001001B00D5EEF1E5300010000000803F000000000000803F04000001001B00D8EFE0EAFF01000000000000000A0000000A0000002800000028000000000000000000000043000000C0EDE8F9E5EDEAEEC1EEF0EEE2E8EAC3F0EEEDF1EAE8E9CAE5ECECE0CBE0F0F1EEEDCCE0EAE0F0EEE2D0EEE2E5EBEBE8D4F0E0EDEAE5EDD5E5ECE0EDE4EEF1D8EFE0EA0B00000040000000008108000000810708000081080F0000810517000081061C0000810722000081072900008107300000810837000001043F0000001200000000000000
GO
/****** Object:  Statistic [PK_Clients]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Clients]([PK_Clients]) WITH STATS_STREAM = 0x010000000100000000000000000000007891D79500000000E202000000000000A202000000000000380300003800000004000A0000000000000000000000000007000000AA6F230115AD0000120000000000000012000000000000000000803F398E633D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A0000000A00000001000000140000000000804000009041000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000036010000000000003E01000000000000500000000000000067000000000000007E000000000000009500000000000000AC00000000000000C300000000000000DA00000000000000F10000000000000008010000000000001F01000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F03000000040000100014000000803F0000803F0000803F05000000040000100014000000803F0000803F0000803F07000000040000100014000000803F0000803F0000803F09000000040000100014000000803F0000803F0000803F0B000000040000100014000000803F0000803F0000803F0D000000040000100014000000803F000000000000803F0E000000040000100014000000803F000000400000803F12000000040000100014000000803F000000000000803F2D0000000400001200000000000000, ROWCOUNT = 18, PAGECOUNT = 1
GO
/****** Object:  Statistic [PK_Deliveries]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Deliveries]([PK_Deliveries]) WITH STATS_STREAM = 0x01000000010000000000000000000000A8FE8F0900000000EA01000000000000AA01000000000000380384663800000004000A000000000000000000000000000700000080E77B012DAD0000030000000000000003000000000000000000803FABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000020000000100000014000000000080400000404000000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000003E00000000000000460000000000000010000000000000002700000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F030000000400000300000000000000, ROWCOUNT = 3, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_40058253]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_40058253] ON [dbo].[Employees]([Name]) WITH STATS_STREAM = 0x010000000100000000000000000000007AC5C4D0000000006F020000000000002F02000000000000A7030000A7000000140000000000000015D000000000000007000000554D29012AAD00000300000000000000030000000000000000000000ABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000030000000100000010000000ABAAAA400000404000000000ABAAAA400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000006D00000000000000BB00000000000000C300000000000000180000000000000033000000000000004F00000000000000300010000000803F000000000000803F04000001001B00C0EDEDE0300010000000803F000000000000803F04000001001C00CCE0F0E8FF300010000000803F000000000000803F04000001001E00CDE8EAEEEBE0E9FF010000000000000003000000030000002800000028000000000000000000000010000000C0EDEDE0CCE0F0E8FFCDE8EAEEEBE0E9040000004000000000810400000081050400000107090000000300000000000000
GO
/****** Object:  Statistic [PK_Employee]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Employees]([PK_Employee]) WITH STATS_STREAM = 0x01000000010000000000000000000000D2C14CA900000000EA01000000000000AA01000000000000380300003800000004000A000000000000000000D10100000700000048FD7D0116AD0000030000000000000003000000000000000000803FABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000020000000100000014000000000080400000404000000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000003E00000000000000460000000000000010000000000000002700000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F030000000400000300000000000000, ROWCOUNT = 3, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_02C769E9]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_02C769E9] ON [dbo].[Ordered]([IDCar]) WITH STATS_STREAM = 0x0100000001000000000000000000000036FF9CA500000000AD020000000000006D02000000000000380300003800000004000A0000000000000000000000000007000000255CF9001CAD00000300000000000000030000000000000000000000ABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000030000000100000014000000000080400000404000000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000000000000005D00000000000000F900000000000000010100000000000018000000000000002F000000000000004600000000000000100014000000803F000000000000803F01000000040000100014000000803F000000000000803F02000000040000100014000000803F000000000000803F090000000400000200000090DD68011BAD00000000000000000040F50100000000000002000000000000000000E03F000000000000F03F000000000000F03F0000000000506F400000000000306F40CD3B7F669EA0E63F1393880117AD0000000000000000F03F010000000000000001000000000000000000F03F0000000000000000000000000000F03F0000000000506F400000000000306F40000000000000F03F0300000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000002_276EDEB3]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_276EDEB3] ON [dbo].[Ordered]([IDCar]) WITH STATS_STREAM = 0x010000000100000000000000000000001E7E8DD500000000F202000000000000B202000000000000380300003800000004000A0000000000000000000000000007000000C6ACF0006BAE00000E000000000000000E000000000000000000803F2549923D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A0000000A00000001000000140000000000804000006041000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001104000000000000000000000000000036010000000000003E010000000000004601000000000000500000000000000067000000000000007E000000000000009500000000000000AC00000000000000C300000000000000DA00000000000000F10000000000000008010000000000001F01000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F03000000040000100014000000803F0000803F0000803F09000000040000100014000000803F0000803F0000803F0B000000040000100014000000803F000000000000803F0C000000040000100014000000803F0000803F0000803F10000000040000100014000000803F000000000000803F15000000040000100014000000803F000000000000803F19000000040000100014000000803F000000000000803F1E000000040000100014000000803F000000000000803F1F0000000400000E000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_02C769E9]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000003_02C769E9] ON [dbo].[Ordered]([DiscountPercent]) WITH STATS_STREAM = 0x010000000100000000000000000000009B1BC0CF000000004C020000000000000C020000000000006C0200006C0000000500030100000000000000000000000007000000171B37012AAD00000E000000000000000E0000000000000000000000CDCC4C3E0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000000500000001000000150000000000A04000006041000000000000A040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000A000000000000000A800000000000000280000000000000040000000000000005800000000000000700000000000000088000000000000001000150000000040000000000000803F0100000000040000100015000000C040000000000000803F0132000000040000100015000000803F000000000000803F014B0000000400001000150000004040000000000000803F01640000000400001000150000000040000000000000803F017D0000000400000E00000000000000
GO
/****** Object:  Statistic [PK_Ordered]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Ordered]([PK_Ordered]) WITH STATS_STREAM = 0x01000000020000000000000000000000622F737F0000000087020000000000002F02000000000000380300003800000004000A00000000000000000000000000380300003800000004000A0000000000000000000000000007000000215CF9001CAD000003000000000000000300000000000000000000000000803FABAAAA3E0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000200000014000000000000410000404000000000000080400000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000190000000000000000000000000000001F00000000000000BB00000000000000C30000000000000008000000000000001000140000004040000000000000803F022B00000400000200000091DD68011BAD00000000000000000040F50100000000000002000000000000000000E03F000000000000000000000000000000000000000000506F400000000000306F40000000000000E03F1393880117AD0000000000000000F03F010000000000000001000000000000000000F03F0000000000000000000000000000F03F0000000000506F400000000000306F40CD3B7F669EA0E63F0300000000000000, ROWCOUNT = 14, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_2B3F6F97]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_2B3F6F97] ON [dbo].[Orders]([IDClient]) WITH STATS_STREAM = 0x0100000001000000000000000000000034133A8C00000000B4020000000000007402000000000000380300003800000004000A000000000000000000D101000007000000C9ACF0006BAE00000D000000000000000D000000000000000000803FCDCCCC3D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000008000000010000001400000000008040000050410000000000008040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011040000000000000000000000000000F80000000000000000010000000000000801000000000000400000000000000057000000000000006E0000000000000085000000000000009C00000000000000B300000000000000CA00000000000000E100000000000000100014000000803F000000000000803F030000000400001000140000000040000000000000803F05000000040000100014000000803F000000000000803F060000000400001000140000000040000000000000803F07000000040000100014000000803F0000803F0000803F09000000040000100014000000803F000000000000803F0E0000000400001000140000000040000000000000803F10000000040000100014000000803F0000803F0000803F120000000400000D000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000002_5B78929E]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_5B78929E] ON [dbo].[Orders]([IDClient]) WITH STATS_STREAM = 0x01000000010000000000000000000000380CA96500000000A4020000000000006402000000000000380300003800000004000A000000000000000000380000000700000080E77B012DAD00000D000000000000000D000000000000000000803FCDCCCC3D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000008000000010000001400000000008040000050410000000000008040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000F8000000000000000001000000000000400000000000000057000000000000006E0000000000000085000000000000009C00000000000000B300000000000000CA00000000000000E100000000000000100014000000803F000000000000803F030000000400001000140000000040000000000000803F05000000040000100014000000803F000000000000803F060000000400001000140000000040000000000000803F07000000040000100014000000803F0000803F0000803F09000000040000100014000000803F000000000000803F0E0000000400001000140000000040000000000000803F10000000040000100014000000803F0000803F0000803F120000000400000D00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_2B3F6F97]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000003_2B3F6F97] ON [dbo].[Orders]([IDEmployee]) WITH STATS_STREAM = 0x0100000001000000000000000000000066DB0B2E000000001902000000000000D901000000000000380300003800000004000A0000000000000000000000000007000000CBACF0006BAE00000D000000000000000D0000000000000000000000ABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000030000000100000014000000000080400000504100000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110400000000000000000000000000005D0000000000000065000000000000006D0000000000000018000000000000002F000000000000004600000000000000100014000000A040000000000000803F01000000040000100014000000A040000000000000803F020000000400001000140000004040000000000000803F030000000400000D000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000003_5B78929E]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000003_5B78929E] ON [dbo].[Orders]([IDEmployee]) WITH STATS_STREAM = 0x01000000010000000000000000000000E5B29002000000000902000000000000C901000000000000380300003800000004000A00000000000000000038000000070000007BE77B012DAD00000D000000000000000D0000000000000000000000ABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000030000000100000014000000000080400000504100000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000005D00000000000000650000000000000018000000000000002F000000000000004600000000000000100014000000A040000000000000803F01000000040000100014000000A040000000000000803F020000000400001000140000004040000000000000803F030000000400000D00000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000007_2B3F6F97]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000007_2B3F6F97] ON [dbo].[Orders]([IDDelivery]) WITH STATS_STREAM = 0x010000000100000000000000000000002DE62A1C000000001902000000000000D901000000000000380300003800000004000A0000000000000000000D00000007000000CAACF0006BAE00000D000000000000000D0000000000000000000000ABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000030000000100000014000000000080400000504100000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110400000000000000000000000000005D0000000000000065000000000000006D0000000000000018000000000000002F0000000000000046000000000000001000140000000040000000000000803F01000000040000100014000000C040000000000000803F02000000040000100014000000A040000000000000803F030000000400000D000000000000000000000000000000
GO
/****** Object:  Statistic [_WA_Sys_00000007_5B78929E]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000007_5B78929E] ON [dbo].[Orders]([IDDelivery]) WITH STATS_STREAM = 0x010000000100000000000000000000005D02C96B000000000902000000000000C901000000000000380300003800000004000A000000000000000000380000000700000080E77B012DAD00000D000000000000000D0000000000000000000000ABAAAA3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000030000000100000014000000000080400000504100000000000080400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000005D00000000000000650000000000000018000000000000002F0000000000000046000000000000001000140000000040000000000000803F01000000040000100014000000C040000000000000803F02000000040000100014000000A040000000000000803F030000000400000D00000000000000
GO
/****** Object:  Statistic [PK_Orders]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Orders]([PK_Orders]) WITH STATS_STREAM = 0x01000000010000000000000000000000C96CA8A50000000085020000000000004502000000000000380350413800000004000A00000000000000000000000000070000005FE77B012DAD00000D000000000000000D000000000000000000803FD9899D3D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000007000000010000001400000000008040000050410000000000008040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000D900000000000000E10000000000000038000000000000004F0000000000000066000000000000007D000000000000009400000000000000AB00000000000000C200000000000000100014000000803F000000000000803F022B0000040000100014000000803F0000803F0000803F042B0000040000100014000000803F0000803F0000803F062B0000040000100014000000803F0000803F0000803F082B0000040000100014000000803F0000803F0000803F0A2B0000040000100014000000803F0000803F0000803F0C2B0000040000100014000000803F0000803F0000803F0E2B00000400000D00000000000000, ROWCOUNT = 13, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000009_108B795B]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000009_108B795B] ON [dbo].[SuppliersMarks]([Country]) WITH STATS_STREAM = 0x010000000100000000000000000000001D11CD4A00000000D6020000000000009602000000000000A7030000A70000001E0000000000000015D000000000000007000000140E4A012DAD00000F000000000000000F0000000000000000000000CDCC4C3E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000050000000100000010000000CDCCCC400000704100000000CDCCCC40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013000000000000000000000000000000C00000000000000022010000000000002A0100000000000028000000000000004D000000000000006C000000000000008600000000000000A300000000000000300010000000803F000000000000803F04000001002500C2E5EBE8EAEEE1F0E8F2E0EDE8FF300010000000A040000000000000803F04000001001F00C3E5F0ECE0EDE8FF3000100000008040000000000000803F04000001001A00D1D8C0300010000000803F000000000000803F04000001001D00D8E2E5F6E8FF3000100000008040000000000000803F04000001001D00DFEFEEEDE8FFFF01000000000000000A00000004000000280000002800000000000000000000001F000000C2E5EBE8EAEEE1F0E8F2E0EDE8FFC3E5F0ECE0EDE8FFD1D8C0DFEFEEEDE8FF050000004000000000810E00000083080E000083031600000306190000000F00000000000000
GO
/****** Object:  Statistic [PK_SuppliersMarks]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[SuppliersMarks]([PK_SuppliersMarks]) WITH STATS_STREAM = 0x01000000010000000000000000000000D712D14700000000A4020000000000006402000000000000380300003800000004000A000000000000000000000000000700000062EB5A0115AD00000F000000000000000F000000000000000000803F8988883D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000008000000010000001400000000008040000070410000000000008040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000F8000000000000000001000000000000400000000000000057000000000000006E0000000000000085000000000000009C00000000000000B300000000000000CA00000000000000E100000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F03000000040000100014000000803F0000803F0000803F05000000040000100014000000803F0000803F0000803F07000000040000100014000000803F0000803F0000803F09000000040000100014000000803F0000803F0000803F0B000000040000100014000000803F0000803F0000803F0D000000040000100014000000803F0000803F0000803F0F0000000400000F00000000000000, ROWCOUNT = 15, PAGECOUNT = 1
GO
/****** Object:  Statistic [_WA_Sys_00000002_1DE57479]    Script Date: 02.04.2022 14:40:01 ******/
CREATE STATISTICS [_WA_Sys_00000002_1DE57479] ON [dbo].[Types]([Category]) WITH STATS_STREAM = 0x010000000100000000000000000000004C609CC800000000DB030000000000009B03000000000000A7030000A70000001E0000000000000015D000000000000007000000E6E930012AAD00000B000000000000000B000000000000000000803F8C2EBA3D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A0000000A000000010000001000000074D1E540000030410000000074D1E5400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000007C0100000000000027020000000000002F02000000000000500000000000000072000000000000009200000000000000B200000000000000CD00000000000000EB000000000000000901000000000000250100000000000041010000000000005E01000000000000300010000000803F000000000000803F04000001002200C2EDE5E4EEF0EEE6EDE8EA300010000000803F000000000000803F04000001002000CAE0E1F0E8EEEBE5F2300010000000803F000000000000803F04000001002000CAF0EEF1F1EEE2E5F0300010000000803F000000000000803F04000001001B00CAF3EFE5300010000000803F000000000000803F04000001001E00CBE8ECF3E7E8ED300010000000803F000000000000803F04000001001E00CCE8EDE8E2FDED300010000000803F000000000000803F04000001001C00CFE8EAE0EF300010000000803F000000000000803F04000001001C00D1E5E4E0ED300010000000803F0000803F0000803F04000001001D00D4F3F0E3EEED300010000000803F000000000000803F04000001001E00D5FDF2F7E1FDEAFF01000000000000000A0000000A0000002800000028000000000000000000000045000000C2EDE5E4EEF0EEE6EDE8EACAF0EEF1F1EEE2E5F0F3EFE5CBE8ECF3E7E8EDCCE8EDE8E2FDEDCFE8EAE0EFD1E5E4E0EDD3EDE8E2E5F0F1E0EBD4F3F0E3EEEDD5FDF2F7E1FDEA0C0000004000000000810B000000C0010B000081080C00000103140000810717000081071E0000810525000081052A000081092F0000810638000001073E0000000B00000000000000
GO
/****** Object:  Statistic [PK_Types]    Script Date: 02.04.2022 14:40:01 ******/
UPDATE STATISTICS [dbo].[Types]([PK_Types]) WITH STATS_STREAM = 0x01000000010000000000000000000000E78FF6240000000066020000000000002602000000000000380300003800000004000A00000000000000000000000000070000005EEB5A0115AD00000B000000000000000B000000000000000000803F8C2EBA3D00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000006000000010000001400000000008040000030410000000000008040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000BA00000000000000C200000000000000300000000000000047000000000000005E0000000000000075000000000000008C00000000000000A300000000000000100014000000803F000000000000803F01000000040000100014000000803F0000803F0000803F03000000040000100014000000803F0000803F0000803F05000000040000100014000000803F0000803F0000803F07000000040000100014000000803F0000803F0000803F09000000040000100014000000803F0000803F0000803F0B0000000400000B00000000000000, ROWCOUNT = 11, PAGECOUNT = 1
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cars"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Types"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 118
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CarsAutoSale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CarsAutoSale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[17] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Ordered"
            Begin Extent = 
               Top = 6
               Left = 254
               Bottom = 135
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 6
               Left = 468
               Bottom = 135
               Right = 660
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cars"
            Begin Extent = 
               Top = 12
               Left = 33
               Bottom = 141
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CarsOrdered'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_CarsOrdered'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[18] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Clients"
            Begin Extent = 
               Top = 5
               Left = 670
               Bottom = 133
               Right = 844
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 10
               Left = 451
               Bottom = 139
               Right = 643
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ordered"
            Begin Extent = 
               Top = 5
               Left = 232
               Bottom = 134
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cars"
            Begin Extent = 
               Top = 9
               Left = 24
               Bottom = 138
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ClientsOrderedCars'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ClientsOrderedCars'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ClientsOrderedCars'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[25] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SuppliersMarks"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SuppliersMarksUSA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SuppliersMarksUSA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[19] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -19
      End
      Begin Tables = 
         Begin Table = "Cars"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Clients"
            Begin Extent = 
               Top = 1
               Left = 684
               Bottom = 130
               Right = 858
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 135
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Ordered"
            Begin Extent = 
               Top = 11
               Left = 243
               Bottom = 140
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2985
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TotalPriceOrderedClients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TotalPriceOrderedClients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_TotalPriceOrderedClients'
GO
USE [master]
GO
ALTER DATABASE [AutoSale] SET  READ_WRITE 
GO
