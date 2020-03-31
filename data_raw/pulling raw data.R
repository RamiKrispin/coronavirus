#----------------------------------------------------
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
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
# Fixing US data
# Aggregating county level to state level

# raw_us_conf <- raw_conf %>%
#   dplyr::filter(Country.Region == "US") %>%
#   dplyr::mutate(state = ifelse(!grepl(",", Province.State),
#                                Province.State,
#                                trimws(substr(Province.State,
#                                              regexpr(",", Province.State) + 1,
#                                              regexpr(",", Province.State) + 3)))) %>%
#   dplyr::left_join(data.frame(state = state.abb,
#                               state_name = state.name,
#                               stringsAsFactors = FALSE),
#                    by = "state") %>%
#   dplyr::mutate(state_name = ifelse(is.na(state_name), state, state_name)) %>%
#   dplyr::mutate(state_name = ifelse(state_name == "D.", "Washington, D.C.", state_name)) %>%
#   dplyr::mutate(Province.State = state_name) %>%
#   dplyr::select(-state, -state_name)
#
# raw_us_map <- raw_us_conf %>%
#   dplyr::select("Province.State","Country.Region", "Lat", "Long") %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(dup = duplicated(Province.State)) %>%
#   dplyr::filter(dup == FALSE) %>%
#   dplyr::select(-dup)
#
# us_agg_conf <- aggregate(x = raw_us_conf[, 5:(ncol(raw_us_conf))], by = list(raw_us_conf$Province.State), FUN = sum) %>%
#   dplyr::select(Province.State = Group.1, dplyr::everything())
#
# us_fix_conf <- raw_us_map %>% dplyr::left_join(us_agg_conf, by = "Province.State")
#
#
# raw_conf1 <- raw_conf %>%
#   dplyr::filter(Country.Region != "US") %>%
#   dplyr::bind_rows(us_fix_conf)



# Transforming the data from wide to long
# Creating new data frame
df_conf <- raw_conf[, 1:4]

for(i in 5:ncol(raw_conf)){

  raw_conf[,i] <- as.integer(raw_conf[,i])
  # raw_conf[,i] <- ifelse(is.na(raw_conf[, i]), 0 , raw_conf[, i])
    print(names(raw_conf)[i])

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
# # Fixing US data
# # Aggregating county level to state level
#
# raw_us_death <- raw_death %>%
#   dplyr::filter(Country.Region == "US") %>%
#   dplyr::mutate(state = ifelse(!grepl(",", Province.State),
#                                Province.State,
#                                trimws(substr(Province.State,
#                                              regexpr(",", Province.State) + 1,
#                                              regexpr(",", Province.State) + 3)))) %>%
#   dplyr::left_join(data.frame(state = state.abb,
#                               state_name = state.name,
#                               stringsAsFactors = FALSE),
#                    by = "state") %>%
#   dplyr::mutate(state_name = ifelse(is.na(state_name), state, state_name)) %>%
#   dplyr::mutate(state_name = ifelse(state_name == "D.", "Washington, D.C.", state_name)) %>%
#   dplyr::mutate(Province.State = state_name) %>%
#   dplyr::select(-state, -state_name)
#
# # raw_us_map <- raw_us_death %>%
# #   dplyr::select("Province.State","Country.Region", "Lat", "Long") %>%
# #   dplyr::distinct() %>%
# #   dplyr::mutate(dup = duplicated(Province.State)) %>%
# #   dplyr::filter(dup == FALSE) %>%
# #   dplyr::select(-dup)
#
# us_agg_death <- aggregate(x = raw_us_death[, 5:(ncol(raw_us_death))], by = list(raw_us_death$Province.State), FUN = sum) %>%
#   dplyr::select(Province.State = Group.1, dplyr::everything())
#
# us_fix_death <- raw_us_map %>% dplyr::left_join(us_agg_death, by = "Province.State")
#
#
# raw_death1 <- raw_death %>%
#   dplyr::filter(Country.Region != "US") %>%
#   dplyr::bind_rows(us_fix_death)





# Transforming the data from wide to long
# Creating new data frame
df_death <- raw_death[, 1:4]

for(i in 5:ncol(raw_death)){
  print(i)
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
# # Fixing US data
# # Aggregating county level to state level
#
# raw_us_rec <- raw_rec %>%
#   dplyr::filter(Country.Region == "US") %>%
#   dplyr::mutate(state = ifelse(!grepl(",", Province.State),
#                                Province.State,
#                                trimws(substr(Province.State,
#                                              regexpr(",", Province.State) + 1,
#                                              regexpr(",", Province.State) + 3)))) %>%
#   dplyr::left_join(data.frame(state = state.abb,
#                               state_name = state.name,
#                               stringsAsFactors = FALSE),
#                    by = "state") %>%
#   dplyr::mutate(state_name = ifelse(is.na(state_name), state, state_name)) %>%
#   dplyr::mutate(state_name = ifelse(state_name == "D.", "Washington, D.C.", state_name)) %>%
#   dplyr::mutate(Province.State = state_name) %>%
#   dplyr::select(-state, -state_name)
#
# raw_us_map <- raw_us_rec %>%
#   dplyr::select("Province.State","Country.Region", "Lat", "Long") %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(dup = duplicated(Province.State)) %>%
#   dplyr::filter(dup == FALSE) %>%
#   dplyr::select(-dup)
#
# us_agg_rec <- aggregate(x = raw_us_rec[, 5:(ncol(raw_us_rec))], by = list(raw_us_rec$Province.State), FUN = sum) %>%
#   dplyr::select(Province.State = Group.1, dplyr::everything())
#
# us_fix_rec <- raw_us_map %>% dplyr::left_join(us_agg_rec, by = "Province.State")
#
#
# raw_rec1 <- raw_rec %>%
#   dplyr::filter(Country.Region != "US") %>%
#   dplyr::bind_rows(us_fix_rec)




# Transforming the data from wide to long
# Creating new data frame
df_rec <- raw_rec[, 1:4]

for(i in 5:ncol(raw_rec)){
  print(i)
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

#
coronavirus <- dplyr::bind_rows(df_conf2, df_death2, df_rec2) %>%
  as.data.frame()



head(coronavirus)
tail(coronavirus)


usethis::use_data(coronavirus, overwrite = TRUE, compress = "gzip")

write.csv(coronavirus, "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.csv", row.names = FALSE)
writexl::write_xlsx(x = coronavirus, path = "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.xlsx", col_names = TRUE)


system(command = "R CMD INSTALL --no-multiarch --with-keep.source /Users/ramikrispin/R/packages/coronavirus")

.rs.restartR()
