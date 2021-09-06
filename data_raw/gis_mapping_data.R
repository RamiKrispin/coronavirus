# UID/ISO/FIPS mapping

gis_code_mapping <- NULL
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
save(gis_code_mapping, file = "./data_raw/gis_mapping.RData")
