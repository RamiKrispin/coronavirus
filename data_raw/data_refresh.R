# Info ----
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
data_refresh <- function(){

  # Functions ----
  `%>%` <- magrittr::`%>%`
  parse_url <- function(url, type){
    raw <- readr::read_csv(file = url) %>%
      as.data.frame()

    # Transforming the data from wide to long
    # Creating new data frame
    df <- raw[, 1:4]

    names(df) <- gsub(pattern= "/", replacement = ".", x = names(df))
    # Take diff
    for(i in 5:ncol(raw)){

      raw[,i] <- as.integer(raw[,i])

      if(i == 5){
        df[[names(raw)[i]]] <- raw[, i]
      } else {
        df[[names(raw)[i]]] <- raw[, i] - raw[, i - 1]
      }
    }

    df1 <-  df %>% tidyr::pivot_longer(cols = dplyr::starts_with(c("1", "2", "3", "4", "5", "6", "7", "8", "9")),
                                               names_to = "date_temp",
                                               values_to = "cases_temp") %>%
      dplyr::mutate(date = lubridate::mdy(date_temp)) %>%
      dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
      dplyr::summarise(cases = sum(cases_temp),
                       .groups = "drop") %>%
      dplyr::ungroup() %>%
      dplyr::mutate(type = type,
                    Country.Region = trimws(Country.Region),
                    Province.State = trimws(Province.State))

    if(type == "recovered"){
      df1$cases <- ifelse(df1$date > as.Date("2021-08-04") & df1$cases == 0, NA, df1$cases)
    }


    return(df1)
  }
  # Pulling confirmed cases ----
  conf_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
  conf_df <- parse_url(url = conf_url, type = "confirmed")
  # Pulling death cases ----
  death_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
  death_df <- parse_url(url = death_url, type = "death")
  # Pulling recovered cases ----
  rec_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"
  rec_df <- parse_url(url = rec_url, type = "recovered")
  # Append the data----
  coronavirus <- dplyr::bind_rows(conf_df, death_df, rec_df) %>%
    dplyr::select(date, province = Province.State, country = Country.Region, lat = Lat, long = Long, type, cases) %>%
    as.data.frame()
  #-Data validation ----
  if(ncol(coronavirus) != 7){
    stop("The number of columns is invalid")
  } else if(nrow(coronavirus)< 472600){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(coronavirus$date) != as.Date("2020-01-22")){
    stop("The starting date is invalid")
  }

  git_df <- readr::read_csv(file = "https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv")

  git_df$date <- as.Date(git_df$date)
  if(ncol(git_df) != 7){
    stop("The number of columns is invalid")
  } else if(nrow(git_df)< 472600){
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

  # write.csv(coronavirus, "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.csv", row.names = FALSE)
  # writexl::write_xlsx(x = coronavirus, path = "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.xlsx", col_names = TRUE)
  return(print("Done..."))

}

data_refresh()
