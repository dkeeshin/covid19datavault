USE [master]
GO
/****** Object:  Database [Covid19DataVault]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE DATABASE [Covid19DataVault]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Covid19DataVault', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\Covid19DataVault.mdf' , SIZE = 331072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Covid19DataVault_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\Covid19DataVault_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Covid19DataVault] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Covid19DataVault].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Covid19DataVault] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Covid19DataVault] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Covid19DataVault] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Covid19DataVault] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Covid19DataVault] SET ARITHABORT OFF 
GO
ALTER DATABASE [Covid19DataVault] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Covid19DataVault] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Covid19DataVault] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Covid19DataVault] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Covid19DataVault] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Covid19DataVault] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Covid19DataVault] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Covid19DataVault] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Covid19DataVault] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Covid19DataVault] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Covid19DataVault] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Covid19DataVault] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Covid19DataVault] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Covid19DataVault] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Covid19DataVault] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Covid19DataVault] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Covid19DataVault] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Covid19DataVault] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Covid19DataVault] SET  MULTI_USER 
GO
ALTER DATABASE [Covid19DataVault] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Covid19DataVault] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Covid19DataVault] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Covid19DataVault] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Covid19DataVault] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Covid19DataVault', N'ON'
GO
ALTER DATABASE [Covid19DataVault] SET QUERY_STORE = OFF
GO
USE [Covid19DataVault]
GO
/****** Object:  Schema [Azure]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Azure]
GO
/****** Object:  Schema [Core]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Core]
GO
/****** Object:  Schema [History]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [History]
GO
/****** Object:  Schema [Hourly]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Hourly]
GO
/****** Object:  Schema [Item]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Item]
GO
/****** Object:  Schema [Link]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Link]
GO
/****** Object:  Schema [Message]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Message]
GO
/****** Object:  Schema [Reference]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Reference]
GO
/****** Object:  Schema [Report]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Report]
GO
/****** Object:  Schema [Stage]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Stage]
GO
/****** Object:  Schema [Utility]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE SCHEMA [Utility]
GO
/****** Object:  UserDefinedTableType [dbo].[statement]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE TYPE [dbo].[statement] AS TABLE(
	[ID] [int] NOT NULL,
	[sqlString] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[statementBlock]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE TYPE [dbo].[statementBlock] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[procedureName] [nvarchar](128) NULL,
	[sqlBlock] [nvarchar](max) NULL
)
GO
/****** Object:  Table [Item].[ProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[ProvinceStateDetail](
	[ProvinceStateDetailID] [int] NOT NULL,
	[ProvinceStateID] [int] NOT NULL,
	[MonitorDate] [datetime2](7) NOT NULL,
	[StateAbbreviation] [nvarchar](2) NOT NULL,
	[PositiveToDate] [int] NOT NULL,
	[NegativeToDate] [int] NOT NULL,
	[DeathCountToDate] [int] NOT NULL,
	[InHospitalToDate] [int] NOT NULL,
	[PreviousPeriodToDatePositiveCount] [int] NULL,
	[PreviousPeriodToDateNegativeCount] [int] NULL,
	[PreviousPeriodToDateDeathCount] [int] NULL,
	[PreviousPeriodToDateHospitalizedCount] [int] NULL,
	[PreviousPeriodToDate] [datetime2](7) NULL,
	[PopulationYear] [smallint] NOT NULL,
	[Population] [bigint] NOT NULL,
	[PopulationDensity] [int] NOT NULL,
	[LandArea] [decimal](10, 2) NOT NULL,
	[VendorHash] [nvarchar](40) NOT NULL,
	[HashValue] [varbinary](32) NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
 CONSTRAINT [pkStateDetailLinkID] PRIMARY KEY CLUSTERED 
(
	[ProvinceStateDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[CountryRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[CountryRegion](
	[CountryRegionID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [CountryRegionPK] PRIMARY KEY CLUSTERED 
(
	[CountryRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[CountrySubRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[CountrySubRegion](
	[CountrySubRegionID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [CountrySubRegionPK] PRIMARY KEY CLUSTERED 
(
	[CountrySubRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[ProvinceState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[ProvinceState](
	[ProvinceStateID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [ProvinceStatePK] PRIMARY KEY CLUSTERED 
(
	[ProvinceStateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Link].[ProvinceStateDetailToProvinceStateCore]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Link].[ProvinceStateDetailToProvinceStateCore](
	[ProvinceStateDetailLinkID] [int] NOT NULL,
	[ProvinceStateDetailID] [int] NOT NULL,
	[CountryRegionID] [int] NULL,
	[CountrySubRegionID] [int] NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [pkProvinceStateDetailLinkID] PRIMARY KEY CLUSTERED 
(
	[ProvinceStateDetailLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Report].[vwProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [Report].[vwProvinceStateDetail]
AS
     SELECT b.[MonitorDate], 
            a.SourceReferenceKey AS 'StateName', 
            d.SourceReferenceKey AS 'Country Region', 
            e.SourceReferenceKey AS 'Country Sub Region', 
            b.[StateAbbreviation], 
            b.[PositiveToDate] - b.[PreviousPeriodToDatePositiveCount] AS DailyPositiveCount, 
            b.[NegativeToDate] - b.[PreviousPeriodToDateNegativeCount] AS DailyNegativeCount, 
            b.[DeathCountToDate] - b.[PreviousPeriodToDateDeathCount] AS DailyDeathCount, 
            b.[InHospitalToDate] - b.[PreviousPeriodToDateHospitalizedCount] AS DailyInHospitalCount, 
            b.[PositiveToDate], 
            b.[NegativeToDate], 
            b.[DeathCountToDate], 
            b.[InHospitalToDate], 
            b.[PopulationYear], 
            b.[Population], 
            b.[PopulationDensity] AS PopulationDensityPerSquareMile, 
            b.[LandArea], 
            b.[Source], 
            a.ProvinceStateID, 
            b.[PreviousPeriodToDate]
     FROM Core.ProvinceState AS a
          INNER JOIN [Item].[ProvinceStateDetail] AS b ON b.ProvinceStateID = a.ProvinceStateID
          INNER JOIN LINK.ProvinceStateDetailToProvinceStateCore AS c ON b.ProvinceStateDetailID = c.ProvinceStateDetailID
          INNER JOIN Core.CountryRegion AS d ON d.CountryRegionID = c.CountryRegionID
          INNER JOIN Core.CountrySubRegion AS e ON e.CountrySubRegionID = c.CountrySubRegionID;
GO
/****** Object:  Table [Core].[Country]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[Country](
	[CountryID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [CountryPK] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reference].[WorldRegionCountryCode]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reference].[WorldRegionCountryCode](
	[CountryCode] [nvarchar](4) NOT NULL,
	[WorldRegion] [nvarchar](64) NULL,
	[WorldSubRegion] [nvarchar](64) NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
 CONSTRAINT [pkCountryDetailLinkID] PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Item].[CountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[CountryDetail](
	[CountryDetailID] [int] NOT NULL,
	[CountryID] [int] NOT NULL,
	[MonitorDate] [datetime2](7) NULL,
	[CaseCount] [int] NOT NULL,
	[DeathCount] [int] NOT NULL,
	[PeriodToDateCaseCount] [int] NOT NULL,
	[PeriodToDateDeathCount] [int] NOT NULL,
	[Population] [bigint] NOT NULL,
	[CaseCountPerPopulationPercent] [decimal](29, 13) NOT NULL,
	[DeathCountPerPopulationPercent] [decimal](29, 13) NOT NULL,
	[IncomePerCapita2018] [decimal](12, 2) NOT NULL,
	[PopulationDensityPerKilometer] [decimal](12, 2) NOT NULL,
	[CaseThirtyDayMovingAverage] [int] NOT NULL,
	[DeathThirtyDayMovingAverage] [int] NOT NULL,
	[CountryCode] [nvarchar](8) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
 CONSTRAINT [CountryDetailPK] PRIMARY KEY CLUSTERED 
(
	[CountryDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Report].[vwCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [Report].[vwCountryDetail] as
SELECT b.[MonitorDate],
       a.SourceReferenceKey AS 'Country', 
       c.WorldRegion, 
       c.WorldSubRegion, 
       b.[CaseCount], 
       b.[DeathCount], 
       b.[PeriodToDateCaseCount], 
       b.[PeriodToDateDeathCount], 
       b.[Population], 
       b.[CaseCountPerPopulationPercent], 
       b.[DeathCountPerPopulationPercent], 
       b.[IncomePerCapita2018], 
       b.[PopulationDensityPerKilometer], 
       b.[CaseThirtyDayMovingAverage], 
       b.[DeathThirtyDayMovingAverage], 
       b.[CountryCode],
	   b.[Source],
	   a.CountryID
FROM Core.Country AS a
     INNER JOIN [Item].[CountryDetail] AS b ON b.CountryID = a.CountryID
     INNER JOIN [Reference].[WorldRegionCountryCode] AS c ON c.CountryCode = b.CountryCode;
GO
/****** Object:  Table [Item].[CounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Item].[CounTYDetail](
	[CounTYDetailID] [int] NOT NULL,
	[CounTYID] [int] NOT NULL,
	[MonitorDate] [datetime2](7) NOT NULL,
	[FIPS] [nvarchar](8) NULL,
	[PeriodToDateCaseCount] [int] NULL,
	[PeriodToDateDeathCount] [int] NULL,
	[PreviousPeriodToDate] [datetime2](7) NULL,
	[PreviousPeriodToDateCaseCount] [int] NULL,
	[PreviousPeriodToDateDeathCount] [int] NULL,
	[PopulationYear] [smallint] NULL,
	[Population] [bigint] NULL,
	[BirthPerPopulation] [int] NULL,
	[DeathPerPopulation] [bigint] NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
 CONSTRAINT [CounTYDetailPK] PRIMARY KEY CLUSTERED 
(
	[CounTYDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[County]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[County](
	[CountyID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [CountyPK] PRIMARY KEY CLUSTERED 
(
	[CountyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Link].[CounTYDetailToCounTYCore]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Link].[CounTYDetailToCounTYCore](
	[CounTYDetailLinkID] [int] NOT NULL,
	[CounTYDetailID] [int] NOT NULL,
	[CountryRegionID] [int] NOT NULL,
	[CountrySubRegionID] [int] NOT NULL,
	[ProvinceStateID] [int] NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [pkCounTYDetailLinkID] PRIMARY KEY CLUSTERED 
(
	[CounTYDetailLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Report].[vwCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE     VIEW [Report].[vwCounTYDetail]
AS
SELECT b.[MonitorDate], 
       a.SourceReferenceKey AS 'CounTYName', 
       f.SourceReferenceKey AS 'StateName', 
       d.SourceReferenceKey AS 'Country Region', 
       e.SourceReferenceKey AS 'Country Sub Region', 
       b.[FIPS], 
       b.[PeriodToDateCaseCount] as PeriodToDateCaseCount, 
       b.[PeriodToDateDeathCount] as PeriodToDateDeathCount, 
	   b.[PeriodToDateCaseCount] - b.PreviousPeriodToDateCaseCount as DailyCaseCount,
	   b.[PeriodToDateDeathCount] - b.PreviousPeriodToDateDeathCount DailyDeathCount,
	   b.PreviousPeriodToDate,
	   b.[BirthPerPopulation], 
       b.[DeathPerPopulation], 
       b.[PopulationYear], 
       b.[Population], 
       b.[Source],
	   a.CountyID
FROM Core.County AS a
     INNER JOIN [Item].[CounTYDetail] AS b ON b.CounTYID = a.CounTYID
     INNER JOIN LINK.CounTYDetailToCounTYCore AS c ON b.CounTYDetailID = c.CounTYDetailID
     INNER JOIN Core.CountryRegion AS d ON d.CountryRegionID = c.CountryRegionID
     INNER JOIN Core.CountrySubRegion AS e ON e.CountrySubRegionID = c.CountrySubRegionID
     INNER JOIN Core.ProvinceState AS f ON f.ProvinceStateID = c.ProvinceStateID  
	 
GO
/****** Object:  Table [Core].[City]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[City](
	[CityID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [CityPK] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[CountyRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[CountyRegion](
	[CountyRegionID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [CountyRegionPK] PRIMARY KEY CLUSTERED 
(
	[CountyRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[WorldRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[WorldRegion](
	[WorldRegionID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [WorldRegionPK] PRIMARY KEY CLUSTERED 
(
	[WorldRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Core].[WorldSubRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Core].[WorldSubRegion](
	[WorldSubRegionID] [int] NOT NULL,
	[SourceReferenceKey] [nvarchar](64) NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
 CONSTRAINT [WorldSubRegionPK] PRIMARY KEY CLUSTERED 
(
	[WorldSubRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [History].[AzureCostDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[AzureCostDetail](
	[date] [nvarchar](24) NULL,
	[serviceFamily] [nvarchar](64) NULL,
	[consumedService] [nvarchar](64) NULL,
	[meterName] [nvarchar](64) NULL,
	[meterCategory] [nvarchar](64) NULL,
	[meterSubCategory] [nvarchar](64) NULL,
	[product] [nvarchar](64) NULL,
	[costInUsd] [nvarchar](24) NULL,
	[subscriptionName] [nvarchar](64) NULL,
	[effectivePrice] [nvarchar](32) NULL,
	[quantity] [nvarchar](24) NULL,
	[unitOfMeasure] [nvarchar](24) NULL,
	[chargeType] [nvarchar](24) NULL,
	[billingCurrency] [nvarchar](24) NULL,
	[paygCostInUsd] [nvarchar](32) NULL,
	[payGPrice] [nvarchar](24) NULL,
	[unitPrice] [nvarchar](24) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [History].[CovidTrackingDailyState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[CovidTrackingDailyState](
	[Date] [datetime2](7) NOT NULL,
	[State] [nvarchar](2) NOT NULL,
	[Positive] [int] NULL,
	[Negative] [int] NULL,
	[Death] [int] NULL,
	[Hospitalized] [int] NULL,
	[PopulationYear] [smallint] NULL,
	[Population] [bigint] NULL,
	[PopulationDensity] [int] NULL,
	[LandArea] [decimal](10, 2) NULL,
	[StateName] [nvarchar](48) NULL,
	[CountryRegion] [nvarchar](64) NULL,
	[CountrySubRegion] [nvarchar](64) NULL,
	[Hash] [nvarchar](40) NULL,
	[HashValue] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [History].[NYTimesCovid19USCounTY]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[NYTimesCovid19USCounTY](
	[date] [nvarchar](10) NULL,
	[county] [nvarchar](48) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL,
	[USCensusCounty] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [History].[PreviousDayCounTY]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[PreviousDayCounTY](
	[date] [nvarchar](10) NULL,
	[county] [nvarchar](48) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Hourly].[NYTimesCovid19USCountyLive]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Hourly].[NYTimesCovid19USCountyLive](
	[date] [nvarchar](10) NULL,
	[county] [nvarchar](48) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL,
	[USCensusCounty] [nvarchar](64) NULL,
	[confirmed_cases] [int] NULL,
	[confirmed_deaths] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Link].[CountryDetailToCountryCore]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Link].[CountryDetailToCountryCore](
	[CountryDetailLinkID] [int] NOT NULL,
	[CountryDetailID] [int] NOT NULL,
	[Source] [nvarchar](108) NOT NULL,
	[EffectiveStartDate] [datetime2](7) NOT NULL,
	[EffectiveEndDate] [datetime2](7) NOT NULL,
 CONSTRAINT [pkCountryDetailLinkID] PRIMARY KEY CLUSTERED 
(
	[CountryDetailLinkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Message].[OutGoingCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[OutGoingCountryDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
	[JSONMessage] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Message].[OutGoingCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[OutGoingCounTYDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
	[JSONMessage] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Message].[OutGoingProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[OutGoingProvinceStateDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HashValue] [varbinary](32) NOT NULL,
	[JSONMessage] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Message].[ReceivedItemCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[ReceivedItemCountryDetail](
	[ReceivedDate] [datetime2](7) NULL,
	[HashValue] [varbinary](32) NULL,
	[HashCount] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Message].[ReceivedItemCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[ReceivedItemCounTYDetail](
	[ReceivedDate] [datetime2](7) NULL,
	[HashValue] [varbinary](32) NULL,
	[HashCount] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Message].[ReceivedItemProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[ReceivedItemProvinceStateDetail](
	[ReceivedDate] [datetime2](7) NULL,
	[HashValue] [varbinary](32) NULL,
	[HashCount] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Message].[SentCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[SentCountryDetail](
	[SentDate] [datetime2](7) NULL,
	[HashValue] [varbinary](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Message].[SentCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[SentCounTYDetail](
	[SentDate] [datetime2](7) NULL,
	[HashValue] [varbinary](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Message].[SentProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Message].[SentProvinceStateDetail](
	[SentDate] [datetime2](7) NULL,
	[HashValue] [varbinary](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Reference].[Calendar]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reference].[Calendar](
	[Date] [date] NOT NULL,
	[Year] [smallint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[MonthName] [nvarchar](10) NOT NULL,
	[WeekDay] [tinyint] NOT NULL,
	[WeekDayName] [nvarchar](10) NOT NULL,
 CONSTRAINT [Date] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Reference].[FIPS]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Reference].[FIPS](
	[FIPS] [nvarchar](8) NOT NULL,
	[CounTYName] [nvarchar](64) NOT NULL,
	[StateName] [nvarchar](64) NOT NULL,
	[CountryRegion] [nvarchar](64) NOT NULL,
	[CountrySubRegion] [nvarchar](64) NOT NULL,
 CONSTRAINT [pkFIPS] PRIMARY KEY CLUSTERED 
(
	[FIPS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[AzureCostDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[AzureCostDetail](
	[date] [nvarchar](24) NULL,
	[serviceFamily] [nvarchar](64) NULL,
	[consumedService] [nvarchar](64) NULL,
	[meterName] [nvarchar](64) NULL,
	[meterCategory] [nvarchar](64) NULL,
	[meterSubCategory] [nvarchar](64) NULL,
	[product] [nvarchar](64) NULL,
	[costInUsd] [nvarchar](24) NULL,
	[subscriptionName] [nvarchar](64) NULL,
	[effectivePrice] [nvarchar](32) NULL,
	[quantity] [nvarchar](24) NULL,
	[unitOfMeasure] [nvarchar](24) NULL,
	[chargeType] [nvarchar](24) NULL,
	[billingCurrency] [nvarchar](24) NULL,
	[paygCostInUsd] [nvarchar](32) NULL,
	[payGPrice] [nvarchar](24) NULL,
	[unitPrice] [nvarchar](24) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[CountryLoadFromAzure]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[CountryLoadFromAzure](
	[HashValue] [varbinary](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[CouNTYLoadFromAzure]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[CouNTYLoadFromAzure](
	[HashValue] [varbinary](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[CovidTrackingDailyState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[CovidTrackingDailyState](
	[Date] [datetime2](7) NOT NULL,
	[State] [nvarchar](2) NOT NULL,
	[Positive] [int] NULL,
	[Negative] [int] NULL,
	[Death] [int] NULL,
	[Hospitalized] [int] NULL,
	[PreviousPeriodToDatePositiveCount] [int] NULL,
	[PreviousPeriodToDateNegativeCount] [int] NULL,
	[PreviousPeriodToDateDeathCount] [int] NULL,
	[PreviousPeriodToDateHospitalizedCount] [int] NULL,
	[PreviousPeriodToDate] [datetime2](7) NULL,
	[PopulationYear] [smallint] NULL,
	[Population] [bigint] NULL,
	[PopulationDensity] [int] NULL,
	[LandArea] [decimal](10, 2) NULL,
	[StateName] [nvarchar](48) NULL,
	[CountryRegion] [nvarchar](64) NULL,
	[CountrySubRegion] [nvarchar](64) NULL,
	[Hash] [nvarchar](40) NULL,
	[HashValue] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[DailyChangeByCountry]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[DailyChangeByCountry](
	[date] [nvarchar](10) NULL,
	[location] [nvarchar](48) NULL,
	[Country] [nvarchar](92) NULL,
	[new_cases] [int] NULL,
	[new_deaths] [int] NULL,
	[total_cases] [int] NULL,
	[total_deaths] [int] NULL,
	[Population] [bigint] NULL,
	[CaseCountPerPopulationPercent] [decimal](29, 13) NULL,
	[DeathCountPerPopulationPercent] [decimal](29, 13) NULL,
	[IncomePerCapita2018] [decimal](12, 2) NULL,
	[PopulationDensityPerKilometer] [decimal](12, 2) NULL,
	[CaseThirtyDayMovingAverage] [int] NULL,
	[DeathThirtyDayMovingAverage] [int] NULL,
	[CountryCode] [nvarchar](8) NULL,
	[WorldRegion] [nvarchar](64) NULL,
	[WorldSubRegion] [nvarchar](64) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[DailyChangeByCountryJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[DailyChangeByCountryJSON](
	[ID] [int] NULL,
	[ProcessDate] [datetime2](7) NULL,
	[FileNumber] [nvarchar](8) NULL,
	[Location] [nvarchar](48) NULL,
	[HashValue] [varbinary](32) NULL,
	[BulkColumn] [nvarchar](max) NULL,
	[JSONFileCreateDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[DailyChangeByCounTY]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[DailyChangeByCounTY](
	[date] [datetime2](7) NULL,
	[county] [nvarchar](48) NULL,
	[USCensusCounty] [nvarchar](64) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL,
	[PreviousPeriodToDate] [datetime2](7) NULL,
	[PreviousPeriodToDateCaseCount] [int] NULL,
	[PreviousPeriodToDateDeathCount] [int] NULL,
	[RegionName] [nvarchar](32) NULL,
	[DivisionName] [nvarchar](32) NULL,
	[PopulationYear] [smallint] NULL,
	[POPESTIMATE2019] [bigint] NULL,
	[BIRTHS2019] [int] NULL,
	[DEATHS2019] [bigint] NULL,
	[LoadTime] [datetime2](7) NOT NULL,
	[Hash] [varbinary](32) NULL,
	[Source] [nvarchar](108) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[DailyChangeByCounTYJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[DailyChangeByCounTYJSON](
	[ID] [int] NULL,
	[ProcessDate] [datetime2](7) NULL,
	[FileNumber] [nvarchar](8) NULL,
	[USCensusCounty] [nvarchar](64) NULL,
	[State] [nvarchar](32) NULL,
	[HashValue] [varbinary](32) NULL,
	[BulkColumn] [nvarchar](max) NULL,
	[JSONFileCreateDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[DailyChangeByProvinceStateJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[DailyChangeByProvinceStateJSON](
	[ID] [int] NULL,
	[ProcessDate] [datetime2](7) NULL,
	[FileNumber] [nvarchar](8) NULL,
	[StateName] [nvarchar](48) NULL,
	[HashValue] [varbinary](32) NULL,
	[BulkColumn] [nvarchar](max) NULL,
	[JSONFileCreateDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[JsonDocument]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[JsonDocument](
	[BulkColumn] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[MissingCountyFromNYTimesData]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[MissingCountyFromNYTimesData](
	[county] [nvarchar](48) NULL,
	[state] [nvarchar](32) NULL,
	[date] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[MissingDailyChangeCountry]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[MissingDailyChangeCountry](
	[ID] [int] NULL,
	[ProcessDate] [datetime2](7) NULL,
	[FileNumber] [nvarchar](8) NULL,
	[Location] [nvarchar](48) NULL,
	[BulkColumn] [nvarchar](max) NULL,
	[JSONFileCreateDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[MissingDailyChangeCounTY]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[MissingDailyChangeCounTY](
	[ID] [int] NULL,
	[ProcessDate] [datetime2](7) NULL,
	[FileNumber] [nvarchar](8) NULL,
	[USCensusCounty] [nvarchar](64) NULL,
	[State] [nvarchar](32) NULL,
	[BulkColumn] [nvarchar](max) NULL,
	[JSONFileCreateDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[MissingDailyChangeProvinceState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[MissingDailyChangeProvinceState](
	[ID] [int] NULL,
	[ProcessDate] [datetime2](7) NULL,
	[FileNumber] [nvarchar](8) NULL,
	[StateName] [nvarchar](48) NULL,
	[BulkColumn] [nvarchar](max) NULL,
	[JSONFileCreateDate] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[MissingOurWorldInDataCountryByDate]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[MissingOurWorldInDataCountryByDate](
	[CountryCode] [nvarchar](4) NULL,
	[location] [nvarchar](48) NULL,
	[MissingDate] [date] NULL,
	[FirstDate] [date] NULL,
	[LastDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[NYTimesCovid19USCounty]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[NYTimesCovid19USCounty](
	[date] [nvarchar](10) NULL,
	[county] [nvarchar](48) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL,
	[USCensusCounty] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[NYTimesCovid19USCountyLive]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[NYTimesCovid19USCountyLive](
	[date] [nvarchar](10) NULL,
	[county] [nvarchar](48) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL,
	[USCensusCounty] [nvarchar](64) NULL,
	[confirmed_cases] [int] NULL,
	[confirmed_deaths] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[NYTimesCovid19USState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[NYTimesCovid19USState](
	[date] [nvarchar](10) NULL,
	[state] [nvarchar](32) NULL,
	[fips] [nvarchar](8) NULL,
	[cases] [int] NULL,
	[deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[OurWorldDataDailyCountry]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[OurWorldDataDailyCountry](
	[date] [nvarchar](10) NULL,
	[location] [nvarchar](48) NULL,
	[new_cases] [int] NULL,
	[new_deaths] [int] NULL,
	[total_cases] [int] NULL,
	[total_deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[OurWorldDataDailyCountryMissingCount]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[OurWorldDataDailyCountryMissingCount](
	[date] [nvarchar](10) NULL,
	[location] [nvarchar](48) NULL,
	[new_cases] [int] NULL,
	[new_deaths] [int] NULL,
	[total_cases] [int] NULL,
	[total_deaths] [int] NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](64) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[ProvinceStateLoadFromAzure]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[ProvinceStateLoadFromAzure](
	[HashValue] [varbinary](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[State]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[State](
	[State] [nvarchar](48) NULL,
	[Abbreviation] [nvarchar](2) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[StatePopulation]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[StatePopulation](
	[Year] [nvarchar](4) NULL,
	[State] [nvarchar](92) NULL,
	[Population] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[StatePopulationDensity]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[StatePopulationDensity](
	[Year] [nvarchar](4) NULL,
	[State] [nvarchar](48) NULL,
	[Density] [decimal](8, 2) NULL,
	[Pop] [int] NULL,
	[LandArea] [decimal](10, 2) NULL,
	[LoadDate] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[USCensusCountyPopulation]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[USCensusCountyPopulation](
	[PopulationYear] [nvarchar](4) NULL,
	[REGION] [nvarchar](12) NULL,
	[RegionName] [nvarchar](16) NULL,
	[DIVISION] [nvarchar](12) NULL,
	[DivisionName] [nvarchar](32) NULL,
	[STATE] [nvarchar](12) NULL,
	[STNAME] [nvarchar](32) NULL,
	[CTYNAME] [nvarchar](64) NULL,
	[BIRTHS2019] [nvarchar](12) NULL,
	[POPESTIMATE2019] [nvarchar](12) NULL,
	[NATURALINC2019] [nvarchar](12) NULL,
	[INTERNATIONALMIG2019] [nvarchar](12) NULL,
	[RBIRTH2019] [nvarchar](24) NULL,
	[DEATHS2019] [nvarchar](12) NULL,
	[RDEATH2019] [nvarchar](24) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[USCensusCountyPopulationStateTotal]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[USCensusCountyPopulationStateTotal](
	[PopulationYear] [nvarchar](4) NULL,
	[REGION] [nvarchar](12) NULL,
	[RegionName] [nvarchar](16) NULL,
	[DIVISION] [nvarchar](12) NULL,
	[DivisionName] [nvarchar](32) NULL,
	[STATE] [nvarchar](12) NULL,
	[STNAME] [nvarchar](32) NULL,
	[CTYNAME] [nvarchar](64) NULL,
	[BIRTHS2019] [nvarchar](12) NULL,
	[POPESTIMATE2019] [nvarchar](12) NULL,
	[NATURALINC2019] [nvarchar](12) NULL,
	[INTERNATIONALMIG2019] [nvarchar](12) NULL,
	[RBIRTH2019] [nvarchar](24) NULL,
	[DEATHS2019] [nvarchar](12) NULL,
	[RDEATH2019] [nvarchar](24) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[WorldBankPerCapitaIncome]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[WorldBankPerCapitaIncome](
	[Country] [nvarchar](48) NULL,
	[Description] [nvarchar](48) NULL,
	[Year] [nvarchar](4) NULL,
	[Amount] [nvarchar](12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[WorldBankPerCapitaIncome2018]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[WorldBankPerCapitaIncome2018](
	[Country] [nvarchar](48) NULL,
	[Amount] [nvarchar](12) NULL,
	[year] [nvarchar](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[WorldPopulation]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[WorldPopulation](
	[Year] [nvarchar](4) NULL,
	[Country] [nvarchar](92) NULL,
	[CountryCode] [nvarchar](8) NULL,
	[Population] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[WorldPopulationDensity]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[WorldPopulationDensity](
	[Year] [nvarchar](4) NULL,
	[Country] [nvarchar](92) NULL,
	[CountryCode] [nvarchar](8) NULL,
	[PopulationDensity] [decimal](8, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[WorldRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[WorldRegion](
	[RegionYear] [nvarchar](4) NULL,
	[WorldRegion] [nvarchar](32) NULL,
	[WorldSubRegion] [nvarchar](48) NULL,
	[Country] [nvarchar](64) NULL,
	[Hash] [varbinary](32) NULL,
	[LoadTime] [datetime2](7) NULL,
	[Source] [nvarchar](92) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[XMLDocument]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[XMLDocument](
	[XMLRow] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index04]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE NONCLUSTERED INDEX [index04] ON [History].[NYTimesCovid19USCounTY]
(
	[date] ASC,
	[fips] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index05]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE NONCLUSTERED INDEX [index05] ON [History].[PreviousDayCounTY]
(
	[date] ASC,
	[fips] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [CTYNameIndex]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE NONCLUSTERED INDEX [CTYNameIndex] ON [Stage].[USCensusCountyPopulation]
(
	[CTYNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index03]    Script Date: 7/22/2020 10:28:11 AM ******/
