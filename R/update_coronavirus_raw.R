#' update_coronavirus_raw
#' @export
#' @param debug Should we print out the head of datasets as they are downloaded or other debug
#' information? Defaults to `FALSE`.
#' @param returnclass Return
#'
#' @description  Update the data using the daily summary of the Coronavirus (COVID-19) cases by
#' state/province. Note, this function pulls from the raw archive. The data has not been
#' QC-ed yet on our end, and as such might have some innaaccuracies in it, such as duplicated
#' records, negative values, or other issues that we have noticed in the past. Please file issues
#' at the data source - https://github.com/CSSEGISandData/COVID-19/ - and you can give us a heads
#' up at https://github.com/RamiKrispin/coronavirus/issues as we will be pulling it soon.
#'
#' Spatial information (borders, etc.) are from \link[rnaturalearth]{rnaturalearth}. `sf` objects
#' can be easily merged with other data from \link[coronavirus]{coronavirus} using \link[sf]{st_join}.
#' @return An updated tbl or sf object for the coronavirus dataset.
#' @source Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#' @source The \link[rnaturalearth]{rnaturalearth}
#'
#' @examples
#'\dontrun{
#' coronavirus <- update_coronavirus_raw()
#' }

#----------------------------------------------------
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
#----------------------------------------------------
# Setting functions
#----------------------------------------------------
# Pulling confirmed cases


