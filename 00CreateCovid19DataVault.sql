USE master
GO

CREATE DATABASE Covid19DataVault;
GO
USE Covid19DataVault;
GO
CREATE SCHEMA Stage;
GO

Create table Stage.DailyTotalByState
([Date] datetime2 not Null,
State nvarchar(2)  not null,
Positive int null,
Negative int null,
Death int null,
Hash nvarchar(40) null,
Source nvarchar(64) null
)

Create table Stage.DailyTotalByCountry
([Date] datetime2 not Null,
Location nvarchar(34)  not null,
new_cases int null,
total_cases int null,
new_deaths int null,
total_deaths int null,
Hash nvarchar(40) null,
Source nvarchar(64) null,)


USE [Covid19DataVault]
GO
/****** Object:  StoredProcedure [Stage].[upProcessJson]    Script Date: 4/1/2020 11:09:19 AM ******/
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


﻿USE [Covid19DataVault]
GO
/****** Object:  StoredProcedure [Stage].[upDailyTotalByCountry]    Script Date: 4/1/2020 12:46:23 PM ******/
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
