CLS

$triggerTime = "7:30pm"
$Time=New-ScheduledTaskTrigger -Daily -At $triggerTime  
$scriptDirectoryPath = "scriptDirectoryPathGoesHere"
$actions   = (New-ScheduledTaskAction -Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\07StageJsonLoad.ps1'),   #CovidTrackingDailyState.json 
             (New-ScheduledTaskAction –Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\11NYTCovid19USCounty.ps1'),
             (New-ScheduledTaskAction –Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\12NYTCovid19State.ps1'),
             (New-ScheduledTaskAction –Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\09OurWorldDataDailyCountry.ps1')
       
Register-ScheduledTask -TaskName "Daily State Stage Load from Source" -Trigger $Time -Action $actions -RunLevel Highest