CREATE NONCLUSTERED INDEX [index03] ON [Stage].[USCensusCountyPopulation]
(
	[CTYNAME] ASC,
	[STNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [Item].[CountryDetail]  WITH CHECK ADD  CONSTRAINT [CountryID003] FOREIGN KEY([CountryID])
REFERENCES [Core].[Country] ([CountryID])
GO
ALTER TABLE [Item].[CountryDetail] CHECK CONSTRAINT [CountryID003]
GO
ALTER TABLE [Item].[CounTYDetail]  WITH CHECK ADD  CONSTRAINT [CounTYID010] FOREIGN KEY([CounTYID])
REFERENCES [Core].[County] ([CountyID])
GO
ALTER TABLE [Item].[CounTYDetail] CHECK CONSTRAINT [CounTYID010]
GO
ALTER TABLE [Item].[ProvinceStateDetail]  WITH CHECK ADD  CONSTRAINT [ProvinceStateID014] FOREIGN KEY([ProvinceStateID])
REFERENCES [Core].[ProvinceState] ([ProvinceStateID])
GO
ALTER TABLE [Item].[ProvinceStateDetail] CHECK CONSTRAINT [ProvinceStateID014]
GO
ALTER TABLE [Link].[CountryDetailToCountryCore]  WITH CHECK ADD  CONSTRAINT [CountryDetailID001] FOREIGN KEY([CountryDetailID])
REFERENCES [Item].[CountryDetail] ([CountryDetailID])
GO
ALTER TABLE [Link].[CountryDetailToCountryCore] CHECK CONSTRAINT [CountryDetailID001]
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore]  WITH CHECK ADD  CONSTRAINT [CountryRegionID004] FOREIGN KEY([CountryRegionID])
REFERENCES [Core].[CountryRegion] ([CountryRegionID])
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore] CHECK CONSTRAINT [CountryRegionID004]
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore]  WITH CHECK ADD  CONSTRAINT [CountrySubRegionID007] FOREIGN KEY([CountrySubRegionID])
REFERENCES [Core].[CountrySubRegion] ([CountrySubRegionID])
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore] CHECK CONSTRAINT [CountrySubRegionID007]
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore]  WITH CHECK ADD  CONSTRAINT [CounTYDetailID008] FOREIGN KEY([CounTYDetailID])
REFERENCES [Item].[CounTYDetail] ([CounTYDetailID])
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore] CHECK CONSTRAINT [CounTYDetailID008]
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore]  WITH CHECK ADD  CONSTRAINT [ProvinceStateID013] FOREIGN KEY([ProvinceStateID])
REFERENCES [Core].[ProvinceState] ([ProvinceStateID])
GO
ALTER TABLE [Link].[CounTYDetailToCounTYCore] CHECK CONSTRAINT [ProvinceStateID013]
GO
ALTER TABLE [Link].[ProvinceStateDetailToProvinceStateCore]  WITH CHECK ADD  CONSTRAINT [CountryRegionID005] FOREIGN KEY([CountryRegionID])
REFERENCES [Core].[CountryRegion] ([CountryRegionID])
GO
ALTER TABLE [Link].[ProvinceStateDetailToProvinceStateCore] CHECK CONSTRAINT [CountryRegionID005]
GO
ALTER TABLE [Link].[ProvinceStateDetailToProvinceStateCore]  WITH CHECK ADD  CONSTRAINT [CountrySubRegionID006] FOREIGN KEY([CountrySubRegionID])
REFERENCES [Core].[CountrySubRegion] ([CountrySubRegionID])
GO
ALTER TABLE [Link].[ProvinceStateDetailToProvinceStateCore] CHECK CONSTRAINT [CountrySubRegionID006]
GO
ALTER TABLE [Link].[ProvinceStateDetailToProvinceStateCore]  WITH CHECK ADD  CONSTRAINT [ProvinceStateDetailID015] FOREIGN KEY([ProvinceStateDetailID])
REFERENCES [Item].[ProvinceStateDetail] ([ProvinceStateDetailID])
GO
ALTER TABLE [Link].[ProvinceStateDetailToProvinceStateCore] CHECK CONSTRAINT [ProvinceStateDetailID015]
GO
/****** Object:  StoredProcedure [History].[upEndOfMonthAzureCostDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [History].[upEndOfMonthAzureCostDetail]
as
INSERT INTO History.AzureCostDetail select b.* from Stage.AzureCostDetail as b LEFT OUTER JOIN History.AzureCostDetail as a on
a.Date = b.date and a.serviceFamily = b.serviceFamily and a.consumedService = b.consumedService and a.meterName = b.meterName and a.meterCategory = b.meterCategory 
WHERE a.Date is NULL
GO
/****** Object:  StoredProcedure [Message].[upConfirmItemCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [Message].[upConfirmItemCountryDetail] (@hashValue Varbinary(32), @hashCount smallint OUTPUT)
as
Set @hashCount = 0
select @hashCount = count(HashValue) from Item.CountryDetail WHERE Hashvalue = @hashValue;
RETURN;
GO
/****** Object:  StoredProcedure [Message].[upConfirmItemCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [Message].[upConfirmItemCounTYDetail] (@hashValue Varbinary(32), @hashCount smallint OUTPUT)
as
Set @hashCount = 0
select @hashCount = count(HashValue) from Item.CounTYDetail WHERE Hashvalue = @hashValue;
RETURN;
GO
/****** Object:  StoredProcedure [Message].[upConfirmItemProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [Message].[upConfirmItemProvinceStateDetail] (@hashValue Varbinary(32), @hashCount smallint OUTPUT)
as
Set @hashCount = 0
select @hashCount = count(HashValue) from Item.ProvinceStateDetail WHERE Hashvalue = @hashValue;
RETURN;
GO
/****** Object:  StoredProcedure [Message].[upFlagCountryDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROCEDURE [Message].[upFlagCountryDetailItem]  (@hashValue VARBINARY(32))
AS
--UPDATE Stage.DailyChangeByCounTYJSON Set JSONFileCreateDate = GETDATE()WHERE ID = @ID;
INSERT INTO Message.SentCountryDetail
select getdate(), @hashValue
RETURN
GO
/****** Object:  StoredProcedure [Message].[upFlagCounTYDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Message].[upFlagCounTYDetailItem]  (@hashValue VARBINARY(32))
AS
--UPDATE Stage.DailyChangeByCounTYJSON Set JSONFileCreateDate = GETDATE()WHERE ID = @ID;
INSERT INTO Message.SentCounTYDetail
select getdate(), @hashValue
RETURN
GO
/****** Object:  StoredProcedure [Message].[upFlagMissingCountryDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Message].[upFlagMissingCountryDetailItem]
as
INSERT INTO Stage.MissingDailyChangeCountry 
SELECT * from Stage.DailyChangeByCountryJSON WHERE BulkColumn is NULL;
UPDATE Stage.DailyChangeByCountryJSON set JSONFileCreateDate  = ProcessDate WHERE BulkColumn is NULL;
RETURN(@@ROWCOUNT)
GO
/****** Object:  StoredProcedure [Message].[upFlagProvinceStateDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Message].[upFlagProvinceStateDetailItem]   (@hashValue VARBINARY(32))
AS
INSERT INTO Message.SentProvinceStateDetail
select getdate(), @hashValue
RETURN

GO
/****** Object:  StoredProcedure [Message].[upGenerateItemCountryDetailJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Message].[upGenerateItemCountryDetailJSON]
AS
     DECLARE @monitorDate DATETIME2, @dayCount INT, @counter INT,
     @line01 NVARCHAR(256), @line02 NVARCHAR(256), @movingAverageFactor SMALLINT, 
     @m NVARCHAR(MAX), @h varbinary(32), @location NVARCHAR(48), @itemCount INT;
     SET @movingAverageFactor = 30;
     TRUNCATE TABLE Stage.DailyChangeByCountryJSON;
     IF OBJECT_ID('tempdb.dbo.#1') IS NOT NULL
         DROP TABLE #1;
     SELECT ROW_NUMBER() OVER(
            ORDER BY [date]) AS ID, 
            [date], 
            '0000' AS FileNumber, 
            [location]
     INTO #1
     FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry]
     WHERE [date] >=
     (
         SELECT DATEADD(day, -1, MAX(date)) 
         FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry]
     );
     SET @itemCount = @@ROWCOUNT;
     SET @counter = 1;
     SELECT @location = location, 
            @monitorDate = [date]
     FROM #1
     WHERE ID = @counter;
     WHILE(@counter <= @itemCount)
         BEGIN
             EXEC Stage.upDailyChangeByCountryJSON 
                  @monitorDate, 
                  @location, 
                  
				  @hashValue = @h OUTPUT, 
                  @jsonMessage = @m OUTPUT;
             
			 INSERT INTO Stage.DailyChangeByCountryJSON
             VALUES
             (@counter, 
              @monitorDate, 
              '0000', 
              @location, 
			  @h,
              @m, 
			  NULL
             );
             SELECT @counter = @counter + 1;
             SELECT @location = location, 
                    @monitorDate = [date]
             FROM #1
             WHERE ID = @counter;
         END;
      INSERT INTO Stage.MissingDailyChangeCountry
            SELECT [ID]
      ,[ProcessDate]
      ,[FileNumber]
      ,[Location]
      ,[BulkColumn]
      ,[JSONFileCreateDate]
  FROM Stage.DailyChangeByCountryJSON
  WHERE BulkColumn IS NULL;
     TRUNCATE TABLE [Message].[OutGoingCountryDetail];
     INSERT INTO [Message].[OutGoingCountryDetail]
            SELECT HashValue, 
                   BulkColumn
            FROM Stage.DailyChangeByCountryJSON
            WHERE LEN(BULKColumn) > 0;  --no nulls
GO
/****** Object:  StoredProcedure [Message].[upGenerateItemCountryDetailJSONByDate]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Message].[upGenerateItemCountryDetailJSONByDate]  @dateToProcess date
AS
     DECLARE  @monitorDate datetime2, @dayCount INT, @counter INT,
     @line01 NVARCHAR(256), @line02 NVARCHAR(256), @movingAverageFactor SMALLINT, 
     @m NVARCHAR(MAX), @h varbinary(32), @location NVARCHAR(48), @itemCount INT;
     SET @movingAverageFactor = 30;
     TRUNCATE TABLE Stage.DailyChangeByCountryJSON;
     IF OBJECT_ID('tempdb.dbo.#1') IS NOT NULL
         DROP TABLE #1;
     SELECT ROW_NUMBER() OVER(
            ORDER BY [date]) AS ID, 
            [date], 
            '0000' AS FileNumber, 
            [location]
     INTO #1
     FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry]
     WHERE [date] =  @dateToProcess
;
     SET @itemCount = @@ROWCOUNT;
     SET @counter = 1;
     SELECT @location = location, 
            @monitorDate = [date]
     FROM #1
     WHERE ID = @counter;
     WHILE(@counter <= @itemCount)
         BEGIN
             EXEC Stage.upDailyChangeByCountryJSON 
                  @monitorDate, 
                  @location, 
                  
				  @hashValue = @h OUTPUT, 
                  @jsonMessage = @m OUTPUT;
             
			 INSERT INTO Stage.DailyChangeByCountryJSON
             VALUES
             (@counter, 
              @monitorDate, 
              '0000', 
              @location, 
			  @h,
              @m, 
			  NULL
             );
             SELECT @counter = @counter + 1;
             SELECT @location = location, 
                    @monitorDate = [date]
             FROM #1
             WHERE ID = @counter;
         END;
      INSERT INTO Stage.MissingDailyChangeCountry
            SELECT [ID]
      ,[ProcessDate]
      ,[FileNumber]
      ,[Location]
      ,[BulkColumn]
      ,[JSONFileCreateDate]
  FROM Stage.DailyChangeByCountryJSON
  WHERE BulkColumn IS NULL;
     TRUNCATE TABLE [Message].[OutGoingCountryDetail];
     INSERT INTO [Message].[OutGoingCountryDetail]
            SELECT HashValue, 
                   BulkColumn
            FROM Stage.DailyChangeByCountryJSON
            WHERE LEN(BULKColumn) > 0;  --no nulls
GO
/****** Object:  StoredProcedure [Message].[upGenerateItemCounTYDetailJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Message].[upGenerateItemCounTYDetailJSON]
AS
     DECLARE @monitorDate DATETIME2, @dayCount SMALLINT, @counter INT, @line01 NVARCHAR(256), @line02 NVARCHAR(256),
	 @m NVARCHAR(MAX), @hash VARBINARY(32), @censusCounty NVARCHAR(48), @state NVARCHAR(48), @itemCount INT,
	 @maxDate dateTime2;
     
     IF NOT EXISTS
     (
         SELECT *
         FROM sys.indexes
         WHERE name = 'index02'
     )
         CREATE INDEX index02 ON [Stage].[NYTimesCovid19USCounty]([Date], USCensusCounty, [State]);
     IF NOT EXISTS
     (
         SELECT *
         FROM sys.indexes
         WHERE name = 'index03'
     )
         CREATE INDEX index03 ON [Stage].[USCensusCountyPopulation](CTYNAME, STNAME);
     TRUNCATE TABLE Stage.DailyChangeByCounTYJSON;
	 	 
         SELECT @maxDate = MAX(date)
         FROM [Stage].[NYTimesCovid19USCounty];
	 
	 TRUNCATE TABLE History.PreviousDayCounTY;

	 INSERT INTO History.PreviousDayCounTY
	 select date, county, state, fips, cases, deaths from History.NYTimesCovid19USCounTY 
	 where date = DATEADD(day, -1, @maxDate)
	 	 
     IF OBJECT_ID('tempdb.dbo.#1') IS NOT NULL
         DROP TABLE #1;
     SELECT ROW_NUMBER() OVER(
            ORDER BY [date]) AS ID, 
            [date], 
            '00000' AS FileNumber, 
            [USCensusCounty], 
            [State]
     INTO #1
     FROM [Stage].[NYTimesCovid19USCounty] -- Source table
     WHERE [date] = @maxDate;
     
     SET @itemCount = @@ROWCOUNT;
     SET @counter = 1;
     CREATE INDEX index03 ON #1(ID);
     SELECT @censusCounty = USCensusCounty, 
            @monitorDate = [date], 
            @state = [state]
     FROM #1
     WHERE ID = @counter;
     WHILE(@counter <= @itemCount)
         BEGIN
             EXEC Stage.upDailyChangeByCounTYJSON 
                  @monitorDate, 
                  @censusCounty, 
                  @state, 
                  @hashValue = @hash OUTPUT, 
                  @jsonMessage = @m OUTPUT;
             INSERT INTO Stage.DailyChangeByCounTYJSON
             VALUES
             (@counter, 
              @monitorDate, 
              '00000', 
              @censusCounty, 
              @state, 
              @hash, 
              @m, 
              NULL
             );
             SELECT @counter = @counter + 1;
             SELECT @censusCounty = USCensusCounty, 
                    @state = [state], 
                    @monitorDate = [date]
             FROM #1
             WHERE ID = @counter;
         END;

     INSERT INTO Stage.MissingDailyChangeCounTY
            SELECT [ID], 
                   [ProcessDate], 
                   [FileNumber], 
                   [USCensusCounty], 
                   [State], 
                   [BulkColumn], 
                   [JSONFileCreateDate]
            FROM Stage.DailyChangeByCounTYJSON
            WHERE BulkColumn IS NULL;
     
	 TRUNCATE TABLE [Message].[OutGoingCounTYDetail];
     INSERT INTO [Message].[OutGoingCounTYDetail]
            SELECT HashValue, 
                   BulkColumn
            FROM Stage.DailyChangeByCounTYJSON
            WHERE LEN(BULKColumn) > 0;  --no nulls

GO
/****** Object:  StoredProcedure [Message].[upGenerateItemProvinceStateDetailJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Message].[upGenerateItemProvinceStateDetailJSON]
AS
     DECLARE @monitorDate DATETIME2, @dayCount INT, @counter INT, @line01 NVARCHAR(256), @line02 NVARCHAR(256), @m NVARCHAR(MAX), @hashValue VARBINARY(32), @stateName NVARCHAR(48), @itemCount INT, @h NVARCHAR(MAX);
     TRUNCATE TABLE Stage.DailyChangeByProvinceStateJSON;
     IF OBJECT_ID('tempdb.dbo.#1') IS NOT NULL
         DROP TABLE #1;
     SELECT ROW_NUMBER() OVER(
            ORDER BY [date]) AS ID, 
            [Date], 
            '0000' AS FileNumber, 
            [StateName], 
            HashValue
     INTO #1
     FROM [Stage].[CovidTrackingDailyState]
     WHERE [date] =
     (
         SELECT MAX(date)
         FROM [Covid19DataVault].[Stage].[CovidTrackingDailyState]
     );
     SET @itemCount = @@ROWCOUNT;
     SET @counter = 1;
     SELECT @stateName = StateName, 
            @monitorDate = [date], 
            @hashValue = Hashvalue
     FROM #1
     WHERE ID = @counter;
     WHILE(@counter <= @itemCount)
         BEGIN
             SELECT @m =
             (
                 SELECT [Date], 
                        [State], 
                        [Positive], 
                        [Negative], 
                        [Death], 
                        [Hospitalized], 
                        [PreviousPeriodToDatePositiveCount], 
                        [PreviousPeriodToDateNegativeCount], 
                        [PreviousPeriodToDateDeathCount], 
                        [PreviousPeriodToDateHospitalizedCount], 
                        [PreviousPeriodToDate], 
                        [PopulationYear], 
                        [Population], 
                        [PopulationDensity], 
                        [LandArea], 
                        [StateName], 
                        [CountryRegion], 
                        [CountrySubRegion], 
                        [Hash], 
                        HashValue, 
                        [LoadTime], 
                        [Source]
                 FROM [Stage].[CovidTrackingDailyState]
                 WHERE date = @monitorDate
                       AND StateName = @stateName FOR JSON AUTO
             );
             INSERT INTO Stage.DailyChangeByProvinceStateJSON
             VALUES
             (@counter, 
              @monitorDate, 
              '0000', 
              @stateName, 
              @hashValue, 
              @m, 
              NULL
             );
             SELECT @counter = @counter + 1;
             SELECT @stateName = StateName, 
                    @monitorDate = [date], 
                    @hashValue = HashValue
             FROM #1
             WHERE ID = @counter;
         END;
     INSERT INTO Stage.MissingDailyChangeProvinceState
            SELECT [ID], 
                   [ProcessDate], 
                   [FileNumber], 
                   [StateName], 
                   [BulkColumn], 
                   [JSONFileCreateDate]
            FROM Stage.DailyChangeByProvinceStateJSON
            WHERE BulkColumn IS NULL;
     TRUNCATE TABLE [Message].[OutGoingProvinceStateDetail];
     INSERT INTO [Message].[OutGoingProvinceStateDetail]
            SELECT HashValue, 
                   BulkColumn
            FROM Stage.DailyChangeByProvinceStateJSON
            WHERE LEN(BULKColumn) > 0;  --no nulls

     RETURN;
GO
/****** Object:  StoredProcedure [Message].[upGetCountryDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROCEDURE [Message].[upGetCountryDetailItem]
AS
select JSONMessage, HashValue  from  [Message].OutgoingCountryDetail;
GO
/****** Object:  StoredProcedure [Message].[upGetCounTYDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create   PROCEDURE [Message].[upGetCounTYDetailItem]
AS
select JSONMessage, HashValue  from  [Message].OutgoingCounTYDetail;
GO
/****** Object:  StoredProcedure [Message].[upGetHashValueItemCountryException]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    procedure [Message].[upGetHashValueItemCountryException]
as
select HashValue, JSONMessage from Message.OutGoingCountryDetail WHERE HashValue
in (select HashValue from Message.SentCountryDetail) and HashValue in
(select HashValue from Message.ReceivedItemCountryDetail WHERE HashCount = 0)
GO
/****** Object:  StoredProcedure [Message].[upGetHashValueItemCounTYException]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    procedure [Message].[upGetHashValueItemCounTYException]
as
select HashValue, JSONMessage from Message.OutGoingCounTYDetail WHERE HashValue
in (select HashValue from Message.SentCounTYDetail) and HashValue in
(select HashValue from Message.ReceivedItemCounTYDetail WHERE HashCount = 0)
GO
/****** Object:  StoredProcedure [Message].[upGetHashValueItemProvinceStateException]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    procedure [Message].[upGetHashValueItemProvinceStateException]
as
select JSONMessage, HashValue from Message.OutGoingProvinceStateDetail WHERE HashValue
in (select HashValue from Message.SentProvinceStateDetail) and HashValue in
(select HashValue from Message.ReceivedItemProvinceStateDetail WHERE HashCount = 0)
GO
/****** Object:  StoredProcedure [Message].[upGetProvinceStateDetailItem]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Message].[upGetProvinceStateDetailItem]
AS
select JSONMessage, HashValue  from  [Message].OutGoingProvinceStateDetail;
GO
/****** Object:  StoredProcedure [Message].[upInsertCountryJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [Message].[upInsertCountryJSON] @message NVARCHAR(MAX)
AS
     DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT;

     IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
         DROP TABLE #inBound;
     IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
         DROP TABLE #add;
     IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
         DROP TABLE #error;

     --create table #JSONMessage (BulkColumn nvarchar(max))
	  CREATE TABLE #error
     ([ID]                 [INT] NOT NULL, 
      [ErrorMessage]	   NVARCHAR(MAX) NULL, 
      [EffectiveStartDate] [DATETIME2](7) NULL);
     
     
	 CREATE TABLE #inBound
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
     
	 CREATE TABLE #add
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
	      --insert json	
     INSERT INTO #inBound
     (ID, 
      SourceReferenceKey, 
      [Source], 
      EffectiveStartDate, 
      EffectiveEndDate, 
      HashValue, 
      [NewID]
     )
            SELECT ROW_NUMBER() OVER(
                   ORDER BY SourceReferenceKey), 
                   SourceReferenceKey, 
                   [Source], 
                   GETDATE(), 
                   '9999/01/01', 
                   HASHBYTES('SHA2_256', CAST([SourceReferenceKey] AS NVARCHAR(27))), 
                   0
            FROM OPENJSON(@message) WITH(SourceReferenceKey NVARCHAR(32) '$.location',
			[Source] NVARCHAR(108) '$.Source' )
            GROUP BY SourceReferenceKey, [Source];

     --compare items from Core.table and insert into #add
     INSERT INTO #add
            SELECT ROW_NUMBER() OVER(
                   ORDER BY a.SourceReferenceKey), 
                   a.SourceReferenceKey, 
                   a.Source, 
                   a.EffectiveStartDate, 
                   a.EffectiveEndDate, 
                   a.HashValue, 
                   0
            FROM #inBound AS a
                 LEFT OUTER JOIN Core.Country AS b ON a.SourceReferenceKey = b.SourceReferenceKey
            WHERE b.SourceReferenceKey IS NULL;
     SET @itemCount = @@ROWCOUNT;
     SET @maxID = 0;
     SELECT @maxID = MAX(CountryID)
     FROM Core.Country;
     --table is empty
     IF @maxID IS NULL
         SELECT @maxID = 0, 
                @nextID = 1;
     SELECT @counter = 1;
     --assign ID
     WHILE(@counter <= @itemCount)
         BEGIN
             UPDATE #add
               SET 
                   [NewID] = @nextID
             WHERE ID = @counter;
             SELECT @counter = @counter + 1, 
                    @nextID = @nextID + 1;
         END;

     --insert #add to Core.Table
     INSERT INTO Core.Country
            SELECT [NewId], 
                   SourceReferenceKey, 
                   [Source], 
                   EffectiveStartDate, 
                   EffectiveEndDate, 
                   HashValue
            FROM #add;
     RETURN(@itemCount);
	 
GO
/****** Object:  StoredProcedure [Message].[upInsertCountryRegionJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [Message].[upInsertCountryRegionJSON] @message NVARCHAR(MAX)
AS
--table Name Core.CountryRegion
-- primary key Core.CountryRegion.CountryRegionID
--JSON column $.REGION

     DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT;

     IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
         DROP TABLE #inBound;
     IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
         DROP TABLE #add;
     IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
         DROP TABLE #error;

     --create table #JSONMessage (BulkColumn nvarchar(max))
	  CREATE TABLE #error
     ([ID]                 [INT] NOT NULL, 
      [ErrorMessage]	   NVARCHAR(MAX) NULL, 
      [EffectiveStartDate] [DATETIME2](7) NULL);
     
     
	 CREATE TABLE #inBound
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
     
	 CREATE TABLE #add
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
	      --insert json	
     INSERT INTO #inBound
     (ID, 
      SourceReferenceKey, 
      [Source], 
      EffectiveStartDate, 
      EffectiveEndDate, 
      HashValue, 
      [NewID]
     )
            SELECT ROW_NUMBER() OVER(
                   ORDER BY SourceReferenceKey), 
                   SourceReferenceKey, 
                   [Source], 
                   GETDATE(), 
                   '9999/01/01', 
                   HASHBYTES('SHA2_256', CAST([SourceReferenceKey] AS NVARCHAR(27))), 
                   0
             FROM OPENJSON(@message) WITH(SourceReferenceKey NVARCHAR(32) '$.RegionName',
			[Source] NVARCHAR(108) '$.Source') GROUP BY SourceReferenceKey, 
                   [Source];

     --compare items from Core.table and insert into #add
     INSERT INTO #add
            SELECT ROW_NUMBER() OVER(
                   ORDER BY a.SourceReferenceKey), 
                   a.SourceReferenceKey, 
                   a.Source, 
                   a.EffectiveStartDate, 
                   a.EffectiveEndDate, 
                   a.HashValue, 
                   0
            FROM #inBound AS a
                 LEFT OUTER JOIN Core.Country AS b ON a.SourceReferenceKey = b.SourceReferenceKey
            WHERE b.SourceReferenceKey IS NULL;
     SET @itemCount = @@ROWCOUNT;
     SET @maxID = 0;
	 SELECT @maxID = MAX(CountryRegionID)
     FROM Core.CountryRegion;
     --table is empty
     IF @maxID IS NULL
         SELECT @maxID = 0, 
                @nextID = 1;
     SELECT @counter = 1;
     --assign ID
     WHILE(@counter <= @itemCount)
         BEGIN
             UPDATE #add
               SET 
                   [NewID] = @nextID
             WHERE ID = @counter;
             SELECT @counter = @counter + 1, 
                    @nextID = @nextID + 1;
         END;

     --insert #add to Core.Table
     INSERT INTO Core.CountryRegion
            SELECT [NewId], 
                   SourceReferenceKey, 
                   [Source], 
                   EffectiveStartDate, 
                   EffectiveEndDate, 
                   HashValue
            FROM #add;
     RETURN(@itemCount);
	 
GO
/****** Object:  StoredProcedure [Message].[upInsertCountrySubRegionJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [Message].[upInsertCountrySubRegionJSON] @message NVARCHAR(MAX)
AS
--table Name Core.CountrySubRegion
-- primary key Core.CountrySubRegion.CountrySubRegionID
--JSON column $.DivisionName

     DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT;

     IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
         DROP TABLE #inBound;
     IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
         DROP TABLE #add;
     IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
         DROP TABLE #error;

     --create table #JSONMessage (BulkColumn nvarchar(max))
	  CREATE TABLE #error
     ([ID]                 [INT] NOT NULL, 
      [ErrorMessage]	   NVARCHAR(MAX) NULL, 
      [EffectiveStartDate] [DATETIME2](7) NULL);
     
     
	 CREATE TABLE #inBound
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
     
	 CREATE TABLE #add
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
	      --insert json	
     INSERT INTO #inBound
     (ID, 
      SourceReferenceKey, 
      [Source], 
      EffectiveStartDate, 
      EffectiveEndDate, 
      HashValue, 
      [NewID]
     )
            SELECT ROW_NUMBER() OVER(
                   ORDER BY SourceReferenceKey), 
                   SourceReferenceKey, 
                   [Source], 
                   GETDATE(), 
                   '9999/01/01', 
                   HASHBYTES('SHA2_256', CAST([SourceReferenceKey] AS NVARCHAR(27))), 
                   0
            FROM OPENJSON(@message) WITH(SourceReferenceKey NVARCHAR(32) '$.DivisionName',
			[Source] NVARCHAR(108) '$.Source')
            GROUP BY SourceReferenceKey, [Source];

     --compare items from Core.table and insert into #add
     INSERT INTO #add
            SELECT ROW_NUMBER() OVER(
                   ORDER BY a.SourceReferenceKey), 
                   a.SourceReferenceKey, 
                   a.Source, 
                   a.EffectiveStartDate, 
                   a.EffectiveEndDate, 
                   a.HashValue, 
                   0
            FROM #inBound AS a
                 LEFT OUTER JOIN Core.Country AS b ON a.SourceReferenceKey = b.SourceReferenceKey
            WHERE b.SourceReferenceKey IS NULL;
     SET @itemCount = @@ROWCOUNT;
     SET @maxID = 0;
	 SELECT @maxID = MAX(CountrySubRegionID)
     FROM Core.CountrySubRegion;
     --table is empty
     IF @maxID IS NULL
         SELECT @maxID = 0, 
                @nextID = 1;
     SELECT @counter = 1;
     --assign ID
     WHILE(@counter <= @itemCount)
         BEGIN
             UPDATE #add
               SET 
                   [NewID] = @nextID
             WHERE ID = @counter;
             SELECT @counter = @counter + 1, 
                    @nextID = @nextID + 1;
         END;

     --insert #add to Core.Table
     INSERT INTO Core.CountrySubRegion
            SELECT [NewId], 
                   SourceReferenceKey, 
                   [Source], 
                   EffectiveStartDate, 
                   EffectiveEndDate, 
                   HashValue
            FROM #add;
     RETURN(@itemCount);
	 
GO
/****** Object:  StoredProcedure [Message].[upInsertCountyJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [Message].[upInsertCountyJSON] @message NVARCHAR(MAX)
AS
--table Name Core.County
-- primary key Core.County.CountyID
--JSON column $.CTYNAME

     DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT;

     IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
         DROP TABLE #inBound;
     IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
         DROP TABLE #add;
     IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
         DROP TABLE #error;

     --create table #JSONMessage (BulkColumn nvarchar(max))
	  CREATE TABLE #error
     ([ID]                 [INT] NOT NULL, 
      [ErrorMessage]	   NVARCHAR(MAX) NULL, 
      [EffectiveStartDate] [DATETIME2](7) NULL);
     
     
	 CREATE TABLE #inBound
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
     
	 CREATE TABLE #add
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
	      --insert json	
     INSERT INTO #inBound
     (ID, 
      SourceReferenceKey, 
      [Source], 
      EffectiveStartDate, 
      EffectiveEndDate, 
      HashValue, 
      [NewID]
     )
            SELECT ROW_NUMBER() OVER(
                   ORDER BY SourceReferenceKey), 
                   SourceReferenceKey, 
                   [Source], 
                   GETDATE(), 
                   '9999/01/01', 
                   HASHBYTES('SHA2_256', CAST([SourceReferenceKey] AS NVARCHAR(27))), 
                   0
            FROM OPENJSON(@message) WITH(SourceReferenceKey NVARCHAR(32) '$.CTYNAME',
			[Source] NVARCHAR(108) '$.Source')
            GROUP BY SourceReferenceKey, [Source];

     --compare items from Core.table and insert into #add
     INSERT INTO #add
            SELECT ROW_NUMBER() OVER(
                   ORDER BY a.SourceReferenceKey), 
                   a.SourceReferenceKey, 
                   a.Source, 
                   a.EffectiveStartDate, 
                   a.EffectiveEndDate, 
                   a.HashValue, 
                   0
            FROM #inBound AS a
                 LEFT OUTER JOIN Core.Country AS b ON a.SourceReferenceKey = b.SourceReferenceKey
            WHERE b.SourceReferenceKey IS NULL;
     SET @itemCount = @@ROWCOUNT;
     SET @maxID = 0;
	 SELECT @maxID = MAX(CountyID)
     FROM Core.County;
     --table is empty
     IF @maxID IS NULL
         SELECT @maxID = 0, 
                @nextID = 1;
     SELECT @counter = 1;
     --assign ID
     WHILE(@counter <= @itemCount)
         BEGIN
             UPDATE #add
               SET 
                   [NewID] = @nextID
             WHERE ID = @counter;
             SELECT @counter = @counter + 1, 
                    @nextID = @nextID + 1;
         END;

     --insert #add to Core.Table
     INSERT INTO Core.County
            SELECT [NewId], 
                   SourceReferenceKey, 
                   [Source], 
                   EffectiveStartDate, 
                   EffectiveEndDate, 
                   HashValue
            FROM #add;
     RETURN(@itemCount);
	 
GO
/****** Object:  StoredProcedure [Message].[upInsertProvinceStateJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Message].[upInsertProvinceStateJSON] @message NVARCHAR(MAX)
AS
--table Name Core.ProvinceState
-- primary key Core.ProvinceState.ProvinceStateID
--JSON column $.STNAME

     DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT;

     IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
         DROP TABLE #inBound;
     IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
         DROP TABLE #add;
     IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
         DROP TABLE #error;

     --create table #JSONMessage (BulkColumn nvarchar(max))
	  CREATE TABLE #error
     ([ID]                 [INT] NOT NULL, 
      [ErrorMessage]	   NVARCHAR(MAX) NULL, 
      [EffectiveStartDate] [DATETIME2](7) NULL);
     
     
	 CREATE TABLE #inBound
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
     
	 CREATE TABLE #add
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
	      --insert json	
     INSERT INTO #inBound
     (ID, 
      SourceReferenceKey, 
      [Source], 
      EffectiveStartDate, 
      EffectiveEndDate, 
      HashValue, 
      [NewID]
     )
            SELECT ROW_NUMBER() OVER(
                   ORDER BY SourceReferenceKey), 
                   SourceReferenceKey, 
                   [Source], 
                   GETDATE(), 
                   '9999/01/01', 
                   HASHBYTES('SHA2_256', CAST([SourceReferenceKey] AS NVARCHAR(27))), 
                   0
            FROM OPENJSON(@message) WITH(SourceReferenceKey NVARCHAR(32) '$.state', 
			[Source] NVARCHAR(108) '$.Source')
            GROUP BY SourceReferenceKey, [Source];

     --compare items from Core.table and insert into #add
     INSERT INTO #add
            SELECT ROW_NUMBER() OVER(
                   ORDER BY a.SourceReferenceKey), 
                   a.SourceReferenceKey, 
                   a.Source, 
                   a.EffectiveStartDate, 
                   a.EffectiveEndDate, 
                   a.HashValue, 
                   0
            FROM #inBound AS a
                 LEFT OUTER JOIN Core.ProvinceState AS b ON a.SourceReferenceKey = b.SourceReferenceKey
            WHERE b.SourceReferenceKey IS NULL;
     SET @itemCount = @@ROWCOUNT;
     SET @maxID = 0;
	 SELECT @maxID = MAX(ProvinceStateID)
     FROM Core.ProvinceState;
     --table is empty
     IF @maxID IS NULL
         SELECT @maxID = 0, 
                @nextID = 1;
     SELECT @counter = 1;
     --assign ID
     WHILE(@counter <= @itemCount)
         BEGIN
             UPDATE #add
               SET 
                   [NewID] = @nextID
             WHERE ID = @counter;
             SELECT @counter = @counter + 1, 
                    @nextID = @nextID + 1;
         END;

     --insert #add to Core.Table
     INSERT INTO Core.ProvinceState
            SELECT [NewId], 
                   SourceReferenceKey, 
                   [Source], 
                   EffectiveStartDate, 
                   EffectiveEndDate, 
                   HashValue
            FROM #add;
     RETURN(@itemCount);
	 
GO
/****** Object:  StoredProcedure [Message].[upInsertWorldRegionJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Message].[upInsertWorldRegionJSON]
   @message nvarchar(max)
   as 
 
  declare @nextID int
  , @itemCount int
  , @startEffectiveDate DATETIME2
  , @maxID int
  , @counter int

  IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
   DROP TABLE #inBound;

  IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
   DROP TABLE #add;

   IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
   DROP TABLE #error;

   --create table #JSONMessage (BulkColumn nvarchar(max))
   select * into #error from Core.WorldRegion WHERE 1 = 1

   CREATE TABLE #inBound (
		[ID] [int] NOT NULL,
		[SourceReferenceKey] [nvarchar](64) NOT NULL,
		[Source] [nvarchar](108) NOT NULL,
		[EffectiveStartDate] [datetime2](7) NOT NULL,
		[EffectiveEndDate] [datetime2](7) NOT NULL,
		[HashValue] [varbinary](32) NOT NULL,
		[NewID] int )

	CREATE TABLE #add (
		[ID] [int] NOT NULL,
		[SourceReferenceKey] [nvarchar](64) NOT NULL,
		[Source] [nvarchar](108) NOT NULL,
		[EffectiveStartDate] [datetime2](7) NOT NULL,
		[EffectiveEndDate] [datetime2](7) NOT NULL,
		[HashValue] [varbinary](32) NOT NULL,
		[NewID] int )
	
	--insert json	
	INSERT INTO #inBound  (ID, SourceReferenceKey, [Source], EffectiveStartDate, EffectiveEndDate, HashValue, [NewID])
	SELECT  ROW_NUMBER() OVER(ORDER BY SourceReferenceKey), SourceReferenceKey, 'Covid19DataVault' ,  getdate(), '9999/01/01', 
	HASHBYTES( 'SHA2_256' , CAST([SourceReferenceKey] AS NVARCHAR(27))), 0
	FROM OPENJSON(@message) WITH (SourceReferenceKey  NVARCHAR(32) '$.WorldRegion'  ) Group BY SourceReferenceKey;
	
	
	--compare items from Core.table and insert into #add
	insert into #add 
	select ROW_NUMBER() OVER(ORDER BY a.SourceReferenceKey), a.SourceReferenceKey, 
	a.Source, a.EffectiveStartDate, a.EffectiveEndDate, a.HashValue, 0
	from #inBound  as a LEFT OUTER JOIN  
	Core.WorldRegion as b on  
	a.SourceReferenceKey = b.SourceReferenceKey 
	WHERE b.SourceReferenceKey is NULL
		
	set @itemCount = @@ROWCOUNT
	
	set @maxID = 0
	select @maxID= max(WorldRegionID) from Core.WorldRegion
	--table is empty
	if @maxID is NULL
		select @maxID  = 0, @nextID = 1 
	select @counter = 1
	--assign ID
	WHILE(@counter <= @itemCount)
    BEGIN
        UPDATE #add
          SET 
              [NewID] = @nextID 
        WHERE ID = @counter;
		SELECT @counter = @counter + 1, @nextID = @nextID + 1;
    END;

	--insert #add to Core.Table
	INSERT INTO Core.WorldRegion
	select [NewId], SourceReferenceKey, [Source], EffectiveStartDate, EffectiveEndDate, HashValue from #add 
	RETURN(@itemCount)
GO
/****** Object:  StoredProcedure [Message].[upInsertWorldSubRegionJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [Message].[upInsertWorldSubRegionJSON] @message NVARCHAR(MAX)
AS
     DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT;

     IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
         DROP TABLE #inBound;
     IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
         DROP TABLE #add;
     IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
         DROP TABLE #error;

     --create table #JSONMessage (BulkColumn nvarchar(max))
     SELECT *
     INTO #error
     FROM Core.WorldSubRegion
     WHERE 1 = 1;
     
	 CREATE TABLE #inBound
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
     
	 CREATE TABLE #add
     ([ID]                 [INT] NOT NULL, 
      [SourceReferenceKey] [NVARCHAR](64) NOT NULL, 
      [Source]             [NVARCHAR](108) NOT NULL, 
      [EffectiveStartDate] [DATETIME2](7) NOT NULL, 
      [EffectiveEndDate]   [DATETIME2](7) NOT NULL, 
      [HashValue]          [VARBINARY](32) NOT NULL, 
      [NewID]              INT
     );
	      --insert json	
     INSERT INTO #inBound
     (ID, 
      SourceReferenceKey, 
      [Source], 
      EffectiveStartDate, 
      EffectiveEndDate, 
      HashValue, 
      [NewID]
     )
            SELECT ROW_NUMBER() OVER(
                   ORDER BY SourceReferenceKey), 
                   SourceReferenceKey, 
                   'Covid19DataVault', 
                   GETDATE(), 
                   '9999/01/01', 
                   HASHBYTES('SHA2_256', CAST([SourceReferenceKey] AS NVARCHAR(27))), 
                   0
            FROM OPENJSON(@message) WITH(SourceReferenceKey NVARCHAR(32) '$.WorldSubRegion')
            GROUP BY SourceReferenceKey;

     --compare items from Core.table and insert into #add
     INSERT INTO #add
            SELECT ROW_NUMBER() OVER(
                   ORDER BY a.SourceReferenceKey), 
                   a.SourceReferenceKey, 
                   a.Source, 
                   a.EffectiveStartDate, 
                   a.EffectiveEndDate, 
                   a.HashValue, 
                   0
            FROM #inBound AS a
                 LEFT OUTER JOIN Core.WorldSubRegion AS b ON a.SourceReferenceKey = b.SourceReferenceKey
            WHERE b.SourceReferenceKey IS NULL;
     SET @itemCount = @@ROWCOUNT;
     SET @maxID = 0;
     SELECT @maxID = MAX(WorldSubRegionID)
     FROM Core.WorldSubRegion;
     --table is empty
     IF @maxID IS NULL
         SELECT @maxID = 0, 
                @nextID = 1;
     SELECT @counter = 1;
     --assign ID
     WHILE(@counter <= @itemCount)
         BEGIN
             UPDATE #add
               SET 
                   [NewID] = @nextID
             WHERE ID = @counter;
             SELECT @counter = @counter + 1, 
                    @nextID = @nextID + 1;
         END;

     --insert #add to Core.Table
     INSERT INTO Core.WorldSubRegion
            SELECT [NewId], 
                   SourceReferenceKey, 
                   [Source], 
                   EffectiveStartDate, 
                   EffectiveEndDate, 
                   HashValue
            FROM #add;
     RETURN(@itemCount);
	 
GO
/****** Object:  StoredProcedure [Message].[upItemCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Message].[upItemCountryDetail] @message NVARCHAR(MAX)
AS

/*--for testing
DECLARE @message NVARCHAR(MAX), @x INT;
SELECT @message = BulkColumn
FROM Stage.JsonDocument;
--SELECT @message
*/
--removed CountryID from LInk.CountryDetailToCountryCore 2020-04-30

    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @maxLinkID INT, @nextLinkID INT, @counter INT;
        IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
            DROP TABLE #inBound;
        IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
            DROP TABLE #add;
        IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
            DROP TABLE #error;

        --create table #JSONMessage (BulkColumn nvarchar(max))
        CREATE TABLE #error
        ([ID]                 [INT] NOT NULL, 
         [ErrorMessage]       NVARCHAR(MAX) NULL, 
         [EffectiveStartDate] [DATETIME2](7) NULL
        );
        CREATE TABLE #inBound
        (ID                               [INT] NOT NULL, 
         [MonitorDate]                    [DATETIME2] NOT NULL, 
         [Country]                        [NVARCHAR](48), 
         [CaseCount]                      [INT] NOT NULL, 
         [DeathCount]                     [INT] NOT NULL, 
         [PeriodToDateCaseCount]          [INT] NOT NULL, 
         [PeriodToDateDeathCount]         [INT] NOT NULL, 
         [Population]                     [BIGINT] NOT NULL, 
         [CaseCountPerPopulationPercent]  [DECIMAL](29, 13) NOT NULL, 
         [DeathCountPerPopulationPercent] [DECIMAL](29, 13) NOT NULL, 
         [IncomePerCapita2018]            [DECIMAL](12, 2) NOT NULL, 
         [PopulationDensityPerKilometer]  [DECIMAL](12, 2) NOT NULL, 
         [CaseThirtyDayMovingAverage]     [INT] NOT NULL, 
         [DeathThirtyDayMovingAverage]    [INT] NOT NULL, 
         [CountryCode]                    [NVARCHAR](8) NOT NULL, 
         [WorldRegion]                    [NVARCHAR](64) NULL, 
         [WorldSubRegion]                 [NVARCHAR](64) NULL, 
         EffectiveStartDate               DATETIME2 NOT NULL, 
         EffectiveEndDate                 DATETIME2 NOT NULL, 
         [HashValue]                      [VARBINARY](32) NULL, 
         [Source]                         [NVARCHAR](108) NOT NULL
        );
        CREATE TABLE #add
        (ID                               [INT] NOT NULL, 
         CountryID                        [INT] NULL, 
         [MonitorDate]                    [DATETIME2], 
         [CaseCount]                      [INT] NOT NULL, 
         [DeathCount]                     [INT] NOT NULL, 
         [PeriodToDateCaseCount]          [INT] NOT NULL, 
         [PeriodToDateDeathCount]         [INT] NOT NULL, 
         [Population]                     [BIGINT] NOT NULL, 
         [CaseCountPerPopulationPercent]  [DECIMAL](29, 13) NOT NULL, 
         [DeathCountPerPopulationPercent] [DECIMAL](29, 13) NOT NULL, 
         [IncomePerCapita2018]            [DECIMAL](12, 2) NOT NULL, 
         [PopulationDensityPerKilometer]  [DECIMAL](12, 2) NOT NULL, 
         [CaseThirtyDayMovingAverage]     [INT] NOT NULL, 
         [DeathThirtyDayMovingAverage]    [INT] NOT NULL, 
         [CountryCode]                    [NVARCHAR](8) NOT NULL, 
         [WorldRegion]                    [NVARCHAR](64) NULL, 
         [WorldSubRegion]                 [NVARCHAR](64) NULL, 
         EffectiveStartDate               DATETIME2 NOT NULL, 
         EffectiveEndDate                 DATETIME2 NOT NULL, 
         [HashValue]                      VARBINARY(32) NOT NULL, 
         [Source]                         [NVARCHAR](108) NOT NULL, 
         [NewCountryDetailID]             INT, 
         [NewLinkID]                      INT
        );
        --insert json	

        INSERT INTO #inBound
        (ID, 
         [MonitorDate], --[Date]
         [Country], --[location]
         [CaseCount], --[new_cases]
         [DeathCount], --[new_deaths]
         [PeriodToDateCaseCount], --[total_cases]
         [PeriodToDateDeathCount], --[total_deaths]
         [Population], 
         [CaseCountPerPopulationPercent], 
         [DeathCountPerPopulationPercent], 
         [IncomePerCapita2018], 
         [PopulationDensityPerKilometer], 
         [CaseThirtyDayMovingAverage], 
         [DeathThirtyDayMovingAverage], 
         [CountryCode], 
         [WorldRegion], 
         [WorldSubRegion], 
         EffectiveStartDate, --getdate()
         EffectiveEndDate, --'9999/01/01'
         [HashValue], --[Hash]
         [Source]
        )
               SELECT ROW_NUMBER() OVER(
                      ORDER BY [date]), 
                      [date], 
                      [location], 
                      [new_cases], 
                      [new_deaths], 
                      [total_cases], 
                      [total_deaths], 
                      [Population], 
                      [CaseCountPerPopulationPercent], 
                      [DeathCountPerPopulationPercent], 
                      [IncomePerCapita2018], 
                      [PopulationDensityPerKilometer], 
                      [CaseThirtyDayMovingAverage], 
                      [DeathThirtyDayMovingAverage], 
                      [CountryCode], 
                      [WorldRegion], 
                      [WorldSubRegion], 
                      GETDATE(), 
                      '9999/01/01', 
                      [Hash], 
                      [Source]
               FROM OPENJSON(@message) WITH([date] DATETIME2 '$.date', [location] NVARCHAR(32) '$.location', [new_cases] INT '$.new_cases', [new_deaths] INT '$.new_deaths', [total_cases] INT '$.total_cases', [total_deaths] INT '$.total_deaths', [Population] BIGINT '$.Population', [CaseCountPerPopulationPercent] [DECIMAL](16, 8) '$.CaseCountPerPopulationPercent', [DeathCountPerPopulationPercent] [DECIMAL](16, 8) '$.DeathCountPerPopulationPercent', [IncomePerCapita2018] [DECIMAL](12, 2) '$.IncomePerCapita2018', [PopulationDensityPerKilometer] [DECIMAL](12, 2) '$.PopulationDensityPerKilometer', [CaseThirtyDayMovingAverage] [INT] '$.CaseThirtyDayMovingAverage', [DeathThirtyDayMovingAverage] [INT] '$.DeathThirtyDayMovingAverage', [CountryCode] NVARCHAR(8) '$.CountryCode', [WorldRegion] NVARCHAR(8) '$.WorldRegion', [WorldSubRegion] NVARCHAR(8) '$.WorldSubRegion', [Hash] VARBINARY(32) '$.Hash', [Source] NVARCHAR(108) '$.Source');
        INSERT INTO #add
               SELECT ROW_NUMBER() OVER(
                      ORDER BY a.MonitorDate), 
                      b.CountryID, 
                      a.[MonitorDate], --[Date]
                      a.[CaseCount], --[new_cases]
                       a.[DeathCount], --[new_deaths]
                      a.[PeriodToDateCaseCount], --[total_cases]
                      a.[PeriodToDateDeathCount], --[total_deaths]
                      a.[Population], 
                      a.[CaseCountPerPopulationPercent], 
                      a.[DeathCountPerPopulationPercent], 
                      a.[IncomePerCapita2018], 
                      a.[PopulationDensityPerKilometer], 
                      a.[CaseThirtyDayMovingAverage], 
                      a.[DeathThirtyDayMovingAverage], 
                      a.[CountryCode], 
                      a.[WorldRegion], 
                      a.[WorldSubRegion], 
                      a.EffectiveStartDate, --getdate()
                      a.EffectiveEndDate, --'9999/01/01'
                      a.[HashValue], --[Hash]
                      a.[Source], 
                      0, 
                      0
               FROM #inBound AS a
                    INNER JOIN Core.Country AS b ON a.Country = b.SourceReferenceKey
                    LEFT OUTER JOIN Item.CountryDetail AS c ON c.MonitorDate = a.MonitorDate  AND a.CountryCode = c.CountryCode  --needed to load UNIQUE items per country
					WHERE c.MonitorDate IS NULL and c.CountryCode is NULL;
        SET @itemCount = @@ROWCOUNT;
        SELECT @maxID = 0, 
               @maxLinkID = 0;
        SELECT @maxID = MAX(CountryDetailID)
        FROM Item.CountryDetail;

        --table is empty
        IF @maxID IS NULL
            SELECT @maxID = 0, 
                   @nextID = 1;
            ELSE
            SET @nextID = @maxID + 1;
        SELECT @maxLinkID = MAX(CountryDetailLinkID)
        FROM Link.CountryDetailToCountryCore;

        --table is empty
        IF @maxLinkID IS NULL
            SELECT @maxLinkID = 0, 
                   @nextLinkID = 1;
            ELSE  --table not empty calculate next ID
            SET @nextLinkID = @maxLinkID + 1;
        SELECT @counter = 1;

        --assign ID
        WHILE(@counter <= @itemCount)
            BEGIN
                UPDATE #add
                  SET 
                      [NewCountryDetailID] = @nextID, 
                      [NewLinkID] = @nextLinkID
                WHERE ID = @counter;
                SELECT @counter = @counter + 1, 
                       @nextID = @nextID + 1, 
                       @nextLinkID = @nextLinkID + 1;
            END;

        --insert #add to Item 
        INSERT INTO Item.CountryDetail
               SELECT a.[NewCountryDetailID], 
                      a.CountryID, 
                      a.[MonitorDate], 
                      a.[CaseCount], 
                      a.[DeathCount], 
                      a.[PeriodToDateCaseCount], 
                      a.[PeriodToDateDeathCount], 
                      a.[Population], 
                      a.[CaseCountPerPopulationPercent], 
                      a.[DeathCountPerPopulationPercent], 
                      a.[IncomePerCapita2018], 
                      a.[PopulationDensityPerKilometer], 
                      a.[CaseThirtyDayMovingAverage], 
                      a.[DeathThirtyDayMovingAverage], 
                      a.[CountryCode], 
                      a.EffectiveStartDate, 
                      a.EffectiveEndDate, 
                      a.[HashValue], 
                      a.[Source]
               FROM #add AS a;

        INSERT INTO Link.CountryDetailToCountryCore
               SELECT [NewLinkID], 
                      [NewCountryDetailID], 
                       
                      [Source], 
                      EffectiveStartDate, 
                      EffectiveEndDate
               FROM #add;

        --load REFERENCE Table where country code is missing
        INSERT INTO Reference.WorldRegionCountryCode
               SELECT a.CountryCode, 
                      ISNULL(a.WorldRegion, 'Unknown'), 
                      ISNULL(a.WorldSubRegion, 'Unknown'), 
                      'Covid19DataVault', 
                      GETDATE(), 
                      '9999/01/01'
               FROM #add AS a
                    LEFT OUTER JOIN Reference.WorldRegionCountryCode AS b ON b.CountryCode = a.CountryCode
               WHERE b.CountryCode IS NULL AND LEN(a.CountryCode) = 3
               GROUP BY a.CountryCode, 
                        a.WorldRegion, 
                        a.WorldSubRegion;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        PRINT 'error'; -- log error to error log
        ROLLBACK TRANSACTION;
        SET @itemCount = -1;
    END CATCH;
        RETURN(@itemCount);
