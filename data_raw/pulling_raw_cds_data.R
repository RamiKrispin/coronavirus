#----------------------------------------------------
# Pulling the coronvirus data from Coronavirus Data Scrapper
# http://blog.lazd.net/coronadatascraper/timeseries-tidy.csv
#----------------------------------------------------
# Setting functions
source("../R/update_coronavirus_cds_raw.R")
source("../R/make_cds_fix_geotable.R")
require(ggmap)

coronavirus_cds <- update_coronavirus_cds_raw(geofix=FALSE)

#many cds entries are bad - make a fix table
googlemaps_api_key <-  read.csv("~/googlemaps.api", header=FALSE, stringsAsFactors = FALSE)[1,1]
cds_fix_geotable <- make_cds_fix_geotable(coronavirus_cds, googlemaps_api_key)
usethis::use_data(cds_fix_geotable, overwrite = TRUE)

#now, make the fixed dataset
coronavirus_cds_sf <- update_coronavirus_cds_raw(fixed_geotable = cds_fix_geotable, returnclass = "sf")

coronavirus_cds <- dplyr::as_tibble(coronavirus_cds_sf) %>%
  dplyr::select(-geometry)

head(coronavirus_cds)
tail(coronavirus_cds)

usethis::use_data(coronavirus_cds, overwrite = TRUE)
usethis::use_data(coronavirus_cds_sf, overwrite = TRUE)

write.csv(coronavirus, "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_cds_dataset.csv", row.names = FALSE)
writexl::write_xlsx(x = coronavirus, path = "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_cds_dataset.xlsx", col_names = TRUE)



