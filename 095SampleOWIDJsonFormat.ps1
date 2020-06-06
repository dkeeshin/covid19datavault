##sample JSON reading of recommended OWID Covid19 Country file JSON format
##dkeeshin@keeshinds,com

$request = 'https://raw.githubusercontent.com/dkeeshin/covid19datavault/master/OWIDSampleCountry.json'
$jsonFromTheWeb = Invoke-WebRequest $request

CLS

$j = $jsonFromTheWeb|ConvertFrom-Json
$dateToFind = "2020-06-03"


 foreach ($f in $j ) { 
      if ($f.date -eq $dateToFind ) {$f|ConvertTo-Json } 
            }