GO
/****** Object:  StoredProcedure [Message].[upItemCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Message].[upItemCounTYDetail] @message NVARCHAR(MAX)
AS

    --for testing
/*DECLARE @message NVARCHAR(MAX), @x INT;
SELECT @message = BulkColumn
FROM Stage.JsonDocument;
SELECT @message;
*/

    --EXEC Message.upItemCounTYDetail @m
    --removed CounTYID from Link.CounTYDetailToCountyCore 2020-04-30

    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT, @maxLinkID INT, @nextLinkID INT;
        IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
            DROP TABLE #inBound;
        IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
            DROP TABLE #add;
        IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
            DROP TABLE #error;

        --create table #JSONMessage (BulkColumn nvarchar(max))
        CREATE TABLE #error
        ([ID]                 [INT] NOT NULL, 
         [ErrorMessage]       NVARCHAR(MAX) NULL, 
         [EffectiveStartDate] [DATETIME2](7) NULL
        );
        CREATE TABLE #inBound
        (ID                               [INT] NOT NULL, 
         [MonitorDate]                    [DATETIME2] NOT NULL, 
         [USCensusCounty]                 [NVARCHAR](64), 
         [State]                          [NVARCHAR](48), 
         [FIPS]                           [NVARCHAR](8) NULL, 
         [PeriodToDateCaseCount]                      INT NULL, 
         [PeriodToDateDeathCount]                     INT NULL, 
         [PreviousPeriodToDate]           [DATETIME2] NULL, 
         [PreviousPeriodToDateCaseCount]  [INT] NULL, 
         [PreviousPeriodToDateDeathCount] [INT] NULL, 
         [PopulationYear]                 [SMALLINT] NULL, 
         [Population]                     [BIGINT] NULL, 
         [BirthPerPopulation]             [INT] NULL, 
         [DeathsPerPopulation]            [BIGINT] NULL, 
         [RegionName]                     [NVARCHAR](32), 
         [DivisionName]                   [NVARCHAR](32), 
         EffectiveStartDate               DATETIME2 NOT NULL, 
         EffectiveEndDate                 DATETIME2 NOT NULL, 
         [HashValue]                      [VARBINARY](32) NULL, 
         [Source]                         [NVARCHAR](108) NOT NULL
        );
        CREATE TABLE #add
        (ID                               [INT] NOT NULL, 
         CounTYID                         [INT] NULL, 
         [MonitorDate]                    DATETIME2 NOT NULL, 
         [USCensusCounty]                 [NVARCHAR](64), 
         [FIPS]                           [NVARCHAR](8) NULL, 
         [PeriodToDateCaseCount]                      INT NULL, 
         [PeriodToDateDeathCount]                     INT NULL, 
         [PreviousPeriodToDate]           [DATETIME2] NULL, 
         [PreviousPeriodToDateCaseCount]  [INT] NULL, 
         [PreviousPeriodToDateDeathCount] [INT] NULL, 
         [PopulationYear]                 [SMALLINT] NULL, 
         [Population]                     [BIGINT] NULL, 
         [BirthPerPopulation]             [INT] NULL, 
         [DeathsPerPopulation]            [BIGINT] NULL, 
         [RegionName]                     [NVARCHAR](32), 
         [DivisionName]                   [NVARCHAR](32), 
         [State]                          [NVARCHAR](48), 
         ProvinceStateID                  [INT] NULL, 
         CountryRegionID                  [INT] NULL, 
         CountrySubRegionID               [INT] NULL, 
         EffectiveStartDate               DATETIME2 NOT NULL, 
         EffectiveEndDate                 DATETIME2 NOT NULL, 
         [HashValue]                      VARBINARY(32) NOT NULL, 
         [Source]                         [NVARCHAR](108) NOT NULL, 
         [NewCounTYDetailID]              INT, 
         [NewLinkID]                      INT
        );

        --insert json	
        INSERT INTO #inBound
        (ID, 
         [MonitorDate], --[Date]
         [USCensusCounty], --[county]             
         [State], 
         [FIPS], --[fips]    
         [PeriodToDateCaseCount], --[cases]              
         [PeriodToDateDeathCount], --[deaths]             
         [PreviousPeriodToDate], 
         [PreviousPeriodToDateCaseCount], 
         [PreviousPeriodToDateDeathCount], 
         [PopulationYear], 
         [Population], --[POPESTIMATE2019]    
         [BirthPerPopulation], --[BIRTHS2019] 
         [DeathsPerPopulation], 
         [RegionName], 
         [DivisionName], 
         EffectiveStartDate, 
         EffectiveEndDate, --'9999/01/01'
         [HashValue], --[Hash]
         [Source]
        )
               SELECT ROW_NUMBER() OVER(
                      ORDER BY [date]), 
                      [date], 
                      [USCensusCounty], 
                      [state], 
                      [fips], 
                      [cases], 
                      [deaths], 
                      [PreviousPeriodToDate], 
                      PreviousPeriodToDateCaseCount, 
                      [PreviousPeriodToDateDeathCount], 
                      [PopulationYear], 
                      [POPESTIMATE2019], 
                      [BIRTHS2019], 
                      [DEATHS2019], 
                      [RegionName], 
                      [DivisionName], 
                      GETDATE(), 
                      '9999/01/01', 
                      [Hash], 
                      [Source]
               FROM OPENJSON(@message) WITH([date] DATETIME2 '$.date', [USCensusCounty] NVARCHAR(64) '$.USCensusCounty', 
			   [state] NVARCHAR(64) '$.state', [fips] NVARCHAR(8) '$.fips', [cases] INT '$.cases', [deaths] INT '$.deaths',
[PreviousPeriodToDate] [DATETIME2] '$.PreviousPeriodToDate', PreviousPeriodToDateCaseCount [INT] 
			   '$.PreviousPeriodToDateCaseCount', [PreviousPeriodToDateDeathCount] [INT] '$.PreviousPeriodToDateDeathCount', 
			   			   [PopulationYear] SMALLINT '$.PopulationYear', [POPESTIMATE2019] INT '$.POPESTIMATE2019', [BIRTHS2019] INT '$.BIRTHS2019', 
			   [DEATHS2019] BIGINT '$.DEATHS2019', 
			   [RegionName] NVARCHAR(32) '$.RegionName', [DivisionName] NVARCHAR(32) '$.DivisionName', [Hash] VARBINARY(32) '$.Hash', [Source] NVARCHAR(108) '$.Source');
        INSERT INTO #add
               SELECT ROW_NUMBER() OVER(
                      ORDER BY a.MonitorDate), 
                      b.CounTYID, 
                      a.[MonitorDate], 
                      a.USCensusCounty, 
                      a.[FIPS], --[fips]    
                      a.[PeriodToDateCaseCount], --[cases]              
                      a.[PeriodToDateDeathCount], --[deaths]             
					  a.[PreviousPeriodToDate], 
                      a.PreviousPeriodToDateCaseCount, 
                      a.[PreviousPeriodToDateDeathCount], 
                      a.[PopulationYear], 
                      a.[Population], --[POPESTIMATE2019]    
                      a.[BirthPerPopulation], --[BIRTHS2019] 
                      a.[DeathsPerPopulation], 
                      a.[RegionName], 
                      a.[DivisionName], 
                      a.[state], 
                      c.ProvinceStateID, 
                      d.CountryRegionID, 
                      e.CountrySubRegionID, 
                      a.EffectiveStartDate, 
                      a.EffectiveEndDate, 
                      a.[HashValue], --[Hash]
                      a.[Source], 
                      0, 
                      0
               FROM #inBound AS a
                    INNER JOIN Core.CounTY AS b ON a.USCensusCounty = b.SourceReferenceKey
                    INNER JOIN Core.ProvinceState AS c ON a.State = c.SourceReferenceKey
                    INNER JOIN Core.CountryRegion AS d ON a.RegionName = d.SourceReferenceKey
                    INNER JOIN Core.CountrySubRegion AS e ON a.DivisionName = e.SourceReferenceKey
                    LEFT OUTER JOIN ITEM.CounTYDetail AS f ON a.MonitorDate = f.MonitorDate
                                                              AND a.FIPS = f.FIPS
               WHERE f.MonitorDate IS NULL
                     AND f.FIPS IS NULL;  --makes sure rows for monitordate and FIPS dont exist 

        SET @itemCount = @@ROWCOUNT;
        --assign ID 
        SELECT @maxID = 0, 
               @maxLinkID = 0;
        SELECT @maxID = MAX(CounTYDetailID)
        FROM Item.CounTYDetail;

        --table is empty
        IF @maxID IS NULL
            SELECT @maxID = 0, 
                   @nextID = 1;
            ELSE  --table not empty calculate next ID
            SET @nextID = @maxID + 1;
        SELECT @maxLinkID = MAX(CounTYDetailLinkID)
        FROM Link.CounTYDetailToCountyCore;

        --table is empty
        IF @maxLinkID IS NULL
            SELECT @maxLinkID = 0, 
                   @nextLinkID = 1;
            ELSE  --table not empty calculate next ID
            SET @nextLinkID = @maxLinkID + 1;
        SELECT @counter = 1;

        --assign ID
        WHILE(@counter <= @itemCount)
            BEGIN
                UPDATE #add
                  SET 
                      [NewCountyDetailID] = @nextID, 
                      [NewLinkID] = @nextLinkID
                WHERE ID = @counter;
                SELECT @counter = @counter + 1, 
                       @nextID = @nextID + 1, 
                       @nextLinkID = @nextLinkID + 1;
            END;

        --insert #add to Item 
        INSERT INTO Item.CounTYDetail
               SELECT a.[NewCountyDetailID], 
                      a.[CounTYID], 
                      a.[MonitorDate], 
                      a.[FIPS], --[fips]   
                      a.[PeriodToDateCaseCount], --[cases]              
                      a.[PeriodToDateDeathCount], --[deaths]             
                      a.[PreviousPeriodToDate], 
                      a.[PreviousPeriodToDateCaseCount], 
                      a.[PreviousPeriodToDateDeathCount], 
                      a.[PopulationYear], 
                      a.[Population], --[POPESTIMATE2019]    
                      a.[BirthPerPopulation], --[BIRTHS2019] 
                      a.[DeathsPerPopulation], 
                      a.EffectiveStartDate, 
                      a.EffectiveEndDate, 
                      a.[HashValue], --[Hash]
                      a.[Source]
               FROM #add AS a;
        --#add link here

        INSERT INTO Link.CounTYDetailToCounTYCore
               SELECT [NewLinkID], 
                      [NewCountyDetailID], 
                      CountryRegionID, 
                      CountrySubRegionID, 
                      ProvinceStateID, 
                      [Source], 
                      EffectiveStartDate, 
                      EffectiveEndDate, 
                      [HashValue]
               --RegionName, 
               --DivisionName, 
               FROM #add;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        PRINT 'error'; -- log error to error log
        ROLLBACK TRANSACTION;
        SET @itemCount = -1;
    END CATCH;
        RETURN(@itemCount);
