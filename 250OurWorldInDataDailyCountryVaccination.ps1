#Our World In Data Load 
#20200817 DLK
CLS

$createTableTemplate =  @'
USE $($database) 
GO `n

BEGIN TRY
BEGIN TRANSACTION;

IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA = 'Load' and TABLE_NAME = 'OWIDDailyCountryVaccinationAllText')
DROP TABLE Load.OWIDDailyCountryVaccinationAllText; 

create table Load.OWIDDailyCountryVaccinationALLText 
(location nvarchar(48),
iso_code NVARCHAR(8),
date nvarchar(10), 
total_vaccinations NVARCHAR(24), 
total_vaccinations_per_hundred NVARCHAR(24), 
daily_vaccinations_raw NVARCHAR(24), 
daily_vaccinations  NVARCHAR(24),
daily_vaccinations_per_million NVARCHAR(24),
people_vaccinated NVARCHAR(24),
people_fully_vaccinated_per_hundred NVARCHAR(24),
people_fully_vaccinated NVARCHAR(24)
 )

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

INSERT INTO Load.OWIDDailyCountryVaccinationAllText 
(location ,
iso_code ,
date , 
total_vaccinations , 
total_vaccinations_per_hundred , 
daily_vaccinations_raw , 
daily_vaccinations  ,
daily_vaccinations_per_million ,
people_vaccinated ,
people_fully_vaccinated_per_hundred, 
people_fully_vaccinated
           )
     VALUES
     ( '$($item.location -replace "'", "''")',   
       '$($item.iso_code)',
       '$($item.date)',
       '$($item.total_vaccinations)',
       '$($item.total_vaccinations_per_hundred)',
       '$($item.daily_vaccinations_raw)',
       '$($item.daily_vaccinations )',
       '$($item.daily_vaccinations_per_million)',
       '$($item.people_vaccinated)',
       '$($item.people_fully_vaccinated_per_hundred)',
       '$($item.people_fully_vaccinated)'
        )

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
$csvFilePath = "T:\Documents\kDSResearch2020\OWIDCountryVaccination.csv" 
$database = "Covid19DataVault"
$startTime = (Get-Date)
Write-Host "Getting Vaccination Data from OWID..."
$request =  'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv'
$csvFromWeb = Invoke-WebRequest $request

#write results to file from web
Set-Content $csvFilePath  $csvFromWeb


$sqlFilePathResult = 'T:\Documents\kDSResearch2020\OWIDCountryVaccination.txt'
$startDate = (get-date).AddDays(-3).ToString('yyyy-MM-dd')  #data date start range
$stageScript = "EXEC Stage.upOWIDDailyCountryVaccinationWithNull"  ## creates staging table and assigns datatypes to columns 
##$startDate = ''
  

#import CSV file
$csv = Import-Csv $csvFilePath


$createTableScript = $ExecutionContext.InvokeCommand.ExpandString($createTableTemplate)

#load CSV  -- run SQL script generated above
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $createTableScript > $sqlFilePathResult  ##ok

Write-Host "Processing OurWorld Country Vaccination CSV data..."
Write-Host "Process started at "  (Get-Date)
ForEach ($item in $csv){
  ##IF ($item.date -ge $startDate)   
   ## {   
  
    $loadTableScript = $ExecutionContext.InvokeCommand.ExpandString($insertTableTemplate)
    Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $loadTableScript ##> $sqlFilePathResult  ##ok

     ##}
 }

Write-Host "Executing SQL..."


##insert rows to stage table, replace blank columns with NULL, remove blank case/death counts and invalid country codes
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $stageScript

$endTime = (Get-Date)
Write-Host "Processing took $($startTime - $endTime ) "

Write-Host "Done..."

