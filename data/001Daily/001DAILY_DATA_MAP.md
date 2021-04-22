__COVID19DataVault__
__Data Map for CSV and JSON Files__
__2021-04-22__

__DAILY US COUNTY DATA__

Description:  Most current daily US county case and death totals sourced from the NY times github site located at https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv and yearly US Census data at  https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/totals/. Two files generated daily. One CSV the other JSON. Files located at

https://github.com/dkeeshin/covid19datavault/tree/master/data/001Daily/001DailyUSCounTY.csv
https://github.com/dkeeshin/covid19datavault/tree/master/data/001Daily/001DailyUSCounTY.json


| ColumnName | Description |
| ---------- | ----------- |
| MonitorDate | Monitor date is the date data was processed by KDS. |
| CounTYName | County name, spelling checked and updated by kDS |  
| StateName| Name of state county is located. |
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

__DAILY COUNTRY DATA__

Description:  Most current case and death counts to date sourced from the Our World In Data at  https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv
CSV format. File located at: 

https://raw.githubusercontent.com/dkeeshin/covid19datavault/master/data/002HistoryToDate/004HistoryToDateCountryVaccination.csv

| ColumnName | Description |
| ---------- | ----------- |
| MonitorDate | Monitor date is the date data was processed by KDS. |
| Country | Country name, spelling checked and updated by kDSStateName|
| CaseCount | Number of daily cases |
| DeathCount | Number of daily deaths  |
| PeriodToDateCaseCount | History to Date Total case count |
| PeriodToDateDeathCount | History to Date Total death count |
| PreviousPeriodToDateCaseCount | Previous monitor date case count maintained by kDS |
| Population | County population|
| CountryCode | Three letter Iso Code|
| Source | https://covid.ourworldindata.org/data/ecdc/full_data.csv |

__DAILY COUNTRY VACCINATION DATA__

Description:  Most current vaccination data to date sourced from the Our World In Data at  https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv 
CSV format. File located at: 

https://raw.githubusercontent.com/dkeeshin/covid19datavault/master/data/002HistoryToDate/004HistoryToDateCountryVaccination.csv

| ColumnName | Description |
| ---------- | ----------- |
| CollectionDate | date data was collected, assigned by kDS|
| location |  name of the country (or region within a country). |
| iso_code |  ISO 3166-1 alpha-3 – three-letter country codes. |
| date |  date of the observation. |
| total_vaccinations |  total number of doses administered. This is counted as a single dose, and may not equal the total number of people vaccinated, depending on the specific dose regime (e.g. people receive multiple doses). If a person receives one dose of the vaccine, this metric goes up by 1. If they receive a second dose, it goes up by 1 again. |
| total_vaccinations_per_hundred |  total_vaccinations per 100 people in the total population of the country. |
|  daily_vaccinations_raw |  daily change in the total number of doses administered. It is only calculated for consecutive days. This is a raw measure provided for data checks and transparency, but we strongly recommend that any analysis on daily vaccination rates be conducted using daily_vaccinations instead. |
| daily_vaccinations |  new doses administered per day (7-day smoothed). For countries that don't report data on a daily basis, we assume that doses changed equally on a daily basis over any periods in which no data was reported. This produces a complete series of daily figures, which is then averaged over a rolling 7-day window. An example of how we perform this calculation can be found here. |
| daily_vaccinations_per_million |  daily_vaccinations per 1,000,000 people in the total population of the country. |
| people_vaccinated |  total number of people who received at least one vaccine dose. If a person receives the first dose of a 2-dose vaccine, this metric goes up by 1. If they receive the second dose, the metric stays the same. |
| people_vaccinated_per_hundred |  people_vaccinated per 100 people in the total population of the country. |
| people_fully_vaccinated |  total number of people who received all doses prescribed by the vaccination protocol. If a person receives the first dose of a 2-dose vaccine, this metric stays the same. If they receive the second dose, the metric goes up by 1. |
| people_fully_vaccinated_per_hundred |  people_fully_vaccinated per 100 people in the total population of the country. |
| Source | https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv |


