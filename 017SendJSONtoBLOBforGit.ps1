FUNCTION SendJSONToBLOB
{

param(
      [string] $destinationServerName, 
      [string] $jsonFilePath,
      [string] $database   ,
      [string] $queryString 
        )

CLS
        
#process CSV -- executes Stored procedure in Covid19DataVault database
$results = Invoke-Sqlcmd -ServerInstance $destinationServerName -Database $database -QueryTimeout 1000 -MaxCharLength 1000000  -Query $queryString 

#$results.BulkColumn

#set content to BLOB storage on Azure
Set-Content $jsonFilePath $results.BulkColumn
Write-Host "Files Created"
}

SendJSONToBLOB -destinationServerName "DatabaseServer\InstanceNameGoesHere" -jsonFilePath "T:\Documents\kDSResearch2020\NYTimesCovid19USState.json" -database "Covid19DataVault" -queryString "EXEC [Stage].[upNYTimesCovid19USStateJSON]" 
SendJSONToBLOB -destinationServerName "DatabaseServer\InstanceNameGoesHere" -jsonFilePath "T:\Documents\kDSResearch2020\NYTimesCovid19USCounty.json" -database "Covid19DataVault" -queryString "EXEC [Stage].[upNYTimesCovid19UsCountyJson]" 
SendJSONToBLOB -destinationServerName "DatabaseServer\InstanceNameGoesHere" -jsonFilePath "T:\Documents\kDSResearch2020\OurWorldDailyCountry.json" -database "Covid19DataVault" -queryString "EXEC [Stage].[upOurWorldDailyCountryJson]"
SendJSONToBLOB -destinationServerName "DatabaseServer\InstanceNameGoesHere"-jsonFilePath "T:\Documents\kDSResearch2020\CovidTrackingDailyState.json" -database "Covid19DataVault" -queryString "EXEC [Stage].[upCovidTrackingDailyStateJSON]"
