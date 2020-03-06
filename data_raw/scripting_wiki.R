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
  dplyr::mutate(case_no = strsplit(us$case_no, split = "\\[") %>% purrr::map(~.x[1]) %>% as.numeric())
head(us)
str(us)


strsplit(us$case_no, split = "\\[") %>% purrr::map(~.x[1]) %>% as.numeric()







# the URL of the wikipedia page to use is in wp_page_url
wp_page_url <- "https://en.wikipedia.org/w/index.php?title=2020_coronavirus_outbreak_in_the_United_States&oldid=944107102"
# read the page using the rvest package.
outbreak_webpage <- xml2::read_html(wp_page_url)

# parse the web page and extract the data from the eighth
# table
us_cases <- outbreak_webpage %>% html_nodes("table") %>% .[[8]] %>%
  html_table(fill = TRUE)
# The automatically assigned column names are OK except that
# instead of County/city and State columns we have two
# columns called Location, due to the unfortunate use of
# colspans in the header row.  The tidyverse abhors
# duplicated column names, so we have to fix those, and make
# some of the other colnames a bit more tidyverse-friendly.
us_cases_colnames <- colnames(us_cases)
us_cases_colnames[min(which(us_cases_colnames == "Location"))] <- "CityCounty"
us_cases_colnames[min(which(us_cases_colnames == "Location"))] <- "State"
us_cases_colnames <- us_cases_colnames %>% str_replace("Location",
                                                       "CityCounty") %>% str_replace("Location", "State") %>% str_replace("Case no.",
                                                                                                                          "CaseNo") %>% str_replace("Date announced", "Date") %>% str_replace("CDC origin type",
                                                                                                                                                                                              "OriginTypeCDC") %>% str_replace("Treatment facility", "TreatmentFacility")
colnames(us_cases) <- us_cases_colnames

# utility function to remove wikipedia references in square
# brackets
rm_refs <- function(x) stringr::str_split(x, "\\[", simplify = TRUE)[,
                                                                     1]

# now remove references from CaseNo column, convert it to
# integer, convert the date column to date type and then lose
# all rows which then have NA in CaseNo or NA in the date
# column
us_cases <- us_cases %>% mutate(CaseNo = rm_refs(CaseNo)) %>%
mutate(CaseNo = as.integer(CaseNo), Date = as.Date(lubridate::parse_date_time(Date,
                                                                     c("%B %d, %Y", "%d %B, %Y")))) %>% filter(!is.na(CaseNo),
                                                                                                               !is.na(Date)) %>% # convert the various versions of unknown into NA in the
  # OriginTypeCDC column
  mutate(OriginTypeCDC = if_else(OriginTypeCDC %in% c("Unknown",
                                                      "Undisclosed"), NA_character_, OriginTypeCDC))
