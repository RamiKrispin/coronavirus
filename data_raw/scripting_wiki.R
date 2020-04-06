#----------------Scripting Wiki Pages----------------
# Scripting different tables from wiki pages about coronavirus
#----------------Functions----------------
`%>%` <- magrittr::`%>%`
#----------------South Korea----------------
# Summarise table of cases in the South Korea
# Using : https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_South_Korea
url_sk <-  "https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_South_Korea"

sk_raw <- url_sk %>%
  xml2::read_html() %>%
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[12]') %>%
  rvest::html_table(fill = TRUE,
                    header = TRUE)

head(sk_raw)

sk_prov_map <- data.frame(province = c("Gyeonggi", "Gyeonggi", "Gyeonggi",
                                       "Gangwon",
                                       "Gyeongsang", "Gyeongsang", "Gyeongsang", "Gyeongsang","Gyeongsang",
                                       "Chungcheong", "Chungcheong", "Chungcheong", "Chungcheong",
                                       "Jeolla", "Jeolla", "Jeolla", "Jeolla"),
                          city = c("Incheon", "Seoul", "Gyeonggi",
                                   "Gangwon",
                                   "Gyeongbuk", "Daegu", "Gyeongnam", "Busan", "Ulsan",
                                   "Chungbuk", "Sejong", "Daejeon", "Chungnam",
                                   "Jeonbuk", "Gwangju", "Jeonnam", "Jeju"),
                          stringsAsFactors = FALSE)

sk_prov_map$province <- tolower(sk_prov_map$province)
sk_prov_map$city <- tolower(sk_prov_map$city)

sk_names <- c("date", "time",
              "Incheon", "Seoul", "Gyeonggi",
              "Gangwon",
              "Gyeongbuk", "Daegu", "Gyeongnam", "Busan", "Ulsan",
              "Chungbuk", "Sejong", "Daejeon", "Chungnam",
              "Jeonbuk", "Gwangju", "Jeonnam", "Jeju",
              "quarantine_station",
              "confirmed_new", "confirmed_total",
              "death_new", "death_total",
              "tested_total", "tested_current",
              "discharged_total",
              "source")

sk_names <- sk_names %>% tolower()

sk_df <- sk_raw[-1,] %>% stats::setNames(sk_names) %>%
  dplyr::select(-time, -source, quarantine_station) %>%
  dplyr::mutate(date = lubridate::ymd(date)) %>%
  dplyr::filter(!is.na(date))


head(sk_df)
tail(sk_df)
str(sk_df)

sk_df1 <- sk_df %>% dplyr::select(date)
# Removing brackets
for(i in 2:ncol(sk_df)){
  print(i)
  x <- ifelse(grepl(")", x = sk_df[,i]),strsplit(sk_df[, i], split = ")") %>% purrr::map_chr(~.x[2]), sk_df[, i] )
  x <- ifelse(grepl("\\[", x = x),strsplit(x, split = "\\[") %>% purrr::map_chr(~.x[1]), x )
  x <- ifelse(grepl(",", x = x), gsub(pattern = ",", replacement = "", x), x)
  x <- gsub(pattern = ",", replacement = "", x)
  sk_df1[[names(sk_df)[i]]] <- ifelse(is.na(as.numeric(x)), 0, x)
}

# View(sk_df1)
totals_sk <- c("confirmed_new", "confirmed_total",
               "death_new", "death_total",
               "tested_total", "tested_current",
               "discharged_total")

sk_df2 <- sk_df1 %>%
  tidyr::pivot_longer(cols = c(-date), names_to = "city") %>%
  dplyr::mutate(cases = as.numeric(value)) %>%
  dplyr::select(-value)
head(sk_df2)



sk_df3 <- sk_df2 %>% dplyr::filter(city %in% totals_sk) %>%
  dplyr::group_by(date, city) %>%
  dplyr::summarise(total = max(cases, na.rm = TRUE)) %>%
  dplyr::ungroup()

head(sk_df3)

