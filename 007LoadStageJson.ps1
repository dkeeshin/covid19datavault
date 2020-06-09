#07StageJsonLoad load json from Web request
#20200403 DLK

param([string] $destinationServerName = "ServerName\InstanceGoesHere", 
      [string] $sourceFilePath = "T:\Documents\kDSResearch2020\CovidTrackingDailyState.json" 
        )

CLS

$request = 'https://covidtracking.com/api/states/daily' 
$fromWeb = Invoke-WebRequest $request 


$database = "Covid19DataVault"
$queryString = "EXEC Stage.upCovidTrackingDailyState "

#write results to files
$jsonFilePath = $sourceFilePath
Set-Content $jsonFilePath  $fromWeb  #ouputs file to json file

Write-Host "Executing SQL..."

CLS

#process JSON --execute store procedure to parse JSON file in SQL Server
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -Query $queryString

Write-Host "Done..."


 
