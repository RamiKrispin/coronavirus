#----------------------------------------------------
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
#----------------------------------------------------
# Setting functions
`%>%` <- magrittr::`%>%`
#----------------------------------------------------
# Pulling confirmed cases

raw_conf <- read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv",
                     stringsAsFactors = FALSE,
                     fill =FALSE)

# Fixing typo
raw_conf$X2.6.20[which(raw_conf$Country.Region == "Japan")] <- 25

#Handling missing data from last day of the data
# If missing value, will use the value of the previous day as input
raw_conf[, ncol(raw_conf)] <- ifelse(is.na(raw_conf[, ncol(raw_conf)]), raw_conf[, ncol(raw_conf) - 1], raw_conf[, ncol(raw_conf)])


# Transforming the data from wide to long
# Creating new data frame
df_conf <- raw_conf[, 1:4]

for(i in 5:ncol(raw_conf)){
  print(i)
  raw_conf[,i] <- as.integer(raw_conf[,i])
  raw_conf[,i] <- ifelse(is.na(raw_conf[, i]), 0 , raw_conf[, i])

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

raw_death <- read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv",
                      stringsAsFactors = FALSE,
                      fill =FALSE)

#Handling missing data from last day of the data
# If missing value, will use the value of the previous day as input
raw_death[, ncol(raw_death)] <- ifelse(is.na(raw_death[, ncol(raw_death)]), raw_death[, ncol(raw_death) - 1], raw_death[, ncol(raw_death)])

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

raw_rec <- read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv",
                    stringsAsFactors = FALSE,
                    fill =FALSE)


#Handling missing data from last day of the data
# If missing value, will use the value of the previous day as input
raw_rec[, ncol(raw_rec)] <- ifelse(is.na(raw_rec[, ncol(raw_rec)]),
                                   raw_rec[, ncol(raw_rec) - 1],
                                   raw_rec[, ncol(raw_rec)])

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

coronavirus <- dplyr::bind_rows(df_conf2, df_death2, df_rec2) %>%
  dplyr::arrange(date) %>% dplyr::ungroup() %>%
  dplyr::filter(cases != 0)
head(coronavirus)
tail(coronavirus)



usethis::use_data(coronavirus, overwrite = TRUE)

write.csv(coronavirus, "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.csv", row.names = FALSE)
writexl::write_xlsx(x = coronavirus, path = "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.xlsx", col_names = TRUE)