covid_south_korea <- sk_df2 %>%
  dplyr::filter(!city %in% totals_sk) %>%
  dplyr::group_by(date, city) %>%
  dplyr::summarise(total = sum(cases, na.rm = TRUE)) %>%
  dplyr::ungroup() %>%
  dplyr::left_join(sk_prov_map,  by = "city") %>%
  dplyr::select(date, city, province, total) %>%
  as.data.frame()

str(covid_south_korea)
View(covid_south_korea)

usethis::use_data(covid_south_korea, overwrite = TRUE)

write.csv(covid_south_korea, "/Users/ramikrispin/R/packages/coronavirus_csv/south_korea/covid_south_korea_long.csv", row.names = FALSE)
write.csv(sk_df1, "/Users/ramikrispin/R/packages/coronavirus_csv/south_korea/covid_south_korea_wide.csv", row.names = FALSE)
write.csv(sk_prov_map, "/Users/ramikrispin/R/packages/coronavirus_csv/south_korea/sk_city_prov_mapping.csv", row.names = FALSE)


#----------------Iran----------------
# Summarise table of cases in the Iran
# Using : https://en.wikipedia.org/wiki/Template:2019%E2%80%9320_coronavirus_pandemic_data/Iran_medical_cases

url_iran <-  "https://en.wikipedia.org/wiki/Template:2019%E2%80%9320_coronavirus_pandemic_data/Iran_medical_cases"

iran_raw <- url_iran %>%
  xml2::read_html() %>%
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>%
  rvest::html_table(fill = TRUE,
                    header = TRUE)


iran_region_mapping <- data.frame(region = c(rep("Region 1", 7), rep("Region 2", 6),
                                             rep("Region 3", 6), rep("Region 4", 6),
                                             rep("Region 5", 6)) ,
                                  province_abb = c("Qom", "Teh", "Maz", "Alb",
                                               "Sem", "Gol", "Qaz", "Esf",
                                               "Frs", "Hor", "Koh", "Cha",
                                               "Bus","Gil", "Ard", "Azs",
                                               "Azg", "Kur", "Zan", "Mar",
                                               "Ham", "Khz", "Krs", "Lor",
                                               "Ilm", "Khr", "Sis", "Yaz",
                                               "Khs", "Ker", "Khn"),
                                  province = c("Qom", "Tehran", "Mazandaran", "Alborz",
                                                "Semnan", "Golestan",  "Qazvin", "Esfahan",
                                                "Fars", "Hormozgan", "Kohgiluyeh and Buyer Ahmad", "Chahar Mahall and Bakhtiari",
                                                "Bushehr", "Gilan", "Ardebil", "East Azarbaijan",
                                                "West Azarbaijan", "Kordestan", "Zanjan", "Markazi",
                                                "Hamadan", "Khuzestan", "Kermanshah", "Lorestan",
                                                "Ilam", "Razavi Khorasan", "Sistan and Baluchestan", "Yazd",
                                                "South Khorasan", "Kerman", "North Khorasan"),
                                  stringsAsFactors = FALSE) %>%
  dplyr::arrange(province)

iran_region_mapping



iran_names <- iran_raw[1,] %>% as.character()
iran_names[33] <- "confirmed_new"
iran_names[34] <- "confirmed_total"
iran_names[35] <- "death_new"
iran_names[36] <- "death_total"



covid_iran <- iran_raw[-1, ] %>% stats::setNames(iran_names) %>%
  dplyr::select(- Sources) %>%
  dplyr::mutate(date = as.Date(Date)) %>%
  dplyr::select(-Date, -confirmed_new, -confirmed_total, -death_new, -death_total) %>%
  dplyr::filter(!is.na(date)) %>%
  tidyr::pivot_longer(cols = -date, names_to = "province_abb") %>%
  dplyr::mutate(cases = as.numeric(value)) %>%
  dplyr::mutate(cases = ifelse(is.na(cases), 0, cases)) %>%
  dplyr::select(-value) %>%
  dplyr::left_join(iran_region_mapping , by = "province_abb") %>%
  dplyr::select(date, region, province, cases) %>%
  as.data.frame()

