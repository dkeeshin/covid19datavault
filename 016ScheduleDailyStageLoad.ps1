#updated 2020-07-21
CLS

$triggerTime = "7:30pm"
$Time=New-ScheduledTaskTrigger -Daily -At $triggerTime  
$scriptDirectoryPath = "scriptDirectoryPathGoesHere"
$actions   = (New-ScheduledTaskAction -Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\007LoadStageJson.ps1'),   #CovidTrackingDailyState.json 
             (New-ScheduledTaskAction –Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\080LoadOneDayNYTCovid19USCounty.ps1'),  #trying to make this go faster by only adding one day
             (New-ScheduledTaskAction –Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\012LoadNYTCovid19State.ps1'),
             (New-ScheduledTaskAction –Execute PowerShell.exe -WorkingDirectory $scriptDirectoryPath  -Argument $scriptDirectoryPath'\122OurWorldDataDailyCountryNullException.ps1')

       
Register-ScheduledTask -TaskName "Daily State Stage Load from Source" -Trigger $Time -Action $actions -RunLevel Highest


