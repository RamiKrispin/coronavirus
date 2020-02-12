`%>%` <- magrittr::`%>%`

raw_conf <- read.csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/time_series/time_series_2019-ncov-Confirmed.csv",
                     stringsAsFactors = FALSE)

str(raw_conf)

df_conf <- raw_conf[, 1:4]

head(df_conf)

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
                                             values_to = "cases")

df_conf1$month <- strsplit(df_conf1$date_temp[1], split = "\\.")



head(df_conf1)
