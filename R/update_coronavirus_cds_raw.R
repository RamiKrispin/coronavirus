#' Update the coronavirus CDS Datasets
#' @description  Update the coronavirus data scrapper datasets
#' @param remake_table Defaults to FALSE. If TRUE, remakes the geocode fix table
#' @param geofix fix the bad lat/longs?
#' @param fixed_geotable if you have an alternate data.frame to fix the geospatial errors, supply it.
#' @param returnclass Return an sf or a data frame object
#' @param googlemaps_api_key If you are fixing the geotable, you need a googlemaps api key. See \link[ggmaps]{register_google} for more.
#' Defaults to NULL.
#' @details As the CRAN version is being updated every one-two months, the dev version of the package is being updated on a daily bases.
#' This function enables to refresh the package directly from the source with the most up-to-date data
#' @return A data.frame or sf object
#' @source  \href{https://coronadatascraper.com/#home}{website}
#' @export update_coronavirus_cds_raw
"update_coronavirus_cds_raw"

#----------------------------------------------------
# Setting functions
`%>%` <- magrittr::`%>%`
#----------------------------------------------------

#Notes
# initial country code is ISO 3166-1 alpha-3 country code
# see also https://github.com/hyperknot/country-level-id
# and naturalearth for country codes
# https://github.com/vincentarelbundock/countrycode
#XKX = Kosovo


update_coronavirus_cds_raw <- function(geofix = TRUE, remake_table = FALSE,
                                       fixed_geotable = NULL, returnclass = "sf",
                                       googlemaps_api_key = NULL){


  #pull from the CDS source and rename to match JHU data
  coronavirus_cds <-
    readr::read_csv("http://blog.lazd.net/coronadatascraper/timeseries-tidy.csv",
                    col_types = "ccccdddcDcd")


  #make a bad name translation table
  fixme_countrycode <-
    dplyr::tibble(country = unique(coronavirus_cds$country)[nchar(unique(coronavirus_cds$country)) >
                                                          3]) %>%
    dplyr::mutate(fix =
                    countrycode::countrycode(country, destination = 'iso3c', origin = 'country.name'))

  coronavirus_cds <- coronavirus_cds %>%
    dplyr::full_join(fixme_countrycode) %>%
    dplyr::mutate(country = ifelse(nchar(country) > 3, fix, country)) %>%
    dplyr::select(-fix) %>%
    dplyr::mutate(
      Country.Region = countrycode::countrycode(country, origin = 'iso3c', destination = 'country.name'),
      Country.Region = ifelse(country == "XKX", "Kosovo", Country.Region)
    ) %>%
    dplyr::rename(Province.State = state)

  if(!geofix) return(coronavirus_cds)

  # fix lat/longs of places with no names
  # using geocoding
  cds_fix_geotable <- coronavirus::cds_fix_geotable
  if(remake_table) cds_fix_geotable <- make_cds_fix_geotable(coronavirus_cds, googlemaps_api_key)
  if(!is.null(fixed_geotable)) cds_fix_geotable <- fixed_geotable

  coronavirus_cds <- coronavirus_cds %>%
    dplyr::full_join(cds_fix_geotable) %>%
    dplyr::mutate(lat = ifelse(is.na(lat), lat_fix, lat),
           long = ifelse(is.na(long), long_fix, long)) %>%
    dplyr::select(-long_fix, -lat_fix)

  #returns
  if(returnclass=="sf") return(sf::st_as_sf(coronavirus_cds,
                                            coords = c("long", "lat"), crs = 4326,
                                            remove = FALSE))

  coronavirus_cds

}