--end of procecedure


select * from Item.CounTYDetail where MonitorDate = '2020-06-8'
GO
/****** Object:  StoredProcedure [Message].[upItemProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*DECLARE @jsonMessage NVARCHAR(MAX);
SELECT @jsonMessage = Bulkcolumn
FROM Stage.JsonDocument;
EXEC [Message].[upItemProvinceStateDetail] 
     @jsonMessage;
GO*/

CREATE PROCEDURE [Message].[upItemProvinceStateDetail] @message NVARCHAR(MAX)
AS
    --for testing
    --EXEC Message.upItemProvinceStateDetail @m

    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT, @maxLinkID INT, @nextLinkID INT;
        IF OBJECT_ID('tempdb.dbo.#inbound') IS NOT NULL
            DROP TABLE #inBound;
        IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
            DROP TABLE #add;
        IF OBJECT_ID('tempdb.dbo.#error') IS NOT NULL
            DROP TABLE #error;
        CREATE TABLE #error
        ([ID]                 [INT] NOT NULL, 
         [ErrorMessage]       NVARCHAR(MAX) NULL, 
         [EffectiveStartDate] [DATETIME2](7) NULL
        );
        CREATE TABLE #inBound
        (ID                                      [INT] NOT NULL, 
         [MonitorDate]                           [DATETIME2] NOT NULL, 
         [StateAbbreviation]                     [NVARCHAR](2) NOT NULL, 
         [PositiveToDate]                        [INT] NOT NULL, 
         [NegativeToDate]                        [INT] NOT NULL, 
         [DeathCountToDate]                      [INT] NOT NULL, 
         [InHospitalToDate]                      [INT] NOT NULL, 
         [PreviousPeriodToDatePositiveCount]     INT NULL, 
         [PreviousPeriodToDateNegativeCount]     INT NULL, 
         [PreviousPeriodToDateDeathCount]        INT NULL, 
         [PreviousPeriodToDateHospitalizedCount] INT NULL, 
         [PreviousPeriodToDate]                  DATETIME2 NULL, 
         [PopulationYear]                        SMALLINT NOT NULL, 
         [Population]                            BIGINT NOT NULL, 
         [PopulationDensity]                     INT NOT NULL, 
         [LandArea]                              DECIMAL(10, 2) NOT NULL, 
         [StateName]                             NVARCHAR(48) NULL, 
         CountryRegion                           [NVARCHAR](64) NULL, 
         CountrySubRegion                        [NVARCHAR](64) NULL, 
         EffectiveStartDate                      DATETIME2 NOT NULL, 
         EffectiveEndDate                        DATETIME2 NOT NULL, 
         [VendorHash]                            [NVARCHAR](40) NULL, 
         [HashValue]                             VARBINARY(32) NULL, 
         [Source]                                [NVARCHAR](108) NOT NULL
        );
        CREATE TABLE #add
        (ID                                      [INT] NOT NULL, 
         ProvinceStateID                         [INT] NULL, 
         [MonitorDate]                           DATETIME2 NOT NULL, 
         [StateAbbreviation]                     [NVARCHAR](2) NOT NULL, 
         [PositiveToDate]                        [INT] NOT NULL, 
         [NegativeToDate]                        [INT] NOT NULL, 
         [DeathCountToDate]                      [INT] NOT NULL, 
         [InHospitalToDate]                      [INT] NOT NULL, 
         [PreviousPeriodToDatePositiveCount]     INT NULL, 
         [PreviousPeriodToDateNegativeCount]     INT NULL, 
         [PreviousPeriodToDateDeathCount]        INT NULL, 
         [PreviousPeriodToDateHospitalizedCount] INT NULL, 
         [PreviousPeriodToDate]                  DATETIME2 NULL, 
         [PopulationYear]                        SMALLINT NOT NULL, 
         [Population]                            BIGINT NOT NULL, 
         [PopulationDensity]                     INT NOT NULL, 
         [LandArea]                              DECIMAL(10, 2) NOT NULL, 
         [StateName]                             NVARCHAR(48) NULL, 
         [VendorHash]                            NVARCHAR(40) NOT NULL, 
         CountryRegion                           [NVARCHAR](64) NULL, 
         CountrySubRegion                        [NVARCHAR](64) NULL, 
         CountryRegionID                         [INT] NULL, 
         CountrySubRegionID                      [INT] NULL, 
         EffectiveStartDate                      DATETIME2 NOT NULL, 
         EffectiveEndDate                        DATETIME2 NOT NULL, 
         [HashValue]                             VARBINARY(32) NOT NULL, 
         [Source]                                [NVARCHAR](108) NOT NULL, 
         [NewProvinceStateDetailID]              INT, 
         [NewLinkID]                             INT
        );

        --insert json	
        INSERT INTO #inBound
        (ID, 
         [MonitorDate], --[Date]
         [StateAbbreviation], 
         [PositiveToDate], 
         [NegativeToDate], 
         [DeathCountToDate], 
         [InHospitalToDate], 
         [PreviousPeriodToDatePositiveCount], 
         [PreviousPeriodToDateNegativeCount], 
         [PreviousPeriodToDateDeathCount], 
         [PreviousPeriodToDateHospitalizedCount], 
         [PreviousPeriodToDate], 
         [PopulationYear], 
         [Population], 
         [PopulationDensity], 
         [LandArea], 
         [StateName], 
         [VendorHash], --[Hash]
         CountryRegion, 
         CountrySubRegion, 
         EffectiveStartDate, 
         EffectiveEndDate, --'9999/01/01'
         [HashValue], 
         [Source]
        )
               SELECT ROW_NUMBER() OVER(
                      ORDER BY [date]), 
                      [Date], 
                      [State], 
                      [PositiveToDate], 
                      [NegativeToDate], 
                      [DeathCountToDate], 
                      [InHospitalToDate], 
                      [PreviousPeriodToDatePositiveCount], 
                      [PreviousPeriodToDateNegativeCount], 
                      [PreviousPeriodToDateDeathCount], 
                      [PreviousPeriodToDateHospitalizedCount], 
                      [PreviousPeriodToDate], 
                      [PopulationYear], 
                      [Population], 
                      [PopulationDensity], 
                      [LandArea], 
                      [StateName], 
                      [Hash], 
                      CountryRegion, 
                      CountrySubRegion, 
                      GETDATE(), 
                      '9999/01/01', 
                      [HashValue], 
                      [Source]
               FROM OPENJSON(@message) WITH([Date] DATETIME2 '$.Date', [State] NVARCHAR(2) '$.State', [PositiveToDate] INT '$.Positive', [NegativeToDate] INT '$.Negative', [DeathCountToDate] INT '$.Death', [InHospitalToDate] INT '$.Hospitalized', [PreviousPeriodToDatePositiveCount] INT '$.PreviousPeriodToDatePositiveCount', [PreviousPeriodToDateNegativeCount] INT '$.PreviousPeriodToDateNegativeCount', [PreviousPeriodToDateDeathCount] INT '$.PreviousPeriodToDateDeathCount', [PreviousPeriodToDateHospitalizedCount] INT '$.PreviousPeriodToDateHospitalizedCount', [PreviousPeriodToDate] DATETIME2 '$.PreviousPeriodToDate', [PopulationYear] SMALLINT '$.PopulationYear', [Population] BIGINT '$.Population', [PopulationDensity] INT '$.PopulationDensity', [LandArea] DECIMAL(10, 2) '$.LandArea', [StateName] NVARCHAR(48) '$.StateName', [CountryRegion] NVARCHAR(64) '$.CountryRegion', [CountrySubRegion] NVARCHAR(64) '$.CountrySubRegion', [Hash] VARCHAR(40) '$.Hash', [HashValue] VARBINARY(32) '$.HashValue', [Source] NVARCHAR(108) '$.Source');
        INSERT INTO #add
               SELECT ROW_NUMBER() OVER(
                      ORDER BY a.MonitorDate), 
                      b.[ProvinceStateID], 
                      a.[MonitorDate], 
                      a.[StateAbbreviation], 
                      a.[PositiveToDate], 
                      a.[NegativeToDate], 
                      a.[DeathCountToDate], 
                      a.[InHospitalToDate], 
                      a.[PreviousPeriodToDatePositiveCount], 
                      a.[PreviousPeriodToDateNegativeCount], 
                      a.[PreviousPeriodToDateDeathCount], 
                      a.[PreviousPeriodToDateHospitalizedCount], 
                      a.[PreviousPeriodToDate], 
                      a.[PopulationYear], 
                      a.[Population], 
                      a.[PopulationDensity], 
                      a.[LandArea], 
                      a.[StateName], 
                      a.[VendorHash], 
                      a.CountryRegion, 
                      a.CountrySubRegion, 
                      c.CountryRegionID, 
                      d.CountrySubRegionID, 
                      a.EffectiveStartDate, 
                      a.EffectiveEndDate, 
                      a.HashValue, 
                      a.[Source], 
                      0, 
                      0
               FROM #inBound AS a
                    INNER JOIN Core.ProvinceState AS b ON a.StateName = b.SourceReferenceKey
                    INNER JOIN Core.CountryRegion AS c ON a.CountryRegion = c.SourceReferenceKey
                    INNER JOIN Core.CountrySubRegion AS d ON a.CountrySubRegion = d.SourceReferenceKey
                    LEFT OUTER JOIN ITEM.ProvinceStateDetail AS e ON a.MonitorDate = e.MonitorDate
                                                                     AND e.StateAbbreviation = a.StateAbbreviation
               WHERE e.MonitorDate IS NULL
                     AND e.StateAbbreviation IS NULL;  --makes sure rows for monitordate and dont exist 
        SET @itemCount = @@ROWCOUNT;
        --assign ID 
        SELECT @maxID = 0, 
               @maxLinkID = 0;
        SELECT @maxID = MAX(ProvinceStateDetailID)
        FROM Item.ProvinceStateDetail;

        --table is empty
        IF @maxID IS NULL
            SELECT @maxID = 0, 
                   @nextID = 1;
            ELSE  --table not empty calculate next ID
            SET @nextID = @maxID + 1;
        SELECT @maxLinkID = MAX(ProvinceStateDetailLinkID)
        FROM Link.ProvinceStateDetailToProvinceStateCore;

        --table is empty
        IF @maxLinkID IS NULL
            SELECT @maxLinkID = 0, 
                   @nextLinkID = 1;
            ELSE  --table not empty calculate next ID
            SET @nextLinkID = @maxLinkID + 1;
        SELECT @counter = 1;

        --assign ID
        WHILE(@counter <= @itemCount)
            BEGIN
                UPDATE #add
                  SET 
                      [NewProvinceStateDetailID] = @nextID, 
                      [NewLinkID] = @nextLinkID
                WHERE ID = @counter;
                SELECT @counter = @counter + 1, 
                       @nextID = @nextID + 1, 
                       @nextLinkID = @nextLinkID + 1;
            END;

        --insert #add to Item 
        INSERT INTO Item.ProvinceStateDetail
               SELECT a.[NewProvinceStateDetailID], 
                      a.[ProvinceStateID], 
                      a.[MonitorDate], 
                      a.[StateAbbreviation], 
                      a.[PositiveToDate], 
                      a.[NegativeToDate], 
                      a.[DeathCountToDate], 
                      a.[InHospitalToDate], 
                      a.[PreviousPeriodToDatePositiveCount], 
                      a.[PreviousPeriodToDateNegativeCount], 
                      a.[PreviousPeriodToDateDeathCount], 
                      a.[PreviousPeriodToDateHospitalizedCount], 
                      a.[PreviousPeriodToDate], 
                      a.[PopulationYear], 
                      a.[Population], --[POPESTIMATE2019]    
                      a.[PopulationDensity], --[BIRTHS2019] 
                      a.[LandArea], 
                      a.[VendorHash], 
                      a.[HashValue], --[Hash]
                      a.EffectiveStartDate, 
                      a.EffectiveEndDate, 
                      a.[Source]
               FROM #add AS a;
        INSERT INTO Link.ProvinceStateDetailToProvinceStateCore
               SELECT [NewLinkID], 
                      [NewProvinceStateDetailID], 
                      CountryRegionID, 
                      CountrySubRegionID, 
                      [Source], 
                      EffectiveStartDate, 
                      EffectiveEndDate, 
                      [HashValue]
               FROM #add;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        PRINT 'error'; -- log error to error log
        ROLLBACK TRANSACTION;
        SET @itemCount = -1;
    END CATCH;
        RETURN(@itemCount);
