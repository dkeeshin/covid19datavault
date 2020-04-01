#Covid19 daily data vault staging table loads
#20200331 DLK
CLS
$request = 'https://covidtracking.com/api/states/daily' 
$result = Invoke-WebRequest $request 

$csvTest = 'https://covid.ourworldindata.org/data/ecdc/full_data.csv'
$result02 = Invoke-WebRequest $csvTest

#write results to files

Set-Content T:\Documents\kDSResearch2020\StateDelta.json  $result  #ouputs file to json file
Set-Content T:\Documents\kDSResearch2020\CovidWorldDaily.csv  $result02

#process CSV file
$currentFile = "T:\Documents\kDSResearch2020\CovidWorldDaily.csv" 

$csv = Import-Csv $currentFile 

#initialize  sql file
Set-Content T:\Documents\kDSResearch2020\CovidWorldDaily.sql -value "--Script to load World data`n"
Add-Content T:\Documents\kDSResearch2020\CovidWorldDaily.sql "If exists (select * from sys.tables where name like 'CSVCovidWorldDaily')" 
Add-Content T:\Documents\kDSResearch2020\CovidWorldDaily.sql  "DROP TABLE Stage.CSVCovidWorldDaily; "
Add-Content T:\Documents\kDSResearch2020\CovidWorldDaily.sql "create table Stage.CSVCovidWorldDaily (date nvarchar(10), location nvarchar(48), new_cases int, new_deaths int, total_cases int, total_deaths int)"

Write-Host "Processing CSV..."
ForEach ($item in $csv){ 

  #location has replace parameter to accomodate locations with single quote in name like cote d'ivoire
  $sqlInsert = "INSERT INTO Stage.CSVCovidWorldDaily values('" + ($item.date) + "','" +($item.location -replace "'", "''") +  "'," + ($item.new_cases) + "," + ($item.new_deaths) + ","+ ($item.total_cases) +","+ ($item.total_deaths)+ ""+ ")" 
  Add-Content T:\Documents\kDSResearch2020\CovidWorldDaily.sql  $sqlInsert
 }

Write-Host "Executing SQL..."

CLS
$sourceServerName = "KDSDESKTOP01\MSSQLSERVER2019"
$destinationServerName = "KDSDESKTOP01\MSSQLSERVER2019"

$database = "Covid19DataVault"
$queryString = "EXEC Stage.upProcessJson "
#process JSON --execute store procedure to load JSON file
Invoke-Sqlcmd -ServerInstance $sourceServerName -Database $database -Query $queryString

#load CSV  -- run SQL script generated above
Invoke-Sqlcmd -ServerInstance $sourceServerName -Database $database -InputFile "T:\Documents\kDSResearch2020\CovidWorldDaily.sql" > "T:\Documents\kDSResearch2020\CovidWorldDaily.txt"

#process CSV -- executes Stored procedure in Covid19DataVault database
$queryString = "EXEC Stage.upDailyTotalByCountry"
Invoke-Sqlcmd -ServerInstance $sourceServerName -Database $database -Query $queryString

Write-Host "Done..."


 
