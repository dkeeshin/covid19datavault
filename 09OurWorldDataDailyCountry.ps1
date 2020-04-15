#Covid19 daily data vault staging table loads
#20200331 DLK
CLS

$request = 'https://covid.ourworldindata.org/data/ecdc/full_data.csv'
$csvFromWeb = Invoke-WebRequest $request

$destinationServerName = "DatabaseServer/InstanceNameGoesHere"
$database = "Covid19DataVault"
$queryString = "EXEC [Stage].[upOurWorldDataDailyCountry]"

$csvFilePath = 'T:\Documents\kDSResearch2020\OurWorldDataDailyCountry.csv'
$sqlFilePath = 'T:\Documents\kDSResearch2020\OurWorldDataDailyCountry.sql'
$sqlFilePathResult = 'T:\Documents\kDSResearch2020\OurWorldDataDailyCountry.txt'


#write results to file from web
Set-Content $csvFilePath  $csvFromWeb

#import CSV file
$csv = Import-Csv $csvFilePath

#initialize  sql file
Set-Content $sqlFilePath -value "--Script to load World data`n"
Add-Content $sqlFilePath "If exists (select * from sys.tables where name like 'OurWorldDataDailyCountry')" 
Add-Content $sqlFilePath  "DROP TABLE Stage.OurWorldDataDailyCountry; "
Add-Content $sqlFilePath "create table Stage.OurWorldDataDailyCountry (date nvarchar(10), location nvarchar(48), new_cases int, new_deaths int, total_cases int, total_deaths int, [Hash] [varbinary](32) NULL, [LoadTime] [datetime2](7) NULL, [Source] [nvarchar](64) NULL )"

Write-Host "Processing CSV..."
ForEach ($item in $csv){ 
  #location has replace parameter to accomodate locations with single quote in name like cote d'ivoire
  $sqlInsert = "INSERT INTO Stage.OurWorldDataDailyCountry ([date], location, new_cases, new_deaths, total_cases, total_deaths) values('" + ($item.date) + "','" +($item.location -replace "'", "''") +  "'," + ($item.new_cases) + "," + ($item.new_deaths) + ","+ ($item.total_cases) +","+ ($item.total_deaths)+ ""+ ")" 
  Add-Content $sqlFilePath  $sqlInsert
 }

Write-Host "Executing SQL..."

CLS

#load CSV  -- run SQL script generated above
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -InputFile $sqlFilePath > $sqlFilePathResult 

#process CSV -- executes Stored procedure in Covid19DataVault database
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -Query $queryString

Write-Host "Done..."


 