GO
/****** Object:  StoredProcedure [Message].[upReceivedItemCountryDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [Message].[upReceivedItemCountryDetail] (@hashValue Varbinary(32), @hashCount smallInt)
as
IF @hashCount = 0  -- message didnt get to destination
BEGIN
INSERT INTO Message.ReceivedItemCountryDetail
select getdate(), @hashValue, @hashCount
END
RETURN
GO
/****** Object:  StoredProcedure [Message].[upReceivedItemCounTYDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   procedure [Message].[upReceivedItemCounTYDetail] (@hashValue Varbinary(32), @hashCount smallint)
as
IF @hashCount = 0  -- message didnt get to destination
BEGIN
INSERT INTO Message.ReceivedItemCounTYDetail
select getdate(), @hashValue, @hashCount
END
RETURN
GO
/****** Object:  StoredProcedure [Message].[upReceivedItemProvinceStateDetail]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [Message].[upReceivedItemProvinceStateDetail] (@hashValue Varbinary(32), @hashCount smallInt)
as
IF @hashCount = 0  -- message didnt get to destination
BEGIN
INSERT INTO Message.ReceivedItemProvinceStateDetail
select getdate(), @hashValue, @hashCount
END
RETURN
GO
/****** Object:  StoredProcedure [Stage].[upCovidTrackingDailyState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upCovidTrackingDailyState]
AS
     SELECT *
     INTO #1
     FROM OPENROWSET(BULK 'T:\Documents\kDSResearch2020\CovidTrackingDailyState.json', SINGLE_CLOB) AS j;
     DECLARE @json NVARCHAR(MAX);
     SELECT @json = BULKCOLUMN
     FROM #1;
     TRUNCATE TABLE Stage.CovidTrackingDailyState;

     --parse JSON column  insert goes here
     INSERT INTO Stage.CovidTrackingDailyState
     ([Date], 
      State, 
      Positive, 
      Negative, 
      Death, 
      Hospitalized, 
      Hash
     )
            SELECT *
            FROM OPENJSON(@json) WITH(Date DATETIME2 '$.date', State VARCHAR(4) '$.state', Positive INT '$.positive', Negative INT '$.negative', Death INT '$.death', hospitalized INT '$.hospitalizedCumulative', Hash NVARCHAR(40) '$.hash');
     --assign state code
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = b.State
     FROM Stage.State AS b
          INNER JOIN Stage.CovidTrackingDailyState AS a ON a.State = b.Abbreviation;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = 'American Samoa', 
           Stage.CovidTrackingDailyState.CountryRegion = 'US Territory', 
           Stage.CovidTrackingDailyState.CountrySubRegion = 'US Territory'
     WHERE State = 'AS';
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = 'Guam', 
           Stage.CovidTrackingDailyState.CountryRegion = 'US Territory', 
           Stage.CovidTrackingDailyState.CountrySubRegion = 'US Territory'
     WHERE State = 'GU';
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = 'Puerto Rico', 
           Stage.CovidTrackingDailyState.CountryRegion = 'US Territory', 
           Stage.CovidTrackingDailyState.CountrySubRegion = 'US Territory'
     WHERE State = 'PR';
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = 'Northern Mariana Islands', 
           Stage.CovidTrackingDailyState.CountryRegion = 'US Territory', 
           Stage.CovidTrackingDailyState.CountrySubRegion = 'US Territory'
     WHERE State = 'MP';
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = 'Virgin Islands(U.S.)', 
           Stage.CovidTrackingDailyState.CountryRegion = 'US Territory', 
           Stage.CovidTrackingDailyState.CountrySubRegion = 'US Territory'
     WHERE State = 'VI';
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.StateName = 'District of Columbia', 
           Stage.CovidTrackingDailyState.CountryRegion = 'South', 
           Stage.CovidTrackingDailyState.CountrySubRegion = 'South Atlantic'
     WHERE State = 'DC';
     UPDATE Stage.CovidTrackingDailyState
       SET 
           PopulationDensity = b.Density, 
           [Population] = b.Pop, 
           PopulationYear = b.[Year], 
           Stage.CovidTrackingDailyState.LandArea = b.LandArea
     FROM Stage.StatePopulationDensity AS b
          INNER JOIN Stage.CovidTrackingDailyState AS a ON a.StateName = b.State;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           PopulationDensity = b.Density, 
           [Population] = b.Pop, 
           PopulationYear = b.[Year], 
           Stage.CovidTrackingDailyState.LandArea = b.LandArea
     FROM Stage.StatePopulationDensity AS b
          INNER JOIN Stage.CovidTrackingDailyState AS a ON a.StateName = b.State;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           CountryRegion = RegionName, 
           CountrySubRegion = DivisionName
     FROM [Covid19DataVault].[Stage].[USCensusCountyPopulation] AS b
          LEFT OUTER JOIN Stage.CovidTrackingDailyState AS a ON a.StateName = b.STNAME;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           CountryRegion = 'Unknown'
     WHERE CountryRegion IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           CountrySubRegion = 'Unknown'
     WHERE CountrySubRegion IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Positive = 0
     WHERE Positive IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Negative = 0
     WHERE Negative IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Death = 0
     WHERE Death IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Hospitalized = 0
     WHERE Hospitalized IS NULL;

     --no population data for territores
     UPDATE Stage.CovidTrackingDailyState
       SET 
           PopulationYear = 0, 
           Population = 0, 
           PopulationDensity = 0, 
           LandArea = 0
     WHERE PopulationYear IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Source = 'https://covidtracking.com/api/states/daily'
     WHERE Source IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           LoadTime = GETDATE()
     WHERE LoadTime IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           HashValue = HASHBYTES('SHA2_256', (CAST(Date AS NVARCHAR(27)) + State))
     WHERE HashValue IS NULL;
     UPDATE Stage.CovidTrackingDailyState
       SET 
           Stage.CovidTrackingDailyState.PreviousPeriodToDatePositiveCount = b.Positive, 
           Stage.CovidTrackingDailyState.PreviousPeriodToDateNegativeCount = b.Negative, 
           Stage.CovidTrackingDailyState.PreviousPeriodToDateDeathCount = b.Death, 
           Stage.CovidTrackingDailyState.PreviousPeriodToDateHospitalizedCount = b.Hospitalized, 
           Stage.CovidTrackingDailyState.PreviousPeriodToDate = DATEADD(day, -1, a.date)
     FROM Stage.CovidTrackingDailyState AS a
          INNER JOIN History.CovidTrackingDailyState AS b ON DATEADD(day, -1, a.date) = b.date
                                                             AND a.State = b.State;

     --insert current days worth of data into history no duplicates...

     INSERT INTO History.CovidTrackingDailyState
            SELECT a.[Date], 
                   a.[State], 
                   a.[Positive], 
                   a.[Negative], 
                   a.[Death], 
                   a.[Hospitalized], 
                   a.[PopulationYear], 
                   a.[Population], 
                   a.[PopulationDensity], 
                   a.[LandArea], 
                   a.[StateName], 
                   a.[CountryRegion], 
                   a.[CountrySubRegion], 
                   a.[Hash], 
                   a.[HashValue], 
                   a.[LoadTime], 
                   a.[Source]
            FROM [Stage].[CovidTrackingDailyState] AS a
                 LEFT OUTER JOIN [History].[CovidTrackingDailyState] AS b ON a.date = b.date
                                                                             AND a.State = b.State
            WHERE b.date IS NULL
                  AND b.State IS NULL;
     PRINT 'OK';
     RETURN(0);
GO
/****** Object:  StoredProcedure [Stage].[upCovidTrackingDailyStateJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upCovidTrackingDailyStateJSON] @monitorDate DATETIME2, 
                                                         @jsonMessage NVARCHAR(MAX) OUTPUT
AS
     DECLARE @j VARCHAR(MAX);
     TRUNCATE TABLE Stage.JsonDocument;
     SET @j =
     (
         SELECT [Date], 
                [State], 
                [Positive], 
                [Negative], 
                [Death], 
                [Hospitalized], 
                PreviousPeriodToDatePositiveCount, 
                PreviousPeriodToDateNegativeCount, 
                PreviousPeriodToDateDeathCount, 
                PreviousPeriodToDateHospitalizedCount, 
                PreviousPeriodToDate, 
                [PopulationYear], 
                [Population], 
                [PopulationDensity], 
                [LandArea], 
                [StateName], 
                [CountryRegion], 
                [CountrySubRegion], 
                [Hash], 
                [HashValue], 
                [LoadTime], 
                [Source]
         FROM [Stage].[CovidTrackingDailyState]
         WHERE date = @monitorDate FOR JSON AUTO
     );
     INSERT INTO Stage.JsonDocument
     VALUES(@j);
     SELECT @jsonMessage = BULKCOLUMN
     FROM Stage.JsonDocument;
GO
/****** Object:  StoredProcedure [Stage].[upDailyChangeByCountry]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upDailyChangeByCountry] (@monitorDate datetime2, @jsonMessage nvarchar(max) OUTPUT)
AS
     TRUNCATE TABLE Stage.DailyChangeByCountry;
     INSERT INTO Stage.DailyChangeByCountry
           SELECT a.[date], 
                   a.[location], 
                   b.Country, 
                   a.[new_cases], 
                   a.[new_deaths], 
                   a.[total_cases], 
                   a.[total_deaths], 
                   ISNULL(b.Population,0), 
                   ISNULL((CAST(a.total_cases AS INT) / CAST(b.Population AS DECIMAL(12, 2))) * 100,0) AS CaseCountPerPopulationPercent, 
                   ISNULL((CAST(a.total_deaths AS INT) / CAST(b.Population AS DECIMAL(12, 2))) * 100,0) AS DeathCountPerPopulationPercent, 
                   ISNULL(CAST(c.Amount AS DECIMAL(12, 2)),0) AS IncomePerCapita2018, 
                   ISNULL(CAST(d.PopulationDensity AS DECIMAL(12, 2)),0) AS PopulationDensityPerKilometer, 
                   [PopulationDensityPerKilometer] = 0, 
                   [CaseThirtyDayMovingAverage] = 0, 
                   ISNULL(d.CountryCode, 'Unknown'),
				   ISNULL(e.WorldRegion,'Unknown'),
				   ISNULL(e.WorldSubRegion,'Unknown'),
				   a.[Hash], 
                   GETDATE(), -- loadtime 
                   a.[Source]
            FROM [Stage].[OurWorldDataDailyCountry] AS a
                 INNER JOIN Stage.WorldPopulation AS b ON a.Location = b.Country
                 LEFT OUTER JOIN Stage.WorldBankPerCapitaIncome2018 AS c ON a.Location = c.Country
                 LEFT OUTER JOIN Stage.WorldPopulationDensity AS d ON a.Location = d.Country
				 LEFT OUTER JOIN Stage.WorldRegion as e on a.Location = e.Country
            WHERE a.[date] = @monitorDate;

     --DROP TABLE #ThirtyDayAverage; 
     --30 day average
     SELECT location, 
            AVG(new_cases) AS [CaseThirtyDayMovingAverage], 
            AVG(new_deaths) AS [DeathThirtyDayMovingAverage]
     INTO #ThirtyDayAverage
     FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry]
     WHERE [date] > DATEADD(day, -30, @monitorDate)
           AND [date] < @monitorDate
     GROUP BY location;
     UPDATE Stage.DailyChangeByCountry
       SET 
           Stage.DailyChangeByCountry.CaseThirtyDayMovingAverage = b.CaseThirtyDayMovingAverage, 
           Stage.DailyChangeByCountry.DeathThirtyDayMovingAverage = b.DeathThirtyDayMovingAverage
     FROM #ThirtyDayAverage AS b
          INNER JOIN Stage.DailyChangeByCountry ON b.[location] = Stage.DailyChangeByCountry.[location];
     DECLARE @j VARCHAR(MAX);
     TRUNCATE TABLE Stage.JsonDocument;
     SET @j =
     (
         SELECT [date], 
                [location], 
                [Country], 
                [new_cases], 
                [new_deaths], 
                [total_cases], 
                [total_deaths], 
                [Population], 
                [CaseCountPerPopulationPercent], 
                [DeathCountPerPopulationPercent], 
                [IncomePerCapita2018], 
                [PopulationDensityPerKilometer], 
                [CaseThirtyDayMovingAverage], 
                [DeathThirtyDayMovingAverage], 
                [CountryCode], 
				[WorldRegion],
				[WorldSubRegion],

                [Hash], 
                [LoadTime], 
                [Source]
         FROM [Stage].[DailyChangeByCountry] FOR JSON AUTO
     );
     INSERT INTO Stage.JsonDocument
     VALUES(@j);
	 SELECT @jsonMessage =  BulkColumn from Stage.JsonDocument

GO
/****** Object:  StoredProcedure [Stage].[upDailyChangeByCountryJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Stage].[upDailyChangeByCountryJSON] (@monitorDate datetime2, @location nvarchar(48), 
@hashValue varbinary(32) OUTPUT, @jsonMessage nvarchar(max) OUTPUT)
AS
     TRUNCATE TABLE Stage.DailyChangeByCountry;
     INSERT INTO Stage.DailyChangeByCountry
	  SELECT a.[date], 
                   a.[location], 
                   b.Country, 
                   a.[new_cases], 
                   a.[new_deaths], 
                   a.[total_cases], 
                   a.[total_deaths], 
                   ISNULL(b.Population,0), 
                   ISNULL((CAST(a.new_cases AS INT) / CAST(b.Population AS DECIMAL(12, 2))) * 100,0) AS CaseCountPerPopulationPercent, 
                   ISNULL((CAST(a.total_deaths AS INT) / CAST(b.Population AS DECIMAL(12, 2))) * 100,0) AS DeathCountPerPopulationPercent, 
                   ISNULL(CAST(c.Amount AS DECIMAL(12, 2)),0) AS IncomePerCapita2018, 
                   ISNULL(CAST(d.PopulationDensity AS DECIMAL(12, 2)),0) AS PopulationDensityPerKilometer, 
                   [PopulationDensityPerKilometer] = 0, 
                   [CaseThirtyDayMovingAverage] = 0, 
                   ISNULL(d.CountryCode, 'Unknown'),
				   ISNULL(e.WorldRegion,'Unknown'),
				   ISNULL(e.WorldSubRegion,'Unknown'),
				   a.[Hash], 
                   GETDATE(), -- loadtime 
                   a.[Source]
            FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry] AS a
                 INNER JOIN Stage.WorldPopulation AS b ON a.Location = b.Country
                 LEFT OUTER JOIN Stage.WorldBankPerCapitaIncome2018 AS c ON a.Location = c.Country
                 LEFT OUTER JOIN Stage.WorldPopulationDensity AS d ON a.Location = d.Country
				 LEFT OUTER JOIN Stage.WorldRegion as e on a.Location = e.Country
            WHERE a.[date] = @monitorDate
				  AND a.[location] = @location;

     --DROP TABLE #ThirtyDayAverage; 
     --30 day average
     SELECT location, 
            AVG(new_cases) AS [CaseThirtyDayMovingAverage], 
            AVG(new_deaths) AS [DeathThirtyDayMovingAverage]
     INTO #ThirtyDayAverage
     FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry]
     WHERE [date] > DATEADD(day, -30, @monitorDate)
           AND [date] < @monitorDate
     GROUP BY location;
     UPDATE Stage.DailyChangeByCountry
       SET 
           Stage.DailyChangeByCountry.CaseThirtyDayMovingAverage = b.CaseThirtyDayMovingAverage, 
           Stage.DailyChangeByCountry.DeathThirtyDayMovingAverage = b.DeathThirtyDayMovingAverage
     FROM #ThirtyDayAverage AS b
          INNER JOIN Stage.DailyChangeByCountry ON b.[location] = Stage.DailyChangeByCountry.[location];
     DECLARE @j VARCHAR(MAX);
     TRUNCATE TABLE Stage.JsonDocument;  --do this before running procedure
     SET @jsonMessage =
     (
         SELECT [date], 
                [location], 
                [Country], 
                [new_cases], 
                [new_deaths], 
                [total_cases], 
                [total_deaths], 
                [Population], 
                [CaseCountPerPopulationPercent], 
                [DeathCountPerPopulationPercent], 
                [IncomePerCapita2018], 
                [PopulationDensityPerKilometer], 
                [CaseThirtyDayMovingAverage], 
                [DeathThirtyDayMovingAverage], 
                [CountryCode], 
				[WorldRegion],
				[WorldSubRegion],
                [Hash], 
                [LoadTime], 
                [Source]
         FROM [Stage].[DailyChangeByCountry] FOR JSON AUTO );
		 
		 SELECT @hashValue = hash from [Stage].[DailyChangeByCountry] ;

GO
/****** Object:  StoredProcedure [Stage].[upDailyChangeByCounTY]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Stage].[upDailyChangeByCounTY]
(@monitorDate DATETIME2, 
 @jsonMessage NVARCHAR(MAX) OUTPUT
)
AS
     --for testing DECLARE @m NVARCHAR(MAX), @monitorDate DATETIME2, @movingAverageFactor INT, @jsonMessage NVARCHAR(MAX);
     DECLARE @j VARCHAR(MAX);
     TRUNCATE TABLE Stage.DailyChangeByCounTY;
     INSERT INTO Stage.DailyChangeByCounTY
            SELECT a.[date], 
                   a.[county], 
                   a.[USCensusCounty], 
                   a.[state], 
                   a.[fips], 
                   a.[cases], 
                   a.[deaths], 
                   NULL, 
                   0, 
                   0, 
                   b.[RegionName], 
                   b.[DivisionName], 
                   b.PopulationYear, 
                   b.POPESTIMATE2019, 
                   b.BIRTHS2019, 
                   b.DEATHS2019, 
                   GETDATE(), 
                   b.[Hash], 
                   'NYTIMES-USCENSUS'
            FROM [Stage].[NYTimesCovid19USCounty] AS a
                 INNER JOIN [Stage].[USCensusCountyPopulation] AS b ON a.[USCensusCounty] = b.[CTYNAME]
                                                                       AND a.state = b.STNAME
            WHERE a.[date] = @monitorDate;
    
	UPDATE Stage.DailyChangeByCounTY
       SET 
           PreviousPeriodToDateCaseCount = b.cases, 
           PreviousPeriodToDateDeathCount = b.deaths, 
           PreviousPeriodToDate = ISNULL(DATEADD(day, -1, a.date), a.date) -- to accomodate first occurance
     FROM Stage.DailyChangeByCounTY AS a
          INNER JOIN History.NYTimesCovid19USCounTY AS b ON DATEADD(day, -1, a.date) = b.date
                                                            AND a.fips = b.fips; 
															
       /* JSON version 2020-06-12
	   SELECT @maxDate = MAX(date)
         FROM [Stage].[NYTimesCovid19USCounty];
	 
	 TRUNCATE TABLE History.PreviousDayCounTY;

	 INSERT INTO History.PreviousDayCounTY
	 select date, county, state, fips, cases, deaths from History.NYTimesCovid19USCounTY 
	 where date = DATEADD(day, -1, @maxDate)
	 */
	 	 


     --calcuate average
     --remove  calculate daily change instead
     TRUNCATE TABLE Stage.JsonDocument;
     SET @j =
     (
         SELECT [date], 
                [county], 
                [USCensusCounty], 
                [state], 
                [fips], 
                [cases], 
                [deaths], 
                [PreviousPeriodToDate], 
                PreviousPeriodToDateCaseCount, 
                [PreviousPeriodToDateDeathCount], 
                [POPESTIMATE2019], 
                [PopulationYear], 
                [RegionName], 
                [DivisionName], 
                [BIRTHS2019], 
                [POPESTIMATE2019], 
                [DEATHS2019], 
                [Hash], 
                [LoadTime], 
                [Source]
         FROM [Stage].[DailyChangeByCounTY] FOR JSON AUTO
     );
     INSERT INTO Stage.JsonDocument
     VALUES(@j);
     SELECT @jsonMessage = BulkColumn
     FROM Stage.JsonDocument;
