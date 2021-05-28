# coronavirus 0.3.22

* Fixed issue with the data parsing - replacing `read.csv` with `read_csv`
* Data is up-to-date till May 26th, 2021

# coronavirus 0.3.21

* Fixed issue with the data refresh function - replacing NA on `province` column as empty strings ("")

# coronavirus 0.3.2

* Data is up-to-date up to Jan 22th 2021
* Fixed issue with the data format and refresh function

# coronavirus 0.3.1

* Data is up-to-date up to Jan 9th 2021
* Added docker framework for the package dashboard 
* Updated the data refresh function and docker image
* Fixed CRAN warnings

# coronavirus 0.3.0

* Added the `refresh_coronavirus_jhu` function for pulling the `coronavirus` dataset using the covid19R project format
* Created docker image for development environment and cron job, more info available [here](https://github.com/RamiKrispin/coronavirus/tree/master/docker)
* Updated the `update_dataset` function


# coronavirus 0.2.0

* Data changes:
  - `coronavirus` dataset - Change the structure of the US data from March 23rd 2020 and forward. The US data is now available on an agregated level. More information about the changes on the raw data available on this [issue](https://github.com/CSSEGISandData/COVID-19/issues/1250)
  - Changes in the columns names and order:
      - `Province.State` changed to `province`
      - `Country.Region` changed to `country`
      - `Lat` changed to `lat`
      - `Long` changed to `long`
  - The `covid_south_korea` and `covid_iran` that were avialble on the dev version were removed from the package and moved to new package [covid19wiki](https://github.com/RamiKrispin/covid19wiki), for now available only on Github 
  
* Function:
  - `update_dataset` - enable to update the installed version with new data that available on the [Github version](https://github.com/RamiKrispin/coronavirus)
* Data refresh - the [Github version](https://github.com/RamiKrispin/coronavirus) is now updated on a daily basis with a cron job
  

# coronavirus 0.1.0

* Data updated up to Feb 13, 2020
* Added a `NEWS.md` file to track changes to the package.
