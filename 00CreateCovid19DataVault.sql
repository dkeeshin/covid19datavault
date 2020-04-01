CREATE DATABASE Covid19DataVault;
GO
USE Covid19DataVault;
GO
CREATE SCHEMA Stage;
GO

CREATE TABLE Stage.DailyTotalByState
([Date]   DATETIME2 NOT NULL, 
 State    NVARCHAR(2) NOT NULL, 
 Positive INT NULL, 
 Negative INT NULL, 
 Death    INT NULL, 
 Hash     NVARCHAR(40) NULL, 
 LoadTime     datetime2  NULL, 
 Source   NVARCHAR(64) NULL
);
CREATE TABLE Stage.DailyTotalByCountry
([Date]       DATETIME2 NOT NULL, 
 Location     NVARCHAR(34) NOT NULL, 
 new_cases    INT NULL, 
 total_cases  INT NULL, 
 new_deaths   INT NULL, 
 total_deaths INT NULL, 
 Hash         NVARCHAR(40) NULL, 
 LoadTime     datetime2  NULL, 
 Source       NVARCHAR(64) NULL,
);
USE [Covid19DataVault];
GO

/****** Object:  StoredProcedure [Stage].[upProcessJson]    Script Date: 4/1/2020 11:09:19 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
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
     TRUNCATE TABLE Stage.DailyTotalByState;

     --parse JSON column  insert goes here
     INSERT INTO Stage.DailyTotalByState
     ([Date], 
      State, 
      Positive, 
      Negative, 
      Death, 
      Hash
     )
            SELECT *
            FROM OPENJSON(@json) WITH(Date DATETIME2 '$.date', State VARCHAR(4) '$.state', Positive INT '$.positive', Negative INT '$.negative', Death INT '$.death', Hash NVARCHAR(40) '$.hash');
     UPDATE Stage.DailyTotalByState
       SET 
           Positive = 0
     WHERE Positive IS NULL;
     UPDATE Stage.DailyTotalByState
       SET 
           Negative = 0
     WHERE Negative IS NULL;
     UPDATE Stage.DailyTotalByState
       SET 
           Death = 0
     WHERE Death IS NULL;
     UPDATE Stage.DailyTotalByState
       SET 
           Source = 'https://covidtracking.com/api/states/daily'
     WHERE Source IS NULL;
     UPDATE Stage.DailyTotalByState
       SET 
           LoadTime = GETDATE()
     WHERE LoadTime IS NULL;
     PRINT 'OK';
     RETURN(0);
	 
GO

USE [Covid19DataVault];
GO
/****** Object:  StoredProcedure [Stage].[upDailyTotalByCountry]    Script Date: 4/1/2020 12:46:23 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE PROCEDURE [Stage].[upDailyTotalByCountry]
AS
     TRUNCATE TABLE Stage.DailyTotalByCountry;
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
