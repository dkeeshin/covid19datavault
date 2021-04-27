__COVID19DataVault__
__Data Map for CSV and JSON Files__
__2021-04-22__

__DAILY US COUNTY DATA__

Description:  Data to date US county case and death totals sourced from the NY times github site located at https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv and yearly US Census data at  https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/. Files are partitioned by month.  Current month contains month to date totals updated nightly. 

https://github.com/dkeeshin/covid19datavault/tree/master/data/002HistoryToDate/002MonthlyUSCounTY


| ColumnName | Description |
| ---------- | ----------- |
| monitor_date | Monitor date is the date data was processed by KDS. |
| county | County name, spelling checked and updated by kDS |  
| state_name| Name of state county is located. |
| region | Region of the US per US Census data, assigned by kDS |
| subregion | SubRegion of the US per US Census data, assigned by kDS |
| fips | FIPS number |
| latitude | Latitude per US Cesnsus data, assigned by kDS |
| longitude | Longitude per US Cesnsus, assigned by kDS |
| case_count_to_date | History to Date Total case count |
| death_count_to_date | History to Date Total death count |
| previous_case_count_to_date | Previous monitor date case count maintained by kDS |
| previous_death_count_to_date | Previous monitor date death count, maintained by kDS |
| previous_monitor_date | Previous monitor date used for detecting gaps |
| population_year | Most current US Census population year |
| population | County population per US Census |
| source | kDS source identifier, 'NYTIMES-USCENSUS' |