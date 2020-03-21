make_cds_fix_geotable <- function(coronavirus_cds, googlemaps_api_key){
  ggmap::register_google(key=googlemaps_api_key)

  cds_geofix_table <- coronavirus_cds %>%
    dplyr::filter(is.na(lat)) %>%
    dplyr::select(city, county, Province.State, Country.Region, country) %>%
    dplyr::group_by(city, county, Province.State, Country.Region, country) %>%
    dplyr::slice(1L) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(
      Province.State = ifelse(Province.State=="GU" & country == "USA", "Guam", Province.State),
      search_string = paste(city, county, Province.State, Country.Region, sep = ","),
      search_string = gsub("NA,", "", search_string),
      search_string = gsub("\\(unassigned\\),", "", search_string)) %>%
    dplyr::mutate(ll = lapply(search_string, ggmap::geocode)) %>%
    tidyr::unnest(ll) %>%
    dplyr::rename(long_fix = lon, lat_fix = lat) %>%
    dplyr::mutate(Province.State = ifelse(Province.State=="Guam" & country == "USA", "GU", Province.State))

  cds_geofix_table
}
