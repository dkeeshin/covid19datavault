#Covid19 daily data vault staging table load
#20200406 DLK
CLS

$request = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv' 
$fromWeb = Invoke-WebRequest $request 

$destinationServerName = "DatabaseServer/InstanceNameGoesHere"
$database = "Covid19DataVault"
$queryString = "EXEC [Stage].[upNYTimesCovid19USState]"

$csvFilePath = 'T:\Documents\kDSResearch2020\us-states.csv'
$sqlFilePath = 'T:\Documents\kDSResearch2020\NYTimesCovid19USState.sql'
$sqlFilePathResult = 'T:\Documents\kDSResearch2020\NYTimesCovid19USState.txt'
$tableName = "NYTimesCovid19USState"
$tableDefinition ="(date nvarchar(10), state nvarchar(32),  fips nvarchar(8),cases int, deaths int, [Hash] [varbinary](32) NULL, [LoadTime] [datetime2](7) NULL, [Source] [nvarchar](92) NULL )"

#write results to file from web
Set-Content $csvFilePath $fromWeb

#import CSV file
$csv = Import-Csv $csvFilePath

$startTemplate = @' 
--Script to load $($tableName)
If exists (select * from sys.tables where name like '$($tableName)')
DROP TABLE Stage.$tableName;
create table Stage.$($tableName) $($tableDefinition)
`n
'@

Write-Host "Generating SQL script from CSV file..."

$sqlStart = $ExecutionContext.InvokeCommand.ExpandString($startTemplate) 

Set-Content $sqlFilePath $sqlStart 

ForEach ($item in $csv){ 

 #Replace blank fips with 0
  IF([string]::IsNullOrWhiteSpace($item.fips)) {            
    $item.fips = "0"
} 
else {            
    $item.fips = $item.fips
}            

  $sqlInsert = "INSERT INTO Stage." +$tableName + "(date, state,fips, cases, deaths)  values('" + ($item.date) + "','" + ($item.state) + "','" + ($item.fips) + "',"+ ($item.cases) +","+ ($item.deaths)+ ""+ ")" 
  Add-Content $sqlFilePath  $sqlInsert
  
 }

Write-Host "Executing SQL script..."

#load CSV  -- run SQL script generated above
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000 -InputFile $sqlFilePath > $sqlFilePathResult 

#process CSV -- executes Stored procedure in Covid19DataVault database
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000  -Query $queryString

Write-Host "Done..."