GO
/****** Object:  StoredProcedure [Stage].[upDailyChangeByCounTYJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upDailyChangeByCounTYJSON]
(@monitorDate  DATETIME2, 
 @censusCounty NVARCHAR(64), 
 @state        NVARCHAR(48), 
 @hashValue    VARBINARY(32) OUTPUT, 
 @jsonMessage  NVARCHAR(MAX) OUTPUT
)
AS

     --DECLARE @m NVARCHAR(MAX), @monitorDate DATETIME2
     --@jsonMessage NVARCHAR(MAX), @censusCounty NVARCHAR(64), @state NVARCHAR(48)
     --DECLARE @m NVARCHAR(MAX), @hash varbinary(32);

/*SELECT @monitorDate = '2020-06-09', 
       @censusCounty = 'Frederick County', 
       @state = 'Maryland',
	   @fips = '01057';

	select * from History.NYTimesCovid19USCounTY where date = '2020-06-08' and UScensuscounty = 'Frederick County'
*/

     DECLARE @memoryTableForJSON TABLE
     ([date]                           [DATETIME2] NOT NULL, 
      [county]                         [NVARCHAR](64), 
      [USCensusCounty]                 [NVARCHAR](64), 
      [state]                          [NVARCHAR](48), 
      [fips]                           [NVARCHAR](8) NULL, 
      [cases]                          INT NULL, 
      [deaths]                         INT NULL, 
      [RegionName]                     [NVARCHAR](32), 
      [DivisionName]                   [NVARCHAR](32), 
      [PopulationYear]                 [SMALLINT] NULL, 
      [POPESTIMATE2019]                [BIGINT] NULL, 
      [BIRTHS2019]                     [INT] NULL, 
      [DEATHS2019]                     [BIGINT] NULL, 
      [PreviousPeriodToDateCaseCount]  INT NULL, 
      [PreviousPeriodToDateDeathCount] INT NULL, 
      [PreviousPeriodToDate]           DATETIME2 NULL, 
      LoadTime                         DATETIME2, 
      [Hash]                           VARBINARY(32), 
      Source                           NVARCHAR(92)
     );
     INSERT INTO @memoryTableForJSON
            SELECT a.[date], 
                   a.[county], 
                   a.[USCensusCounty], 
                   a.[state], 
                   a.[fips], 
                   a.[cases], 
                   a.[deaths], 
                   b.[RegionName], 
                   b.[DivisionName], 
                   b.PopulationYear, 
                   b.POPESTIMATE2019, 
                   b.BIRTHS2019, 
                   b.DEATHS2019, 
                   0, 
                   0, 
                   NULL, 
                   a.[LoadTime], 
                   a.[Hash], 
                   a.[Source]
            FROM [Stage].[NYTimesCovid19USCounty] AS a
                 INNER JOIN [Stage].[USCensusCountyPopulation] AS b ON a.[USCensusCounty] = b.[CTYNAME]
                                                                       AND a.[state] = b.STNAME
            WHERE a.[date] = @monitorDate
                  AND a.[USCensusCounty] = @censusCounty
                  AND a.[State] = @state;

     UPDATE @memoryTableForJSON
       SET 
           a.PreviousPeriodToDateCaseCount = b.cases, 
           a.PreviousPeriodToDateDeathCount = b.deaths, 
           a.PreviousPeriodToDate = DATEADD(day, -1, a.date)
     FROM @memoryTableForJSON AS a
          INNER JOIN History.PreviousDayCounTY AS b ON DATEADD(day, -1, a.date) = b.date
                                               AND a.fips = b.fips;

     -- INNER JOIN History.NYTimesCovid19USCounTY AS b ON DATEADD(day, -1, a.date) = b.date
     --                  AND a.fips = b.fips;
     SELECT @jsonMessage =
     (
         SELECT *
         FROM @memoryTableForJSON FOR JSON AUTO
     );
     SELECT @hashValue = Hash
     FROM @memoryTableForJSON;
     RETURN;