update_coronavirus_raw <- function(debug=FALSE, returnclass = c("data.frame", "sf")){

`%>%` <- magrittr::`%>%`

  print("Reading confirmed...")
  raw_conf <-
    utils::read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv",
             stringsAsFactors = FALSE)

  # Fixing typo
  raw_conf$X2.6.20[which(raw_conf$Country.Region == "Japan")] <- 25


  # Transforming the data from wide to long
  # Creating new data frame
  df_conf <- raw_conf[, 1:4]

  for (i in 5:ncol(raw_conf)) {
    #print(i) #debug
    raw_conf[, i] <- as.integer(raw_conf[, i])
    raw_conf[, i] <- ifelse(is.na(raw_conf[, i]), 0 , raw_conf[, i])

    if (i == 5) {
      df_conf[[names(raw_conf)[i]]] <- raw_conf[, i]
    } else {
      df_conf[[names(raw_conf)[i]]] <- raw_conf[, i] - raw_conf[, i - 1]
    }
  }


  df_conf1 <-
    df_conf %>% tidyr::pivot_longer(
      cols = dplyr::starts_with("X"),
      names_to = "date_temp",
      values_to = "cases_temp"
    )

  # Parsing the date
  df_conf1$month <- sub("X",
                        "",
                        strsplit(df_conf1$date_temp, split = "\\.") %>%
                          purrr::map_chr( ~ .x[1]))

  df_conf1$day <- strsplit(df_conf1$date_temp, split = "\\.") %>%
    purrr::map_chr( ~ .x[2])


  df_conf1$date <-
    as.Date(paste("2020", df_conf1$month, df_conf1$day, sep = "-"))

  # Aggregate the data to daily
  df_conf2 <- df_conf1 %>%
    dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
    dplyr::summarise(cases = sum(cases_temp)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      type = "confirmed",
      Country.Region = trimws(Country.Region),
      Province.State = trimws(Province.State)
    )

  if(debug){
    print(utils::head(df_conf2))
    print(utils::tail(df_conf2))
  }

  #----------------------------------------------------
  # Pulling death cases
  print("Reading deaths...")

  raw_death <-
    utils::read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv",
             stringsAsFactors = FALSE)
  # Transforming the data from wide to long
  # Creating new data frame
  df_death <- raw_death[, 1:4]

  for (i in 5:ncol(raw_death)) {
    #print(i) #debug
    raw_death[, i] <- as.integer(raw_death[, i])
    raw_death[, i] <-
      ifelse(is.na(raw_death[, i]), 0 , raw_death[, i])

    if (i == 5) {
      df_death[[names(raw_death)[i]]] <- raw_death[, i]
    } else {
      df_death[[names(raw_death)[i]]] <-
        raw_death[, i] - raw_death[, i - 1]
    }
  }


  df_death1 <-
    df_death %>% tidyr::pivot_longer(
      cols = dplyr::starts_with("X"),
      names_to = "date_temp",
      values_to = "cases_temp"
    )

  # Parsing the date
  df_death1$month <- sub("X",
                         "",
                         strsplit(df_death1$date_temp, split = "\\.") %>%
                           purrr::map_chr( ~ .x[1]))

  df_death1$day <- strsplit(df_death1$date_temp, split = "\\.") %>%
    purrr::map_chr( ~ .x[2])


  df_death1$date <-
    as.Date(paste("2020", df_death1$month, df_death1$day, sep = "-"))

  # Aggregate the data to daily
  df_death2 <- df_death1 %>%
    dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
    dplyr::summarise(cases = sum(cases_temp)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      type = "death",
      Country.Region = trimws(Country.Region),
      Province.State = trimws(Province.State)
    )

  if(debug){
    print(utils::head(df_death2))
    print(utils::tail(df_death2))
  }
  #----------------------------------------------------
  # Pulling recovered cases
  print("Reading recovery...")

  raw_rec <-
    utils::read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv",
             stringsAsFactors = FALSE)
  # Transforming the data from wide to long
  # Creating new data frame
  df_rec <- raw_rec[, 1:4]

  for (i in 5:ncol(raw_rec)) {
    #print(i) #debug
    raw_rec[, i] <- as.integer(raw_rec[, i])
    raw_rec[, i] <- ifelse(is.na(raw_rec[, i]), 0 , raw_rec[, i])

    if (i == 5) {
      df_rec[[names(raw_rec)[i]]] <- raw_rec[, i]
    } else {
      df_rec[[names(raw_rec)[i]]] <- raw_rec[, i] - raw_rec[, i - 1]
    }
  }


  df_rec1 <-
    df_rec %>% tidyr::pivot_longer(
      cols = dplyr::starts_with("X"),
      names_to = "date_temp",
      values_to = "cases_temp"
    )

  # Parsing the date
  df_rec1$month <- sub("X",
                       "",
                       strsplit(df_rec1$date_temp, split = "\\.") %>%
                         purrr::map_chr( ~ .x[1]))

  df_rec1$day <- strsplit(df_rec1$date_temp, split = "\\.") %>%
    purrr::map_chr( ~ .x[2])


  df_rec1$date <-
    as.Date(paste("2020", df_rec1$month, df_rec1$day, sep = "-"))

  # Aggregate the data to daily
  df_rec2 <- df_rec1 %>%
    dplyr::group_by(Province.State, Country.Region, Lat, Long, date) %>%
    dplyr::summarise(cases = sum(cases_temp)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      type = "recovered",
      Country.Region = trimws(Country.Region),
      Province.State = trimws(Province.State)
    )

  if(debug){
    print(utils::head(df_rec2))
    print(utils::tail(df_rec2))
  }

  coronavirus <- dplyr::bind_rows(df_conf2, df_death2, df_rec2) %>%
    dplyr::arrange(date) %>% dplyr::ungroup() %>%
    dplyr::filter(cases != 0)



  #use spatial info to make better Province.State and Country.Region
  states_of_the_world <- coronavirus::states_of_the_world
  coronavirus_sf <- sf::st_as_sf(coronavirus, coords = c(x = "Long", y = "Lat"), remove = FALSE,
                                 crs = sf::st_crs(states_of_the_world)) %>%
    sf::st_join(states_of_the_world) %>%
    #some data is not actually at the state level
    dplyr::mutate(name = ifelse(Province.State=="" | is.na(Province.State), NA, name),
                  Region.Type = ifelse(Province.State=="" | is.na(Province.State), NA,  Region.Type),
                  admin = ifelse(is.na(admin), Country.Region, admin),#not sure why this is happening...
                  admin = ifelse(admin =="US", "United States of America", admin) #fix for NA countries that are the US
    ) %>%
    dplyr::rename(JHU.Province.State = Province.State,
           JHU.Country.Region = Country.Region) %>%
    #make it have the same names and similar cols to previous versions
    dplyr::select(name, admin, Region.Type, iso_3166_2, JHU.Province.State, JHU.Country.Region, Lat, Long, date, cases, type) %>%
    dplyr::rename(Province.State = name, Country.Region = admin)

  #if they want the data in a spatial form
  if(returnclass == "sf") return(coronavirus_sf)

  #otherwise, return the data frame without a geometry column
  coronavirus <- as.data.frame(coronavirus_sf) %>%
    dplyr::select(-geometry)


  coronavirus
}



