#----------------------------------------------------
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
data_refresh <- function(){
  #----------------------------------------------------
  # Setting functions
  `%>%` <- magrittr::`%>%`
  #----------------------------------------------------
  #------------ Pulling confirmed cases------------
  conf_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
  raw_conf <- read.csv(file = conf_url,
                       stringsAsFactors = FALSE)

  lapply(1:ncol(raw_conf), function(i){
    if(all(is.na(raw_conf[, i]))){
      raw_conf <<- raw_conf[, -i]
      return(print(paste("Column", names(raw_conf)[i], "is missing", sep = " ")))
    } else {
      return(NULL)
    }
  })


  # Transforming the data from wide to long
  # Creating new data frame
  df_conf <- raw_conf[, 1:4]

  for(i in 5:ncol(raw_conf)){

    raw_conf[,i] <- as.integer(raw_conf[,i])
    # raw_conf[,i] <- ifelse(is.na(raw_conf[, i]), 0 , raw_conf[, i])

    if(i == 5){
      df_conf[[names(raw_conf)[i]]] <- raw_conf[, i]
    } else {
      df_conf[[names(raw_conf)[i]]] <- raw_conf[, i] - raw_conf[, i - 1]
    }


  }


  df_conf1 <-  df_conf %>% tidyr::pivot_longer(cols = dplyr::starts_with("X"),
                                               names_to = "date_temp",
                                               values_to = "cases_temp")

  # Parsing the date
  df_conf1$month <- sub("X", "",
                        strsplit(df_conf1$date_temp, split = "\\.") %>%
                          purrr::map_chr(~.x[1]) )

  df_conf1$day <- strsplit(df_conf1$date_temp, split = "\\.") %>%
    purrr::map_chr(~.x[2])


  df_conf1$date <- as.Date(paste("2020", df_conf1$month, df_conf1$day, sep = "-"))

  # Aggregate the data to daily
  df_conf2 <- df_conf1 %>%
    dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
    dplyr::summarise(cases = sum(cases_temp)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(type = "confirmed",
                  Country.Region = trimws(Country.Region),
                  Province.State = trimws(Province.State))

  head(df_conf2)
  tail(df_conf2)
  #----------------------------------------------------
  # Pulling death cases

  death_url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
  raw_death <- read.csv(file =death_url,
                        stringsAsFactors = FALSE,
                        fill =FALSE)

  lapply(1:ncol(raw_death), function(i){
    if(all(is.na(raw_death[, i]))){
      raw_death <<- raw_death[, -i]
      return(print(paste("Column", names(raw_death)[i], "is missing", sep = " ")))
    } else {
      return(NULL)
    }
  })


  # Transforming the data from wide to long
  # Creating new data frame
  df_death <- raw_death[, 1:4]

  for(i in 5:ncol(raw_death)){
    raw_death[,i] <- as.integer(raw_death[,i])
    raw_death[,i] <- ifelse(is.na(raw_death[, i]), 0 , raw_death[, i])

    if(i == 5){
      df_death[[names(raw_death)[i]]] <- raw_death[, i]
    } else {
      df_death[[names(raw_death)[i]]] <- raw_death[, i] - raw_death[, i - 1]
    }
  }


  df_death1 <-  df_death %>% tidyr::pivot_longer(cols = dplyr::starts_with("X"),
                                                 names_to = "date_temp",
                                                 values_to = "cases_temp")

  # Parsing the date
  df_death1$month <- sub("X", "",
                         strsplit(df_death1$date_temp, split = "\\.") %>%
                           purrr::map_chr(~.x[1]) )

  df_death1$day <- strsplit(df_death1$date_temp, split = "\\.") %>%
    purrr::map_chr(~.x[2])


  df_death1$date <- as.Date(paste("2020", df_death1$month, df_death1$day, sep = "-"))

  # Aggregate the data to daily
  df_death2 <- df_death1 %>%
    dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
    dplyr::summarise(cases = sum(cases_temp)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(type = "death",
                  Country.Region = trimws(Country.Region),
                  Province.State = trimws(Province.State))

  head(df_death2)
  tail(df_death2)
  #----------------------------------------------------
  # Pulling recovered cases

  raw_rec <- read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv",
                      stringsAsFactors = FALSE,
                      fill =FALSE)

  lapply(1:ncol(raw_rec), function(i){
    if(all(is.na(raw_rec[, i]))){
      raw_rec <<- raw_rec[, -i]
      return(print(paste("Column", names(raw_rec)[i], "is missing", sep = " ")))
    } else {
      return(NULL)
    }
  })




  # Transforming the data from wide to long
  # Creating new data frame
  df_rec <- raw_rec[, 1:4]

  for(i in 5:ncol(raw_rec)){
    raw_rec[,i] <- as.integer(raw_rec[,i])
    raw_rec[,i] <- ifelse(is.na(raw_rec[, i]), 0 , raw_rec[, i])

    if(i == 5){
      df_rec[[names(raw_rec)[i]]] <- raw_rec[, i]
    } else {
      df_rec[[names(raw_rec)[i]]] <- raw_rec[, i] - raw_rec[, i - 1]
    }
  }


  df_rec1 <-  df_rec %>% tidyr::pivot_longer(cols = dplyr::starts_with("X"),
                                             names_to = "date_temp",
                                             values_to = "cases_temp")

  # Parsing the date
  df_rec1$month <- sub("X", "",
                       strsplit(df_rec1$date_temp, split = "\\.") %>%
                         purrr::map_chr(~.x[1]) )

  df_rec1$day <- strsplit(df_rec1$date_temp, split = "\\.") %>%
    purrr::map_chr(~.x[2])


  df_rec1$date <- as.Date(paste("2020", df_rec1$month, df_rec1$day, sep = "-"))

  # Aggregate the data to daily
  df_rec2 <- df_rec1 %>%
    dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
    dplyr::summarise(cases = sum(cases_temp)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(type = "recovered",
                  Country.Region = trimws(Country.Region),
                  Province.State = trimws(Province.State))

  head(df_rec2)
  tail(df_rec2)
  #---------------- Aggregate all cases ----------------
  coronavirus <- dplyr::bind_rows(df_conf2, df_death2, df_rec2) %>%
    as.data.frame()
  #---------------- Data validation ----------------
  if(ncol(coronavirus) != 7){
    stop("The number of columns is invalid")
  } else if(nrow(coronavirus)< 69000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(coronavirus$date) != as.Date("2020-01-22")){
    stop("The starting date is invalid")
  }

  git_df <- read.csv("https://raw.githubusercontent.com/Covid19R/coronavirus/master/csv/coronavirus.csv", stringsAsFactors = FALSE)

  git_df$date <- as.Date(git_df$date)
  if(ncol(git_df) != 7){
    stop("The number of columns is invalid")
  } else if(nrow(git_df)< 69000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(git_df$date) != as.Date("2020-01-22")){
    stop("The starting date is invalid")
  }

  if(nrow(coronavirus) > nrow(git_df)){
    print("Updates available")
    usethis::use_data(coronavirus, overwrite = TRUE, compress = "gzip")
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


