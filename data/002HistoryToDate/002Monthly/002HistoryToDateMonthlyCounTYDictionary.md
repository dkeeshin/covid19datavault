HISTORICAL US COUNTY DATA

Description:  All US county daily case and death totals to date.  Sourced from the NY times github site located at https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv and yearly US Census data. (web site).  CSV format only. Data is partitioned by months to accommodate GITHUB 25 MB limit per file. Files located at:
https://github.com/dkeeshin/covid19datavault/tree/master/data/002HistoryToDate/002Monthly

Note: only the current year-month data is updated nightly.  All previous months need to be loaded only once.
Filenames reflect the year and month daily data is part of.  Date format is Year-Month (YYYYMM). Sample file name and format:

002MonthlyUSCounTY202001.csv

Use Case: Use this data to initialize a new database and bring reporting tables up to date.  After that fetch the current daily data totals.


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
