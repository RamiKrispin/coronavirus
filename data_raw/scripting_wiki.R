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
  rvest::html_node(xpath = '//*[@id="mw-content-text"]/div/table[7]') %>%
  rvest::html_table(fill = TRUE,
             header = TRUE)


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
