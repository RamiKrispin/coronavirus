#----------------------------------------------------
# Pulling the coronvirus data from John Hopkins repo
# https://github.com/CSSEGISandData/COVID-19
#----------------------------------------------------
# Setting functions
source("../R/update_coronavirus.R")
coronavirus_sf <- update_coronavirus_raw(debug=TRUE, returnclass = "sf")

coronavirus <- as.data.frame(coronavirus_sf) %>%
  dplyr::select(-geometry)

head(coronavirus)
tail(coronavirus)

usethis::use_data(coronavirus, overwrite = TRUE)
usethis::use_data(coronavirus_sf, overwrite = TRUE)

write.csv(coronavirus, "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.csv", row.names = FALSE)
writexl::write_xlsx(x = coronavirus, path = "/Users/ramikrispin/R/packages/coronavirus_csv/coronavirus_dataset.xlsx", col_names = TRUE)



