USE [Covid19DataVault]
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
