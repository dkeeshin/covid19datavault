#Covid19 daily data vault staging table loads
#now only loads last two days worth of data 20202-07-21
#20200406 DLK


param([string] $destinationServerName = "ServerNameGoesHere\InstanceNameGoesHere", 
      [string] $sourceFilePath = "T:\Documents\kDSResearch2020\us-counties.csv" 
        )

CLS

$request = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv' 
$fromWeb = Invoke-WebRequest $request 

$database = "Covid19DataVault"
$queryString = "EXEC [Stage].[upNYTimesCovid19USCounty]"

$csvFilePath = $sourceFilePath
$sqlFilePath = 'T:\Documents\kDSResearch2020\NYTimesCovid19USCounty.sql'
$sqlFilePathResult = 'T:\Documents\kDSResearch2020\NYTimesCovid19USCounty.txt'
$tableName = "NYTimesCovid19USCounty"
$tableDefinition ="([date] nvarchar(10), county nvarchar(48), [state] nvarchar(32),  fips nvarchar(8), cases int, deaths int, [Hash] [varbinary](32) NULL, [LoadTime] [datetime2](7) NULL, [Source] [nvarchar](92) NULL, USCensusCounty nvarchar(64) NULL) "
$yesterday = (get-date).AddDays(-1).ToString('yyyy-MM-dd')
Write-Host "Gathering NYTimes County data for " $yesterday


#write results to file from web
Set-Content $csvFilePath $fromWeb

#import CSV file
$csv = Import-Csv $csvFilePath

Set-Content $sqlFilePath -value "--Script to load NYTimesUSCounty`n"

$innerTemplate = @'
--Script to load NYTimesUSCounty
If exists (select * from sys.tables where name like '$($tableName)')
DROP TABLE Stage.$tableName;
create table Stage.$($tableName)$tableDefinition
`n
'@

Write-Host "Generating SQL Script from CSV file..."

$sqlInsert= $ExecutionContext.InvokeCommand.ExpandString($innerTemplate)

Add-Content $sqlFilePath  $sqlInsert


ForEach ($item in $csv){ 

 #location has replace parameter to accomodate locations with single quote in name like cote d'ivoire

  IF([string]::IsNullOrWhiteSpace($item.fips)) {            
    $item.fips = "0"
} 
else {            
    $item.fips = $item.fips
}            
    IF ($item.date -eq $yesterday)
    {
     $sqlInsert = "INSERT INTO Stage.NYTimesCovid19USCounty (date, county, state,fips, cases, deaths)  values('" + ($item.date) + "','" +($item.county -replace "'", "''") +  "','" + ($item.state) + "','" + ($item.fips) + "',"+ ($item.cases) +","+ ($item.deaths)+ ""+ ")" 
    Add-Content $sqlFilePath  $sqlInsert
     }
  
   }

Write-Host "Executing SQL..."

#load CSV  -- run SQL script generated above
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database  -QueryTimeout 1000 -InputFile $sqlFilePath > $sqlFilePathResult 

#process CSV -- executes Stored procedure in Covid19DataVault database
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000 -Query $queryString 

Write-Host "Done..."
