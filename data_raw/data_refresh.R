# Info ----
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
data_refresh <- function(env = "master"){

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
      df1$cases <- ifelse(df1$date > as.Date("2021-08-04") & df1$cases == 0 |
                            df1$date > as.Date("2021-08-04") & df1$cases < 0, NA, df1$cases)
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
  coronavirus_temp <- dplyr::bind_rows(conf_df, death_df, rec_df) %>%
    dplyr::select(date, province = Province.State, country = Country.Region, lat = Lat, long = Long, type, cases) %>%
    as.data.frame()
  # Merge gis codes ----
  load("./data_raw/gis_mapping.RData")

  gis_codes_coronavirues$iso2[which(gis_codes_coronavirues$country_region == "Namibia")] <- "NA"

  coronavirus <- coronavirus_temp %>%
    dplyr::left_join(gis_codes_coronavirues %>%
                       dplyr::select(-lat, - long) %>%
                       dplyr::select(province = province_state, country = country_region,
                                     dplyr::everything()),
                     by = c("province", "country")) %>%
    dplyr::left_join(continent_mapping %>%
                       dplyr::select(iso2, iso3, continent_name, continent_code),
                     by = c("iso2", "iso3")) %>%
    dplyr::mutate(continent_name = ifelse(country == "Kosovo", "Europe", continent_name),
                  continent_code = ifelse(country == "Kosovo", "EU", continent_code)) %>%
    dplyr::select(-admin2, -fips)


unique(coronavirus$continent_code)
unique(coronavirus$continent_name)
table(coronavirus$continent_name)
  #-Data validation ----
  if(ncol(coronavirus) != 15){
    stop("The number of columns is invalid")
  } else if(nrow(coronavirus) < 500000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(coronavirus$date) != as.Date("2020-01-22")){
    stop("The starting date is invalid")
  }

  git_df <- readr::read_csv(file = sprintf("https://raw.githubusercontent.com/RamiKrispin/coronavirus/%s/csv/coronavirus.csv", env),
                            col_types = readr::cols(date = readr::col_date(format = "%Y-%m-%d"),
                                                    cases = readr::col_number()))


  if(ncol(git_df) != 15){
    stop("The number of columns is invalid")
  } else if(nrow(git_df)< 500000){
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


data_refresh_vaccine <- function(url, env = "master"){
  `%>%` <- magrittr::`%>%`
  covid19_vaccine <- covid19_vaccine_temp <-  NULL

  tryCatch(
    covid19_vaccine_temp <- readr::read_csv(file = url,
                                       col_types = readr::cols(Date = readr::col_date(format = "%Y-%m-%d"),
                                                               Doses_admin = readr::col_number(),
                                                               People_partially_vaccinated = readr::col_number(),
                                                               People_fully_vaccinated = readr::col_number(),
                                                               Report_Date_String = readr::col_date(format = "%Y-%m-%d"),
                                                               UID = readr::col_number(),
                                                               Province_State = readr::col_character())) %>%
      as.data.frame(),
    error = function(c) base::message(c)
  )

  if(is.null(covid19_vaccine_temp)){
    stop("Could not pull the covid19_vaccine_temp dataset, check the error")
  } else if(nrow(covid19_vaccine_temp) < 57800 || ncol(covid19_vaccine_temp) != 8){
    stop("The dimensions of the covid19_vaccine_temp dataset are invalid")
  } else if(class(covid19_vaccine_temp$Date) != "Date"){
    stop("The class of the Date column is invalid")
  } else if(class(covid19_vaccine_temp$Report_Date_String) != "Date"){
    stop("The class of the Report_Date_String column is invalid")
  }

  names(covid19_vaccine_temp) <- tolower(names(covid19_vaccine_temp))

  load("./data_raw/gis_mapping.RData")

  covid19_vaccine_temp$uid <- ifelse(covid19_vaccine_temp$country_region == "Taiwan*" & is.na(covid19_vaccine_temp$uid),
                                     158,
                                     covid19_vaccine_temp$uid)

  covid19_vaccine <- covid19_vaccine_temp %>% dplyr::left_join(gis_code_mapping %>% dplyr::select(- country_region, - province_state),
                                                               by = c("uid")) %>%
    dplyr::select(-admin2) %>%
    dplyr::mutate(iso2 = ifelse(country_region == "Namibia", "NA", iso2)) %>%
    dplyr::left_join(continent_mapping %>% dplyr::select(-country_name),
                     by = c("uid", "iso2", "iso3"))



  # Check if there are duplication in the US data
  x <- covid19_vaccine %>% dplyr::filter(iso2 == "US")
  if(any(table(duplicated(x[, c( "date")]))) &&
     all(c("US", "US (Aggregate)") %in% unique(x$country_region))){
    covid19_vaccine <- covid19_vaccine %>%
      dplyr::filter(country_region != "US (Aggregate)")
  }




  git_df <- readr::read_csv(paste("https://raw.githubusercontent.com/RamiKrispin/coronavirus/",
                                  env,
                                  "/csv/covid19_vaccine.csv",
                                  sep = ""),
                            col_types = readr::cols(report_date_string = readr::col_date(format = "%Y-%m-%d"),
                                                    province_state = readr::col_character()))

  if(nrow(covid19_vaccine) > nrow(git_df)){
    cat("Updating the vaccine data...")
    usethis::use_data(covid19_vaccine, overwrite = TRUE, compress = "xz")
    write.csv(covid19_vaccine, "csv/covid19_vaccine.csv", row.names = FALSE)
  } else {
    cat("No updates available...")
  }

  return(print("Done..."))

}
