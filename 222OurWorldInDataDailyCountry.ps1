#Our World In Data Load 
#20200817 DLK
CLS

$createTableTemplate =  @'
USE $($database) 
GO `n

BEGIN TRY
BEGIN TRANSACTION;

IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'Load' and TABLE_NAME = 'OurWorldInDataDailyCountryAllText')
DROP TABLE Load.OurWorldInDataDailyCountryAllText; 

create table Load.OurWorldInDataDailyCountryALLText 
(iso_code NVARCHAR(8),
continent NVARCHAR(16),
location nvarchar(48),
date nvarchar(10), 
total_cases NVARCHAR(12), 
new_cases NVARCHAR(12), 
new_cases_smoothed NVARCHAR(12), 
total_deaths NVARCHAR(12),
new_deaths NVARCHAR(12), 
new_deaths_smoothed NVARCHAR(24), 
total_cases_per_million NVARCHAR(24), 
new_cases_per_million NVARCHAR(24), 
new_cases_smoothed_per_million NVARCHAR(24), 
total_deaths_per_million NVARCHAR(24), 
new_deaths_per_million NVARCHAR(24), 
new_deaths_smoothed_per_million NVARCHAR(24), 
new_tests NVARCHAR(24),
total_tests NVARCHAR(24),
total_tests_per_thousand NVARCHAR(24), 
new_tests_per_thousand NVARCHAR(24), 
new_tests_smoothed NVARCHAR(24), 
new_tests_smoothed_per_thousand NVARCHAR(24), 
tests_per_case NVARCHAR(24), 
positive_rate NVARCHAR(24), 
tests_units NVARCHAR(32), 
stringency_index NVARCHAR(24), 
population NVARCHAR(24), 
population_density NVARCHAR(24), 
median_age  NVARCHAR(24), 
aged_65_older NVARCHAR(24), 
aged_70_older NVARCHAR(24), 
gdp_per_capita NVARCHAR(24), 
extreme_poverty NVARCHAR(24), 
cardiovasc_death_rate NVARCHAR(24), 
diabetes_prevalence NVARCHAR(24), 
female_smokers NVARCHAR(24), 
male_smokers NVARCHAR(24), 
handwashing_facilities NVARCHAR(24), 
hospital_beds_per_thousand NVARCHAR(24), 
life_expectancy NVARCHAR(24) )

END TRY
BEGIN CATCH
  SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;
IF @@TRANCOUNT > 0  
COMMIT TRANSACTION; 
GO `n
'@ 

$insertTableTemplate =  @'

BEGIN TRY
BEGIN TRANSACTION;

INSERT INTO Load.OurWorldINDataDailyCountryAllText 
           ([iso_code]
           ,[continent]
           ,[location]
           ,[date]
           ,[total_cases]
           ,[new_cases]
           ,[new_cases_smoothed]
           ,[total_deaths]
           ,[new_deaths]
           ,[new_deaths_smoothed]
           ,[total_cases_per_million]
           ,[new_cases_per_million]
           ,[new_cases_smoothed_per_million]
           ,[total_deaths_per_million]
           ,[new_deaths_per_million]
           ,[new_deaths_smoothed_per_million]
           ,[new_tests]
           ,[total_tests]
           ,[total_tests_per_thousand]
           ,[new_tests_per_thousand]
           ,[new_tests_smoothed]
           ,[new_tests_smoothed_per_thousand]
           ,[tests_per_case]
           ,[positive_rate]
           ,[tests_units]
           ,[stringency_index]
           ,[population]
           ,[population_density]
           ,[median_age]
           ,[aged_65_older]
           ,[aged_70_older]
           ,[gdp_per_capita]
           ,[extreme_poverty]
           ,[cardiovasc_death_rate]
           ,[diabetes_prevalence]
           ,[female_smokers]
           ,[male_smokers]
           ,[handwashing_facilities]
           ,[hospital_beds_per_thousand]
           ,[life_expectancy]
           )
     VALUES
     ( '$($item.iso_code)',
       '$($item.continent)',
       '$($item.location -replace "'", "''")',
       '$($item.date)',
       '$($item.total_cases)',
       '$($item.new_cases)',
       '$($item.new_cases_smoothed)',
       '$($item.total_deaths)',
       '$($item.new_deaths)',
       '$($item.new_deaths_smoothed)',
       '$($item.total_cases_per_million)',
       '$($item.new_cases_per_million)',
       '$($item.new_cases_smoothed_per_million)',
       '$($item.total_deaths_per_million)',
       '$($item.new_deaths_per_million)',
       '$($item.new_deaths_smoothed_per_million)',
       '$($item.new_tests)',
       '$($item.total_tests)',
       '$($item.total_tests_per_thousand)',
       '$($item.new_tests_per_thousand)',
       '$($item.new_tests_smoothed)',
       '$($item.new_tests_smoothed_per_thousand)',
       '$($item.tests_per_case)',
       '$($item.positive_rate)',
       '$($item.tests_units)',
       '$($item.stringency_index)',
       '$($item.population)',
       '$($item.population_density)',
       '$($item.median_age)',
       '$($item.aged_65_older)',
       '$($item.aged_70_older)',
       '$($item.gdp_per_capita)',
       '$($item.extreme_poverty)',
       '$($item.cardiovasc_death_rate)',
       '$($item.diabetes_prevalence)',
       '$($item.female_smokers)',
       '$($item.male_smokers)',
       '$($item.handwashing_facilities)',
       '$($item.$item.hospital_beds_per_thousand)',
       '$($item.life_expectancy)' )

END TRY
BEGIN CATCH
  SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
  
    IF @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION;  
END CATCH;
IF @@TRANCOUNT > 0  
COMMIT TRANSACTION; 
GO `n


'@

$destinationServerName = "SERVERNAMEGOESHERE"
$csvFilePath = "T:\Documents\kDSResearch2020\OurWorldDataDailyCountry.csv" 
$database = "Covid19DataVault"
$startTime = (Get-Date)

$request =  'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv' ##new path 20201202??? ##'https://covid.ourworldindata.org/data/owid-covid-data.csv'    ##NEw path 20200818
$csvFromWeb = Invoke-WebRequest $request

#write results to file from web
Set-Content $csvFilePath  $csvFromWeb


$sqlFilePathResult = 'T:\Documents\kDSResearch2020\OurWorldINDataDailyCountry.txt'
$startDate = (get-date).AddDays(-3).ToString('yyyy-MM-dd')  #data date start range
$stageScript = "EXEC Stage.upOurWorldInDataCountryWithNull"
##$startDate = ''
  

#import CSV file
$csv = Import-Csv $csvFilePath

CLS
$createTableScript = $ExecutionContext.InvokeCommand.ExpandString($createTableTemplate)

#load CSV  -- run SQL script generated above
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $createTableScript > $sqlFilePathResult  ##ok

Write-Host "Processing OurWorld Country CSV data..."
Write-Host "Process started at "  (Get-Date)
ForEach ($item in $csv){
  IF ($item.date -ge $startDate)   
    {   
  
    $loadTableScript = $ExecutionContext.InvokeCommand.ExpandString($insertTableTemplate)
    Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $loadTableScript ##> $sqlFilePathResult  ##ok

     }
 }

Write-Host "Executing SQL..."


##insert rows to stage table, replace blank columns with NULL, remove blank case/death counts and invalid country codes
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $stageScript

$endTime = (Get-Date)
Write-Host "Processing took $($startTime - $endTime ) "

Write-Host "Done..."

