#07StageJsonLoad load json from Web request
#20200403 DLK
CLS

$request = 'https://covidtracking.com/api/states/daily' 
$fromWeb = Invoke-WebRequest $request 
$destinationServerName = "DatabaseServer/InstanceNameGoesHere"

$database = "Covid19DataVault"
$queryString = "EXEC Stage.upCovidTrackingDailyState "

#write results to files
$jsonFilePath = 'T:\Documents\kDSResearch2020\CovidTrackingDailyState.json'
Set-Content $jsonFilePath  $fromWeb  #ouputs file to json file

Write-Host "Executing SQL..."

CLS

#process JSON --execute store procedure to parse JSON file in SQL Server
Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -Query $queryString

Write-Host "Done..."


 
