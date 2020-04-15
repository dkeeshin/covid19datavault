USE Covid19DataVault
GO

if exists (select * from sys.tables where name = 'CSVCovidWorldDaily')
DROP table Stage.CSVCovidWorldDaily;

if exists (select * from sys.tables where name = 'DailyTotalByCountry')
DROP table Stage.DailyTotalByCountry;

if exists (select * from sys.tables where name = 'DailyTotalByState')
DROP table Stage.DailyTotalByState;


