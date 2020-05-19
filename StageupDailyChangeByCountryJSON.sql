CREATE PROCEDURE [Stage].[upDailyChangeByCountryJSON] (@monitorDate datetime2, @location nvarchar(48), 
@IDCount int, @jsonMessage nvarchar(max) OUTPUT)
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
                   b.Population, 
                   (CAST(a.new_cases AS INT) / CAST(b.Population AS DECIMAL(12, 2))) * 100 AS CaseCountPerPopulationPercent, 
                   (CAST(a.total_deaths AS INT) / CAST(b.Population AS DECIMAL(12, 2))) * 100 AS DeathCountPerPopulationPercent, 
                   CAST(c.Amount AS DECIMAL(12, 2)) AS IncomePerCapita2018, 
                   CAST(d.PopulationDensity AS DECIMAL(12, 2)) AS PopulationDensityPerKilometer, 
                   [PopulationDensityPerKilometer] = 0, 
                   [CaseThirtyDayMovingAverage] = 0, 
                   d.CountryCode, 
				   e.WorldRegion,
				   e.WorldSubRegion,
				   a.[Hash], 
                   GETDATE(), -- loadtime 
                   a.[Source]
            FROM [Covid19DataVault].[Stage].[OurWorldDataDailyCountry] AS a
                 INNER JOIN Stage.WorldPopulation AS b ON a.Location = b.Country
                 LEFT OUTER JOIN Stage.WorldBankPerCapitaIncome AS c ON a.Location = c.Country
                 LEFT OUTER JOIN Stage.WorldPopulationDensity AS d ON a.Location = d.Country
				 LEFT OUTER JOIN Stage.WorldRegion as e on a.Location = e.Country
            WHERE c.[year] =
            (
                SELECT MAX(year)
                FROM [Covid19DataVault].[Stage].[WorldBankPerCapitaIncome]
            )
                  AND a.[date] = @monitorDate
				  AND a.[location] = @location;

     
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