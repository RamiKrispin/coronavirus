#------------------------------------------------------------------
# Pulling covid19 data for Italy by province
# Source: Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile
# Website: http://www.protezionecivile.it/
# Github repo: https://github.com/pcm-dpc
#------------------------------------------------------------------

# Loading the current version




italy_current <- coronavirus::covid_italy



df1 <- read.csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province.csv", stringsAsFactors = FALSE) %>%
  stats::setNames(c("date_temp", "state", "region_code", "region_name", "province_code",
                    "province_name", "province_abb", "lat", "long", "total_cases")) %>%
  dplyr::mutate(date = lubridate::ymd(substr(date_temp, 1, 10))) %>%
  dplyr::select(-date_temp) %>%
  dplyr::select(date, dplyr::everything()) %>%
  dplyr::arrange(date)

head(df1)


df2 <- df1 %>% dplyr::mutate(date = date + lubridate::days(1)) %>%
  dplyr::mutate(total_cases_lag = total_cases) %>%
  dplyr::select(-total_cases)

head(df1)
head(df2)

covid_italy <- df1 %>% dplyr::left_join(df2,
                                        by = c("date", "state",
                                               "region_code", "region_name",
                                               "province_code", "province_name",
                                               "province_abb",
                                               "lat", "long")) %>%
  dplyr::mutate(new_cases = total_cases - total_cases_lag)  %>%
  dplyr::select(-total_cases_lag) %>%
  dplyr::mutate(new_cases = ifelse(is.na(new_cases), total_cases, new_cases))



# Testing if there is a change in the data

if(identical(italy_current, covid_italy)){
  print("No updates available")
} else {
  if(ncol(italy_current) != ncol(covid_italy)){
    stop("The number of columns in the updated data is not maching the one in the current version")
  }

  if(nrow(italy_currnet) > nrow(covid_italy)){
    stop("The number of rows in the updated data is lower than the one in the current version")
  }

  if(min(italy_current$date) != min(covid_italy$date)){
    stop("The start date of the new dataset is not match the one in the current version")
  }



  # If not stop by one of the conditions above than
  # save and commit

  usethis::use_data(covid_italy, overwrite = TRUE)

  system(command = "bash ~/R/packages/coronavirus/data_raw/data_refresh.bs")

  .rs.restartR()



}