GO
/****** Object:  StoredProcedure [Stage].[upDailyTotalByCountry]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Stage].[upDailyTotalByCountry]
as
TRUNCATE TABLE Stage.DailyTotalByCountry

INSERT INTO Stage.DailyTotalByCountry
([date], 
 [location], 
 new_cases, 
 total_cases, 
 new_deaths, 
 total_deaths
)
       SELECT [date], 
              [location], 
              new_cases, 
              total_cases, 
              new_deaths, 
              total_deaths
       FROM Stage.CSVCovidWorldDaily
       WHERE ISDATE([DATE]) = 1;
UPDATE Stage.DailyTotalByCountry
  SET 
      Source = 'https://covid.ourworldindata.org/data/ecdc/full_data.csv'
WHERE Source IS NULL;
UPDATE Stage.DailyTotalByCountry
  SET 
      LoadTime = GETDATE()
WHERE LoadTime IS NULL;
UPDATE Stage.DailyTotalByCountry
  SET 
      Hash = HASHBYTES('SHA2_256', CAST([date] AS NVARCHAR(27)) + CAST([location] AS NVARCHAR(64)) + CAST(new_cases AS NVARCHAR(8)) + CAST(total_cases AS NVARCHAR(8)) + CAST(new_deaths AS NVARCHAR(8)) + CAST(total_deaths AS NVARCHAR(8)))
FROM Stage.DailyTotalByCountry
WHERE Hash IS NULL;
GO
/****** Object:  StoredProcedure [Stage].[upNYTimesCovid19USCounty]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upNYTimesCovid19USCounty]
AS
    
        UPDATE Stage.NYTimesCovid19USCounty
               SET Source = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
        WHERE Source IS NULL;
        UPDATE Stage.NYTimesCovid19USCounty
               SET LoadTime = GETDATE()
        WHERE LoadTime IS NULL;
        UPDATE Stage.NYTimesCovid19USCounty
               SET Hash = HASHBYTES('SHA2_256' , CAST([date] AS NVARCHAR(27)) + CAST([county] AS NVARCHAR(64)) + CAST(state AS NVARCHAR(32)))
        WHERE Hash IS NULL;

        --NEED TO RUN the following to accomdate dropping of 'County' and 'Parish' from NYtimes county name
        IF OBJECT_ID('tempdb.dbo.#1') IS NOT NULL
            BEGIN
                DROP TABLE #1;
        END;
        SELECT CTYNAME , STNAME
        INTO #1
        FROM [Stage].[USCensusCountyPopulation];
        ALTER TABLE #1
        ADD NYTimesCounty NVARCHAR(64);
        UPDATE #1
               SET NYTimesCounty = SUBSTRING(CTYNAME , 1 , ( PATINDEX('%County' , CTYNAME) - 1 ) )
        WHERE CTYNAME LIKE '%County';
        UPDATE #1
               SET NYTimesCounty = SUBSTRING(CTYNAME , 1 , ( PATINDEX('%Parish' , CTYNAME) - 1 ) )
        WHERE CTYNAME LIKE '%Parish';
        UPDATE #1
               SET NYTimesCounty = CTYNAME
        WHERE NYTimesCounty IS NULL;
        UPDATE [Stage].[NYTimesCovid19USCounty]
               SET USCensusCounty = CTYNAME
        FROM #1 AS a INNER JOIN [Stage].[NYTimesCovid19USCounty] AS b ON a.NYTimesCounty = b.county
                                                                         AND 
                                                                         a.STNAME = b.[state];
        UPDATE [Stage].[USCensusCountyPopulation]
               SET PopulationYear = 2019;

		INSERT INTO History.NYTimesCovid19USCounty select * from Stage.NYTimesCovid19USCounty;

		--load history table here
        RETURN ( 0 );
        
    
GO
/****** Object:  StoredProcedure [Stage].[upNYTimesCovid19UsCountyJson]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [Stage].[upNYTimesCovid19UsCountyJson]
	 as
	 declare @j varchar(max)

	 truncate table Stage.JsonDocument
	
	set @j = (
	SELECT [date]
      ,[county]
      ,[state]
      ,[fips]
      ,[cases]
      ,[deaths]
      ,[Hash]
      ,[LoadTime]
      ,[Source]
  FROM [Stage].[NYTimesCovid19USCounty] WHERE 
  date = (select max(date) from Stage.NYTimesCovid19USCounty) 
  FOR JSON AUTO )
  
 INSERT INTO Stage.JsonDocument values (@j)

 select BulkColumn from Stage.JsonDocument

GO
/****** Object:  StoredProcedure [Stage].[upNYTimesCovid19USCountyLive]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [Stage].[upNYTimesCovid19USCountyLive]
AS
    
        UPDATE Stage.NYTimesCovid19USCountyLive
               SET Source = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us-counties.csv'
        WHERE Source IS NULL;
        UPDATE Stage.NYTimesCovid19USCountyLive
               SET LoadTime = GETDATE()
        WHERE LoadTime IS NULL;
        UPDATE Stage.NYTimesCovid19USCountyLive
               SET Hash = HASHBYTES('SHA2_256' , CAST([date] AS NVARCHAR(27)) + CAST([county] AS NVARCHAR(64)) + CAST(state AS NVARCHAR(32)))
        WHERE Hash IS NULL;

        --NEED TO RUN the following to accomdate dropping of 'County' and 'Parish' from NYtimes county name
        IF OBJECT_ID('tempdb.dbo.#1') IS NOT NULL
            BEGIN
                DROP TABLE #1;
        END;
        SELECT CTYNAME , STNAME
        INTO #1
        FROM [Stage].[USCensusCountyPopulation];
        ALTER TABLE #1
        ADD NYTimesCounty NVARCHAR(64);
        UPDATE #1
               SET NYTimesCounty = SUBSTRING(CTYNAME , 1 , ( PATINDEX('%County' , CTYNAME) - 1 ) )
        WHERE CTYNAME LIKE '%County';
        UPDATE #1
               SET NYTimesCounty = SUBSTRING(CTYNAME , 1 , ( PATINDEX('%Parish' , CTYNAME) - 1 ) )
        WHERE CTYNAME LIKE '%Parish';
        UPDATE #1
               SET NYTimesCounty = CTYNAME
        WHERE NYTimesCounty IS NULL;
        UPDATE [Stage].[NYTimesCovid19USCountyLive]
               SET USCensusCounty = CTYNAME
        FROM #1 AS a INNER JOIN [Stage].[NYTimesCovid19USCountyLive] AS b ON a.NYTimesCounty = b.county
                                                                         AND 
                                                                         a.STNAME = b.[state];
        UPDATE [Stage].[USCensusCountyPopulation]
               SET PopulationYear = 2019;

		INSERT INTO Hourly.NYTimesCovid19USCountyLive select * from Stage.NYTimesCovid19USCountyLive;

		--load history table here
        RETURN ( 0 );
        
    
GO
/****** Object:  StoredProcedure [Stage].[upNYTimesCovid19USState]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Stage].[upNYTimesCovid19USState] as
UPDATE Stage.NYTimesCovid19USState
       SET 
           Source = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv' 
     WHERE Source IS NULL;
     UPDATE Stage.NYTimesCovid19USState
       SET 
           LoadTime = GETDATE()
     WHERE LoadTime IS NULL;
     
	 UPDATE Stage.NYTimesCovid19USState
       SET 
           Hash = HASHBYTES('SHA2_256', CAST([date] AS NVARCHAR(27)) + CAST(state AS NVARCHAR(32)))
          WHERE Hash IS NULL;

	 RETURN(0)
	 Print'ok'

GO
/****** Object:  StoredProcedure [Stage].[upNYTimesCovid19USStateJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE procedure [Stage].[upNYTimesCovid19USStateJSON] as

 	 declare @j varchar(max)

	 truncate table Stage.JsonDocument
	
	set @j = (SELECT [date]
      ,[state]
      ,[fips]
      ,[cases]
      ,[deaths]
      ,[Hash]
      ,[LoadTime]
      ,[Source]
  FROM [Stage].[NYTimesCovid19USState] WHERE 
  date = (select max(date) from Stage.NYTimesCovid19USState) 
  FOR JSON AUTO )
  
 INSERT INTO Stage.JsonDocument values (@j)

 select BulkColumn from Stage.JsonDocument


GO
/****** Object:  StoredProcedure [Stage].[upOurWorldDailyCountryJson]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [Stage].[upOurWorldDailyCountryJson]
	 as
	 declare @j varchar(max)

	 truncate table Stage.JsonDocument
	
	set @j = (
	SELECT  [date]
      ,[location]
      ,[new_cases]
      ,[new_deaths]
      ,[total_cases]
      ,[total_deaths]
      ,[Hash]
      ,[LoadTime]
      ,[Source]
  FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry] where date = (select max(date) from [Covid19DataVault].[Stage].[OurWorldDataDailyCountry] ) 
  	--and location = 'Sweden' 
	FOR JSON AUTO )
  
 INSERT INTO Stage.JsonDocument values (@j)

  select BulkColumn from Stage.JsonDocument

GO
/****** Object:  StoredProcedure [Stage].[upOurWorldDataDailyCountry]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE PROCEDURE [Stage].[upOurWorldDataDailyCountry]
AS
     
     UPDATE Stage.OurWorldDataDailyCountry
       SET 
           Source = 'https://covid.ourworldindata.org/data/ecdc/full_data.csv'
     WHERE Source IS NULL;
     UPDATE Stage.OurWorldDataDailyCountry
       SET 
           LoadTime = GETDATE()
     WHERE LoadTime IS NULL;
     UPDATE Stage.OurWorldDataDailyCountry
       SET 
           Hash = HASHBYTES('SHA2_256', CAST([date] AS NVARCHAR(27)) + CAST([location] AS NVARCHAR(64)))
     FROM Stage.OurWorldDataDailyCountry
     WHERE Hash IS NULL;
	 --country name fixes 20200417
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Brunei Darussalam', Source = 'Covid19DataVault'  where Location = 'Brunei' 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Congo, Rep.', Source = 'Covid19DataVault'  where Location = 'Congo' 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Congo, Dem. Rep.', Source = 'Covid19DataVault'  where Location = 'Democratic Republic of Congo' 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Timor-Leste', Source = 'Covid19DataVault'  where Location = 'Timor'
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Virgin Islands (U.S.)', Source = 'Covid19DataVault'  where Location = 'United States Virgin Islands'
	 --country name fixes 2020-05-01
	 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Russian Federation', Source = 'Covid19DataVault'  where Location = 'Russia' 
	 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Egypt, Arab Rep.',  Source = 'Covid19DataVault'  where Location = 'Egypt' 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Iran, Islamic Rep.',  Source = 'Covid19DataVault'  where Location = 'Iran' 
	 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Kyrgyz Republic',  Source = 'Covid19DataVault'  where Location = 'Kyrgyzstan' 
	 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Lao PDR', Source = 'Covid19DataVault'  where Location = 'Laos' 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'North Macedonia',Source = 'Covid19DataVault'  where Location = 'Macedonia' 

	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Slovak Republic', Source = 'Covid19DataVault'  where Location = 'Slovakia' 
	 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Korea, Rep.', Source = 'Covid19DataVault'  where Location = 'South Korea' 
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Syrian Arab Republic', Source = 'Covid19DataVault'  where Location = 'Syria'
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Venezuela, RB' , Source = 'Covid19DataVault'  where Location = 'Venezuela'
	 --country name fixes 2020-05-20

	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Bahamas, The' , Source = 'Covid19DataVault'  where Location = 'Bahamas'
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'BES Islands' , Source = 'Covid19DataVault'  where Location = 'Bonaire Sint Eustatius and Saba'
	 update [Stage].[OurWorldDataDailyCountry]  set Location = 'Cabo Verde' , Source = 'Covid19DataVault'  where Location = 'Cape Verde'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'Faroe Islands' , Source = 'Covid19DataVault'  where Location = 'Faeroe Islands'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'Gambia, The' , Source = 'Covid19DataVault'  where Location = 'Gambia'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'West Bank and Gaza' , Source = 'Covid19DataVault'  where Location = 'Palestine'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'St. Kitts and Nevis' , Source = 'Covid19DataVault'  where Location = 'Saint Kitts and Nevis'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'St. Lucia' , Source = 'Covid19DataVault'  where Location = 'Saint Lucia'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'St. Vincent and the Grenadines' , Source = 'Covid19DataVault'  where Location = 'Saint Vincent and the Grenadines'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'Eswatini' , Source = 'Covid19DataVault'  where Location = 'Swaziland'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'Yemen, Rep.' , Source = 'Covid19DataVault'  where Location = 'Yemen'
	update [Stage].[OurWorldDataDailyCountry]  set Location = 'Vatican City' , Source = 'Covid19DataVault'  where Location = 'Vatican'

	--remove aggregated daily total from per country total table 2020-06-29
	DELETE from [Stage].[OurWorldDataDailyCountry]   where Location = 'World';
	--place missing values to Stage.OurWorldDataDailyCountryMissingCount
	TRUNCATE TABLE [Stage].[OurWorldDataDailyCountryMissingCount]  
	INSERT INTO [Stage].[OurWorldDataDailyCountryMissingCount] 	SELECT * from [Stage].[OurWorldDataDailyCountry] WHERE new_cases is NULL;
	DELETE FROM [Stage].[OurWorldDataDailyCountry] WHERE new_cases is NULL
	 
	 RETURN(0)
	 Print'ok'

GO
/****** Object:  StoredProcedure [Stage].[upProcessJson]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upProcessJson]
AS
     IF EXISTS
     (
         SELECT *
         FROM sys.tables
         WHERE name LIKE 'JsonDocument'
     )
         DROP TABLE Stage.JsonDocument;
     SELECT *
     INTO Stage.JsonDocument
     FROM OPENROWSET(BULK 'T:\Documents\kDSResearch2020\StateDelta.json', SINGLE_CLOB) AS j;
     DECLARE @json NVARCHAR(MAX);
     SELECT @json = BULKCOLUMN
     FROM Stage.JsonDocument;

	 Truncate table Stage.DailyTotalByState 

     --parse JSON column  insert goes here
	 INSERT INTO Stage.DailyTotalByState  ([Date], State, Positive, Negative, Death, Hash)
	 SELECT * 
     FROM OPENJSON(@json) WITH 
	 (Date DATETIME2 '$.date', State VARCHAR(4) '$.state', Positive INT '$.positive'
	 , Negative INT '$.negative', Death INT '$.death', Hash NVARCHAR(40) '$.hash');

	 update Stage.DailyTotalByState Set Positive = 0 where Positive is NULL
	 update Stage.DailyTotalByState Set Negative = 0 where Negative is NULL
	 update Stage.DailyTotalByState Set Death = 0 where Death is NULL
	 update Stage.DailyTotalByState Set Source  = 'https://covidtracking.com/api/states/daily' where Source is NULL
	 update Stage.DailyTotalByState Set LoadTime = getdate() where LoadTime is NULL

	 Print 'OK'

	 Return(0)
GO
/****** Object:  StoredProcedure [Stage].[upProcessStatePopulationDensityJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upProcessStatePopulationDensityJSON]
AS
     IF NOT EXISTS
     (
         SELECT name
         FROM sys.tables
         WHERE name LIKE 'StatePopulationDensity'
     )
         CREATE TABLE Stage.StatePopulationDensity
         ([Year]   NVARCHAR(4), 
          [State]  NVARCHAR(48), 
          Density  DECIMAL(8, 2), 
          Pop      INTEGER, 
          LandArea DECIMAL(10, 2), 
          LoadDate DATETIME2,
		  [Source] NVARCHAR(92)
         );
     SELECT *
     INTO #1
     FROM OPENROWSET(BULK 'T:\Documents\kDSResearch2020\data.json', SINGLE_CLOB) AS j;
     DECLARE @json NVARCHAR(MAX);
     SELECT @json = BulkColumn
     FROM #1;
     TRUNCATE TABLE Stage.StatePopulationDensity;

     --parse JSON column  insert goes here
     INSERT INTO Stage.StatePopulationDensity
     ([Year],
	 [State], 
      Density, 
      Pop, 
      LandArea,
	  LoadDate,
	  [Source]
     )
            SELECT '2020', *, getdate(), 'https://worldpopulationreview.com/states/state-densities/'
            FROM OPENJSON(@json, '$.data') --notice
			WITH([State] NVARCHAR(48) '$.State', Density DECIMAL(8, 2) '$.Density', Pop INT '$.Pop', LandArea INT '$.LandArea');

     PRINT 'OK';
     RETURN(0);
GO
/****** Object:  StoredProcedure [Stage].[upUSCensusCountyPopulation]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [Stage].[upUSCensusCountyPopulation] as
UPDATE Stage.USCensusCountyPopulation
       SET 
           Source = 'https://www.census.gov/data/datasets/time-series/demo/popest/2010s-counties-total.html' 
     WHERE Source IS NULL;
     UPDATE Stage.USCensusCountyPopulation
       SET 
           LoadTime = GETDATE()
     WHERE LoadTime IS NULL;
     UPDATE Stage.USCensusCountyPopulation
       SET 
           Hash = HASHBYTES('SHA2_256',  ([PopulationYear] + STNAME + CTYNAME))
          WHERE Hash IS NULL;

	UPDATE Stage.USCensusCountyPopulation
       SET RegionName = 'Northeast' where REGION = 1
         
	UPDATE Stage.USCensusCountyPopulation
       SET RegionName = 'Midwest' where REGION = 2
    
	UPDATE Stage.USCensusCountyPopulation
       SET RegionName = 'South' where REGION = 3
    
	UPDATE Stage.USCensusCountyPopulation
       SET RegionName = 'West' where REGION = 4

	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'New England' where DIVISION = 1
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'Middle Atlantic' where DIVISION = 2
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'East North Central' where DIVISION = 3
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'West North Central' where DIVISION = 4
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'South Atlantic' where DIVISION = 5
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'East South Central' where DIVISION = 6
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'West South Central' where DIVISION = 7
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'Mountain' where DIVISION = 8
    
	UPDATE Stage.USCensusCountyPopulation
       SET DivisionName = 'Pacific' where DIVISION = 9
    
	RETURN(0)
	 Print'ok'
GO
/****** Object:  StoredProcedure [Stage].[upUSCensusCountyPopulationJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Stage].[upUSCensusCountyPopulationJSON]
	 as
	 declare @j varchar(max)

	 truncate table Stage.JsonDocument
	
	set @j = (SELECT [PopulationYear]
      ,[REGION]
	  ,[RegionName]
      ,[DIVISION]
	  , [DivisionName]
      ,[STATE]
      ,[STNAME]
      ,[CTYNAME]
      ,[BIRTHS2019]
      ,[POPESTIMATE2019]
      ,[NATURALINC2019]
      ,[INTERNATIONALMIG2019]
      ,[RBIRTH2019]
      ,[DEATHS2019]
      ,[RDEATH2019]
      ,[Hash]
      ,[LoadTime]
      ,[Source]
  FROM [Stage].[USCensusCountyPopulation]
  		FOR JSON AUTO )
  
 INSERT INTO Stage.JsonDocument values (@j)

 select BulkColumn from Stage.JsonDocument
GO
/****** Object:  StoredProcedure [Stage].[upWorldRegion]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [Stage].[upWorldRegion] as
UPDATE Stage.WorldRegion
       SET 
           Source = 'https://sciencetrends.com/the-geographic-regions-of-the-world/' 
     WHERE Source IS NULL;
     UPDATE Stage.WorldRegion
       SET 
           LoadTime = GETDATE()
     WHERE LoadTime IS NULL;
     UPDATE Stage.WorldRegion
       SET 
           Hash = HASHBYTES('SHA2_256',  ([RegionYear] + WorldRegion + WorldSubRegion + Country))
          WHERE Hash IS NULL;
	 RETURN(0)
	 Print'ok'

GO
/****** Object:  StoredProcedure [Stage].[upWorldRegionJSON]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Stage].[upWorldRegionJSON]
AS
     DECLARE @j VARCHAR(MAX);
     TRUNCATE TABLE Stage.JsonDocument;
     SET @j =
     (
         SELECT 'Core.WorldRegion' AS Destination, 
                [RegionYear], 
                [WorldRegion], 
                'Covid19DataVault' AS Source
         FROM [Stage].[WorldRegion]
         GROUP BY [RegionYear], 
                  [WorldRegion] FOR JSON AUTO
     );
     INSERT INTO Stage.JsonDocument
     VALUES(@j);
     SELECT BulkColumn
     FROM Stage.JsonDocument;
GO
/****** Object:  StoredProcedure [Utility].[upGenerateDataVaultForeignKey]    Script Date: 7/22/2020 10:28:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Utility].[upGenerateDataVaultForeignKey] 
as

DECLARE @nextID INT, @itemCount INT, @startEffectiveDate DATETIME2, @maxID INT, @counter INT, @maxLinkID INT, @nextLinkID INT;

IF OBJECT_ID('tempdb.dbo.#inBound') IS NOT NULL
    DROP TABLE #inBound;
IF OBJECT_ID('tempdb.dbo.#add') IS NOT NULL
    DROP TABLE #add;

SELECT ROW_NUMBER() OVER(
       ORDER BY b.[COLUMN_NAME]) AS ID, 
       b.TABLE_SCHEMA as [Schema], 
       a.TABLE_NAME as [Table], 
       b.COLUMN_NAME as [ForeignKeyColumn], 
       [NewID] = 0
INTO #inBound
FROM INFORMATION_SCHEMA.TABLES AS a
     INNER JOIN information_schema.COLUMNS AS b ON a.TABLE_NAME = b.TABLE_NAME
WHERE b.TABLE_SCHEMA IN('Link', 'ITEM')
     AND RIGHT(b.COLUMN_NAME, 2) = 'ID'
     AND b.ORDINAL_POSITION > 1; 

SELECT *
INTO #add
FROM #inbound;
SET @itemCount = @@ROWCOUNT;

--assign ID 
SELECT @maxID = 0, 
       @maxLinkID = 0;
SELECT @maxID = COUNT(name)
FROM sys.foreign_keys;

--table is empty
IF @maxID IS NULL
    SELECT @maxID = 0, 
           @nextID = 1;
    ELSE  --table not empty calculate next ID
    SET @nextID = @maxID + 1;
SELECT @counter = 1;

--assign ID
WHILE(@counter <= @itemCount)
    BEGIN
        UPDATE #add
          SET 
              [NewID] = @nextID
        WHERE ID = @counter;
        SELECT @counter = @counter + 1, 
               @nextID = @nextID + 1;
    END;
ALTER TABLE #add
ADD ConstraintName NVARCHAR(64);
ALTER TABLE #add
ADD ReferenceTableColumn NVARCHAR(128);
UPDATE #add
  SET 
      ConstraintName = ForeignKeyColumn + STUFF('000', 3, 1, CAST(NewID AS NVARCHAR(4)))
FROM #add
WHERE LEN(NewID) = 1;
UPDATE #add
  SET 
      ConstraintName = ForeignKeyColumn + STUFF('000', 2, 2, CAST(NewID AS NVARCHAR(4)))
FROM #add
WHERE LEN(NewID) > 1;
UPDATE #add
  SET 
      ReferenceTableColumn = 'Core.' + SUBSTRING(ForeignKeyColumn, 1, LEN(ForeignKeyColumn) - 2) + '(' + ForeignKeyColumn + ')';

UPDATE #add
  SET 
      ReferenceTableColumn = 'Item.' + SUBSTRING(ForeignKeyColumn, 1, LEN(ForeignKeyColumn) - 2) + '(' + ForeignKeyColumn + ')' WHERE ForeignKeyColumn like '%Detail%';

SELECT *
FROM #add;
GO
USE [master]
GO
ALTER DATABASE [Covid19DataVault] SET  READ_WRITE 
GO
