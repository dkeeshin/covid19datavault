##sample JSON file clean up of CovidTracking State HISTORIC VALUES FOR ALL STATES 
##20200608
##dkeeshin@keeshinds,com

CLS
Write-Host "Doing lookup..."

$jsonfilePath = "T:\Documents\kDSResearch2020\"  
$jsonfilename= "CovidTracking"
$jsonDateLookup = 99990101
$jsonOutput = $jsonfilePath + $jsonfilename + $jsonDateLookup + ".json"

$request = 'https://covidtracking.com/api/v1/states/daily.json'   
$jsonFromTheWeb = Invoke-WebRequest $request
$j = $jsonFromTheWeb.Content|ConvertFrom-Json

CLS
Write-Host "Generating JSON..."
SET-Content $jsonOutput  "["

if ($jsonDateLookup -eq 99990101)   ##get the entire file
{
 foreach ($f in $j)
 {$f|Select-Object date,
    state,
    positive,
    negative,
    pending,
    hospitalizedCurrently  ,
    hospitalizedCumulative  ,
    inIcuCurrently  ,
    inIcuCumulative  ,
    onVentilatorCurrently  ,
    onVentilatorCumulative  ,
    recovered  ,
	death  ,
    lastUpdateEt  ,
    fips,
    hash|ConvertTo-Json|Add-Content $jsonOutPut } 
}
ELSE    ##get the specific date
{
 foreach ($f in $j ) {                
 if ($f.date -eq $jsonDateLookup ) {$f|Select-Object date,
    state,
    positive,
    negative,
    pending,
    hospitalizedCurrently  ,
    hospitalizedCumulative  ,
    inIcuCurrently  ,
    inIcuCumulative  ,
    onVentilatorCurrently  ,
    onVentilatorCumulative  ,
    recovered  ,
	death  ,
    lastUpdateEt  ,
    fips,
    hash|ConvertTo-Json|Add-Content $jsonOutPut }
    }
 }
     
  Add-Content "T:\Documents\kDSResearch2020\CovidTrackingTest20200608.json" "]"
  Write-Host "Done."
  

<#

Fields

checkTimeEt
    Field type: string

    Deprecated
commercialScore
    Field type: integer

    Deprecated
    Returns null if no data is available
dataQualityGrade
    Field type: string

    Grade assigned to the state based on the quality of their data reporting.
date
    Field type: integer

    Date for which the daily totals were collected.
dateChecked
    Field type: string

    Deprecated
dateModified
    Field type: string

    Deprecated, use lastUpdateEt instead
death
    Field type: integer

    Total number of people who have died as a result of COVID-19 so far.
    Returns null if no data is available
deathIncrease
    Field type: integer

    Deprecated
    Returns null if no data is available
fips
    Field type: string

    Census FIPS code for the state.
grade
    Field type: string

    Deprecated
hash
    Field type: string

    A hash of the current record.
hospitalized
    Field type: integer

    Deprecated
    Returns null if no data is available
hospitalizedCumulative
    Field type: integer

    Total number of people who have gone to the hospital for COVID-19 so far, including those who have since recovered or died.
    Returns null if no data is available
hospitalizedCurrently
    Field type: integer

    Number of people in hospital for COVID-19 on this day.
    Returns null if no data is available
hospitalizedIncrease
    Field type: integer

    Deprecated
    Returns null if no data is available
inIcuCumulative
    Field type: integer

    Total number of people who have gone to the ICU for COVID-19 so far, including those who have since recovered or died.
    Returns null if no data is available
inIcuCurrently
    Field type: integer

    Total number of people in the ICU for COVID-19 on this day.
    Returns null if no data is available
lastUpdateEt
    Field type: string

    Last time the day's data was updated.
negative
    Field type: integer

    Total number of people who have tested negative for COVID-19 so far.
    Returns null if no data is available
negativeIncrease
    Field type: integer

    Deprecated
    Returns null if no data is available
negativeRegularScore
    Field type: integer

    Deprecated
    Returns null if no data is available
negativeScore
    Field type: integer

    Deprecated
    Returns null if no data is available
onVentilatorCumulative
    Field type: integer

    Total number of people who have used a ventilator for COVID-19 so far, including those who have since recovered or died.
    Returns null if no data is available
onVentilatorCurrently
    Field type: integer

    Number of people using a ventilator for COVID-19 on this day.
    Returns null if no data is available
pending
    Field type: integer

    Number of tests whose results have yet to be determined.
    Returns null if no data is available
posNeg
    Field type: integer

    Deprecated
    Returns null if no data is available
positive
    Field type: integer

    Total number of people who have tested positive for COVID-19 so far.
    Returns null if no data is available
positiveIncrease
    Field type: integer

    Deprecated
    Returns null if no data is available
positiveScore
    Field type: integer

    Deprecated
    Returns null if no data is available
recovered
    Field type: integer

    Total number of people who have recovered from COVID-19 so far.
    Returns null if no data is available
score
    Field type: integer

    Deprecated
    Returns null if no data is available
state
    Field type: string

    Two-letter code for the state.
total
    Field type: integer

    Deprecated
    Returns null if no data is available
totalTestResults
    Field type: integer

    Deprecated
    Returns null if no data is available
totalTestResultsIncrease
    Field type: integer

    Deprecated
    Returns null if no data is available
    
    #>



