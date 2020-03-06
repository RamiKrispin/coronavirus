#----------------Scripting Wiki Pages----------------
# Scripting different tables from wiki pages about coronavirus
#----------------Functions----------------
`%>%` <- magrittr::`%>%`
#----------------US----------------
# Summarise table of cases in the US
# Using : https://en.wikipedia.org/w/index.php?title=2020_coronavirus_outbreak_in_the_United_States&oldid=944107102

url <-  "https://en.wikipedia.org/w/index.php?title=2020_coronavirus_outbreak_in_the_United_States&oldid=944107102"

us_raw <- url %>%
  xml2::read_html() %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div/table[6]') %>%
  html_table(fill = TRUE,
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
  dplyr::mutate(case_no = strsplit(us$case_no_temp, split = "\\[") %>%
                  purrr::map(~.x[1]) %>%
                  as.numeric()) %>%
  dplyr::select(-case_no_temp) %>%
  dplyr::select(case_no, dplyr::everything())
head(us)
str(us)

