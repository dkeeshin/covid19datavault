COVID19DataVault
Data Dictionary for CSV and JSON Files.
2021-04-21

DAILY US COUNTY DATA

Description:  Most current daily US county case and death totals sourced from the NY times github site located at https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv and yearly US Census data. (web site). Two files generated daily. One CSV the other JSON. Files located at: 

https://github.com/dkeeshin/covid19datavault/tree/master/data/001Daily/001DailyUSCounTY.csv
https://github.com/dkeeshin/covid19datavault/tree/master/data/001Daily/001DailyUSCounTY.json


| ColumnName | Description |
| ---------- | ----------- |
| MonitorDate | Monitor date is the date data was processed by KDS. |
| CounTYName | County name, spelling checked and updated by kDSStateName  Name of state county is located. |
| Region | Region of the US per US Census data, assigned by kDS |
| SubRegion | SubRegion of the US per US Census data, assigned by kDS |
| FIPS | FIPS number |
| Latitude | Latitude per US Cesnsus data, assigned by kDS |
| Longitude | Longitude per US Cesnsus, assigned by kDS |
| PeriodToDateCaseCount | History to Date Total case count |
| PeriodToDateDeathCount | History to Date Total death count |
| PreviousPeriodToDateCaseCount | Previous monitor date case count maintained by kDS |
| PreviousPeriodToDateDeathCount | Previous monitor date death count, maintained by kDS |
| PreviousPeriodToDate | Previous monitor date used for detecting gaps |
| PopulationYear | Most current US Census population year |
| Population | County population per US Census |
| Source | kDS source identifier, 'NYTIMES-USCENSUS' |