covid_iran_wide <- covid_iran %>% tidyr::pivot_wider(names_from = province, values_from = cases)

str(covid_iran)
head(covid_iran)
View(covid_iran)

usethis::use_data(covid_iran, overwrite = TRUE)

write.csv(covid_iran, "/Users/ramikrispin/R/packages/coronavirus_csv/iran/covid_iran_long.csv", row.names = FALSE)
write.csv(covid_iran_wide, "/Users/ramikrispin/R/packages/coronavirus_csv/iran/covid_iran_wide.csv", row.names = FALSE)
write.csv(iran_region_mapping, "/Users/ramikrispin/R/packages/coronavirus_csv/iran/iran_region_mapping.csv", row.names = FALSE)



#----------------Germany----------------
# Summarise table of cases in the Germany
# Using : https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Germany

url_gr <-  "https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Germany"

gr_raw <- url_gr %>%
  xml2::read_html() %>%
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>%
  rvest::html_table(fill = TRUE,
                    header = TRUE)


gr_states <- gr_raw[2:18,1]
dates <- lubridate::mdy(paste(names(gr_raw)[-1], gr_raw[1,-1], 2020, sep = "-"))


gr_df <- lapply(gr_states, function(i){

  r <- NULL
  r <- which(gr_raw$State == i)
  df <- data.frame(dates = dates,
                   cases = as.character(gr_raw[r, -1]))


})

gr_names <- c("date_temp", gr_raw[1, 2:ncol(gr_raw)])

gr_raw2 <- gr_raw[-1, ] %>% as.data.frame() %>%
  setNames(gr_names) %>%
  dplyr::add_rownames(var = "month")
View(gr_raw2)
sk_prov_map <- data.frame(province = c("Gyeonggi", "Gyeonggi", "Gyeonggi",
                                       "Gangwon",
                                       "Gyeongsang", "Gyeongsang", "Gyeongsang", "Gyeongsang","Gyeongsang", "Gyeongsang",
                                       "Chungcheong", "Chungcheong", "Chungcheong", "Chungcheong",
                                       "Jeolla", "Jeolla", "Jeolla", "Jeolla"),
                          city = c("Incheon", "Seoul", "Gyeonggi",
                                   "Gangwon",
                                   "Daegu", "Gyeongbuk","Gyeongnam", "Gyeongsang", "Busan", "Ulsan",
                                   "Chungbuk", "Chungnam", "Sejong", "Daejeon",
                                   "Jeonbuk", "Jeonnam", "Gwangju", "Jeju"),
                          stringsAsFactors = FALSE)

sk_prov_map$province <- tolower(sk_prov_map$province)
sk_prov_map$city <- tolower(sk_prov_map$city)

sk_names <- sk_raw[1, ] %>% as.character() %>% tolower()
sk_names <- sk_names[- which(sk_names == "gyeongsang")]
sk_names[20] <- "confirmed_new"
sk_names[21] <- "confirmed_total"
sk_names[22] <- "death_new"
sk_names[23] <- "death_total"
sk_names[24] <- "tested_total"
sk_names <- c(sk_names, "source")


sk_df <- sk_raw[-1,] %>% stats::setNames(sk_names) %>% dplyr::select(-time, -source) %>%
  dplyr::mutate(date = lubridate::ymd(date)) %>%
  dplyr::filter(!is.na(date))


head(sk_df)
tail(sk_df)
sk <- sk_df %>% tidyr::pivot_longer(cols = c(-date), names_to = "city") %>%
  dplyr::mutate(cases = strsplit(value, split = "\\[") %>%
                  purrr::map_chr(~.x[1]))


sk$tested <- gsub(",", "", sk$tested) %>% as.numeric

sk <- sk %>% dplyr::left_join(sk_prov_map, by = "city") %>%
  dplyr::select(date, city, province, cases)
tail(sk, 20)

sk %>% dplyr::filter(city == "seoul")
