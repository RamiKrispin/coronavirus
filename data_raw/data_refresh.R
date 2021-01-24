#----------------------------------------------------
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
data_refresh <- function(){
  `%>%` <- magrittr::`%>%`

  # Confirmed cases ----
  raw_conf <- NULL
  url_conf <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

  raw_conf <- readr::read_csv(file = url_conf)


  if(is.null(raw_conf)){
    stop("Could not pull the confirmed raw data")
  }

  conf_df <- raw_conf %>% tidyr::pivot_longer(c(-"Province/State",
                                                -"Country/Region",
                                                -"Lat",
                                                -"Long" ),
                                              names_to = "date_temp",
                                              values_to = "cases_agg") %>%
    dplyr::mutate(date = lubridate::mdy(date_temp),
                  type = "confirmed",
                  province = trimws(`Province/State`),
                  country = trimws(`Country/Region`)) %>%
    dplyr::select(date,
                  province,
                  country,
                  lat = Lat,
                  long = Long,
                  type,
                  cases_agg) %>%
    as.data.frame()


  if(ncol(conf_df) != 7 || nrow(conf_df) < 100000){
    stop("The dimensions of the conf_df table is not valid")
  }



  conf_df2 <- conf_df %>% dplyr::group_by(province, country) %>%
    dplyr::arrange(date) %>%
    dplyr::mutate(cases_agg_lag = dplyr::lag(cases_agg, 1, default = 0)) %>%
    dplyr::mutate(cases = cases_agg - cases_agg_lag) %>%
    dplyr::select(date,
                  province,
                  country,
                  lat,
                  long,
                  type,
                  cases) %>%
    as.data.frame()

  if(ncol(conf_df2) != 7 || nrow(conf_df2) < 100000){
    stop("The dimensions of the conf_df table is not valid")
  }

  # Death cases ----
  raw_death <- NULL
  url_death <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
  raw_death <- readr::read_csv(file = url_death)

  if(is.null(raw_death)){
    stop("Could not pull the death raw data")
  }


  death_df <- raw_death %>% tidyr::pivot_longer(c(-"Province/State",
                                                  -"Country/Region",
                                                  -"Lat",
                                                  -"Long" ),
                                                names_to = "date_temp",
                                                values_to = "cases_agg") %>%
    dplyr::mutate(date = lubridate::mdy(date_temp),
                  type = "death",
                  province = trimws(`Province/State`),
                  country = trimws(`Country/Region`)) %>%
    dplyr::select(date,
                  province,
                  country,
                  lat = Lat,
                  long = Long,
                  type,
                  cases_agg) %>%
    as.data.frame()

  if(ncol(death_df) != 7 || nrow(death_df) < 100000){
    stop("The dimensions of the death_df table is not valid")
  }

  death_df2 <- death_df %>% dplyr::group_by(province, country) %>%
    dplyr::arrange(date) %>%
    dplyr::mutate(cases_agg_lag = dplyr::lag(cases_agg, 1, default = 0)) %>%
    dplyr::mutate(cases = cases_agg - cases_agg_lag) %>%
    dplyr::select(date,
                  province,
                  country,
                  lat,
                  long,
                  type,
                  cases) %>%
    as.data.frame()
  head(death_df2)


  if(ncol(death_df2) != 7 || nrow(death_df2) < 100000){
    stop("The dimensions of the death_df2 table is not valid")
  }
  # Recovered cases
  raw_rec <- NULL
  url_rec <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"
  raw_rec <- readr::read_csv(file = url_rec)

  if(is.null(raw_rec)){
    stop("Could not pull the recovery raw data")
  }

  rec_df <- raw_rec %>% tidyr::pivot_longer(c(-"Province/State",
                                              -"Country/Region",
                                              -"Lat",
                                              -"Long" ),
                                            names_to = "date_temp",
                                            values_to = "cases_agg") %>%
    dplyr::mutate(date = lubridate::mdy(date_temp),
                  type = "recovered",
                  province = trimws(`Province/State`),
                  country = trimws(`Country/Region`)) %>%
    dplyr::select(date,
                  province,
                  country,
                  lat = Lat,
                  long = Long,
                  type,
                  cases_agg) %>%
    as.data.frame()
  if(ncol(rec_df) != 7 || nrow(rec_df) < 94000){
    stop("The dimensions of the rec_df table is not valid")
  }
  # Fixing US recovery data
  # Replacing 0 after Dec with max number of cum cases
  us_cum_recovery <- (rec_df %>% dplyr::filter(country == "US"))$cases %>% max

  rec_df$cases_agg <- ifelse(rec_df$country == "US" &
                               rec_df$date > as.Date("2020-12-10") &
                               rec_df$cases == 0,us_cum_recovery, rec_df$cases_agg)
  rec_df2 <- rec_df %>% dplyr::group_by(province, country) %>%
    dplyr::arrange(date) %>%
    dplyr::mutate(cases_agg_lag = dplyr::lag(cases_agg, 1, default = 0)) %>%
    dplyr::mutate(cases = cases_agg - cases_agg_lag) %>%
    dplyr::select(date,
                  province,
                  country,
                  lat,
                  long,
                  type,
                  cases) %>%
    as.data.frame()
  head(rec_df2)

  if(ncol(rec_df2) != 7 || nrow(rec_df2) < 94000){
    stop("The dimensions of the rec_df2 table is not valid")
  }
  coronavirus <- dplyr::bind_rows(conf_df2, death_df2, rec_df2) %>%
    as.data.frame()

  coronavirus$province <- ifelse(is.na(coronavirus$province), "",
                                 coronavirus$province)
  #---------------- Data validation ----------------
  if(ncol(coronavirus) != 7){
    stop("The number of columns is invalid")
  } else if(nrow(coronavirus)< 295000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(coronavirus$date) != as.Date("2020-01-22")){
    stop("The starting date is invalid")
  }

  git_df_url <- "https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv"

  git_df <- readr::read_csv(file = git_df_url)

  if(ncol(git_df) != 7){
    stop("The number of columns is invalid")
  } else if(nrow(git_df)< 295000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(git_df$date) != as.Date("2020-01-22")){
    stop("The starting date is invalid")
  }

  if(nrow(coronavirus) > nrow(git_df)){
    print("Updates available")
    usethis::use_data(coronavirus, overwrite = TRUE, compress = "xz")
    write.csv(coronavirus, "csv/coronavirus.csv", row.names = FALSE)
    print("The coronavirus dataset was updated")
  } else {
    print("Updates are not available")
  }

  return(print("Done..."))
}

data_refresh()
