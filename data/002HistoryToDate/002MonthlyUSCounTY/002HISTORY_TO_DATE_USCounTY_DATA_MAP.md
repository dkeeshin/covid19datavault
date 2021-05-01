__COVID19DataVault__
__Data Map for CSV and JSON Files__
__2021-04-29__

__US COUNTY DATA TO DATE__

Description:  Data to date US county case and death totals sourced from the NY times github site located at https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv and yearly US Census data at  https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/. 

kDS version of this data is stored in CSV files partitioned by month. Current year-month file is updated nightly. No changes are made to previous months.  Additionally,  the data is enhanced.  County names are checked against the US Census version of the name.  The kDS process assigns latitude and longitude to FIPS numbers per the US Census data.  The process also assigns region, subregions and county populations per US Census data. 

Also, case_count_to_date and previous_case_count_to_date are tallies of the inception to date totals. The NYTIMES data does not provide a daily change number.  The only way to find the daily case count is to subtract the previous_case_count_to_date total from the case_count_to_date total.  Same holds true for the previous_death_count_to_date and death_count_to_date. kDS version of the files are located here:

https://github.com/dkeeshin/covid19datavault/tree/master/data/002HistoryToDate/002MonthlyUSCounTY

You can tell what each year-month file contains by the year-month combination at the end of the file name.  For example,  the file for April 2021 the file name looks like this: 

002MonthlyUSCounTY202104.csv

Also, we treat the number of cases and the deaths per day as a pair. If either are blank on a given day,  we treat the data as 'missing' and remove it.  


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