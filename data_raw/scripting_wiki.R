#----------------Scripting Wiki Pages----------------
# Scripting different tables from wiki pages about coronavirus
#----------------Functions----------------
`%>%` <- magrittr::`%>%`
#----------------US----------------
# Summarise table of cases in the US
# Using : https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_the_United_States

url <-  "https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_the_United_States"

us_raw <- url %>%
  xml2::read_html() %>%
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[6]') %>%
  rvest::html_table(fill = TRUE,
             header = TRUE)


# Setting the names
names(us_raw)[min(which(names(us_raw) == "Location"))] <- "county_city"
names(us_raw)[min(which(names(us_raw) == "Location"))] <- "state"
us_raw$date <- lubridate::mdy(us_raw$`Date announced`)

# Dropping details raw
us <- us_raw %>% dplyr::filter(!is.na(date)) %>%
  dplyr::select(- `Date announced`) %>%
  dplyr::select(case_no_temp = `Case no.`,
                date,
                status = Status,
                cdc_origin_type = `CDC origin type`,
                origin = Origin,
                county_city,
                state,
                treatment_facility = `Treatment facility`,
                sex = Sex,
                age = Age) %>%
  dplyr::mutate(case_no = strsplit(case_no_temp, split = "\\[") %>%
                  purrr::map(~.x[1]) %>%
                  as.numeric()) %>%
  dplyr::select(-case_no_temp) %>%
  dplyr::select(case_no, dplyr::everything())
head(us)
tail(us)
str(us)

#----------------South Korea----------------
# Summarise table of cases in the South Korea
# Using : https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_South_Korea

url_sk <-  "https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_South_Korea"

sk_raw <- url_sk %>%
  xml2::read_html() %>%
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[8]') %>%
  rvest::html_table(fill = TRUE,
             header = TRUE)

head(sk_raw)
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
sk_names[25] <- "tested_current"
sk_names[26] <- "discharged_total"
sk_names <- c(sk_names, "source")


sk_df <- sk_raw[-1,] %>% stats::setNames(sk_names) %>%
  dplyr::select(-time, -source) %>%
  dplyr::mutate(date = lubridate::ymd(date)) %>%
  dplyr::filter(!is.na(date))


head(sk_df)
tail(sk_df)
str(sk_df)

sk_1 <- sk_df %>% dplyr::select(date)
# Removing brackets
for(i in 2:ncol(sk_df)){
  x <- ifelse(grepl(")", x = sk_df[,i]),strsplit(sk_df[, i], split = ")") %>% purrr::map_chr(~.x[2]), sk_df[, i] )
  x <- ifelse(grepl("\\[", x = x),strsplit(x, split = "\\[") %>% purrr::map_chr(~.x[1]), x )
  x <- ifelse(grepl(",", x = x),strsplit(x, split = "\\[") %>% purrr::map_chr(~.x[1]), x )
  x <- gsub(pattern = ",", replacement = "", x)
  sk_df1[[names(sk_df)[i]]] <- as.numeric(x)
}

View(sk_df1)
totals <- c("confirmed_new",
            "confirmed_total",
            "death_new",
            "death_total",
            "tested_total",
            "tested_current",
            "discharged_total")

sk_df2 <- sk_df1 %>%
  tidyr::pivot_longer(cols = c(-date), names_to = "city") %>%
  dplyr::mutate(cases = as.numeric(value)) %>%
  dplyr::mutate(cases = ifelse(is.na(cases), 0, cases))
View(sk_df2)



sk_df3 <- sk_df2 %>% dplyr::filter(city %in% totals) %>%
  dplyr::group_by(date, city) %>%
  dplyr::summarise(total = max(cases, na.rm = TRUE)) %>%
  dplyr::ungroup()

View(sk_df3)

sk_city <- sk_df2 %>%
  dplyr::filter(!city %in% totals) %>%
  dplyr::group_by(date, city) %>%
  dplyr::summarise(total = sum(cases, na.rm = TRUE)) %>%
  dplyr::ungroup() %>%
  dplyr::left_join(sk_prov_map,  by = "city") %>%
  dplyr::select(date, city, province, total) %>%
  as.data.frame()

str(sk_city)
View(sk_city)
covid_south_korea <- sk_city

usethis::use_data(covid_south_korea, overwrite = TRUE)

write.csv(covid_south_korea, "/Users/ramikrispin/R/packages/coronavirus_csv/south_korea/covid_south_korea_long.csv", row.names = FALSE)
write.csv(sk_df1, "/Users/ramikrispin/R/packages/coronavirus_csv/south_korea/covid_south_korea_wide.csv", row.names = FALSE)
write.csv(sk_prov_map, "/Users/ramikrispin/R/packages/coronavirus_csv/south_korea/sk_city_prov_mapping.csv", row.names = FALSE)
#----------------Germany----------------
# Summarise table of cases in the Germany
# Using : https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_Germany

url_gr <-  "https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_Germany"

gr_raw <- url_gr %>%
  xml2::read_html() %>%
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>%
  rvest::html_table(fill = TRUE,
                    header = TRUE) %>% t


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
