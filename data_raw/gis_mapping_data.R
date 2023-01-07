# UID/ISO/FIPS mapping
`%>%` <- magrittr::`%>%`
gis_code_mapping <- gis_codes_coronavirues <- NULL
tryCatch(
  gis_code_mapping <- readr::read_csv(file = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv",
                             col_types = readr::cols(UID = readr::col_number(),
                                                     code3 = readr::col_number(), FIPS = readr::col_character(),
                                                     Admin2 = readr::col_character(), Population = readr::col_number())) %>%
    as.data.frame(),
  error = function(c) base::message(c)
)

names(gis_code_mapping) <- tolower(names(gis_code_mapping))
names(gis_code_mapping)[which(names(gis_code_mapping) == "long_")] <- "long"


head(gis_code_mapping)



gis_codes_coronavirues <- readr::read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv",
                             col_types = readr::cols(FIPS = readr::col_number(),
                                                     Admin2 = readr::col_character()))

names(gis_codes_coronavirues) <- tolower(names(gis_codes_coronavirues))
names(gis_codes_coronavirues)[which(names(gis_codes_coronavirues) == "long_")] <- "long"
head(gis_codes_coronavirues)

# Continent mapping
continent_mapping <- readr::read_csv(file = "https://pkgstore.datahub.io/JohnSnowLabs/country-and-continent-codes-list/country-and-continent-codes-list-csv_csv/data/b7876b7f496677669644f3d1069d3121/country-and-continent-codes-list-csv_csv.csv",
    na = "null") %>%
  dplyr::select(continent_name = Continent_Name,
                continent_code = Continent_Code,
                country_name = Country_Name,
                iso2 = Two_Letter_Country_Code,
                iso3 = Three_Letter_Country_Code,
                uid = Country_Number) %>% as.data.frame()
head(continent_mapping)

save(continent_mapping, gis_code_mapping, gis_codes_coronavirues, file = "./data_raw/gis_mapping.RData")
