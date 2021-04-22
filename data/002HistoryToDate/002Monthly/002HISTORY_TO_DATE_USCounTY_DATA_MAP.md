HISTORICAL US COUNTY DATA

Description:  All US county daily case and death totals to date.  Sourced from the NY times github site at  
https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv and yearly US Census data 
at https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/.

CSV format only.  Data is partitioned by months to accommodate GITHUB 25 MB limit per file.    Files located at:
https://github.com/dkeeshin/covid19datavault/tree/master/data/002HistoryToDate/002Monthly . File name format
reflects the year and month daily data is part of.  Date format is Year-Month (YYYYMM).  For example the file name for April 2021 data is:

002MonthlyUSCounTY202104.csv

Note:  Only data for the current year-month is updated daily.  All previous months need loading only once. Use this data to initialize a new database and bring reporting tables up to date.  After that “fetch” the current daily data totals from the 001Daily directory.


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
