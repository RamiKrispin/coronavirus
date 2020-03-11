#' coronavirus_spatial
#'
#' @description  Create a geospatial version of the \link[coronavirus]{coronavirus} data set for
#' easier visualization and spatial analysis. Uses \link[rnaturalearth]{rnaturalearth} for the
#' the spatial info and generates \link[sf]{sf} objects using \link[sf]{st_join} to match up
#' datasets.
#' @param return_shape Should the \link[sf]{sf} object returned be points for cases or polygons of countries?
#' Defaults to `point`.
#' @param updated_data Should the `coronavirus` data be updated before generating the spatial
#' object. Updated the data in the toplevel environment, as, why not. Defaults to `FALSE`
#' @param returncols What coluns do you want returned. Defaults to `all`, giving all columns from
#' the original `coronavirus` dataset as well as those returned by \link[rnaturalearth]{ne_countries}.
#' `simple` returned those from `coronavirus` as well as some larger scale geographic information.
#' `reduced` returns the info from `simple` as well as information on population, income, and a
#' number of ISO codes.
#' @param ... Other arguments to \link[rnaturalearth]{ne_countries}
#'
#' @return An `sf` object with either country borders as polygons or cases as points
#' @export coronavirus_spatial
#'
#' @source Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#' @source The \link[rnaturalearth]{rnaturalearth}
#' @examples
#'\dontrun{
#' library(ggplot2)
#' library(dplyr)
#' library(rnaturalearth)
#'
#' worldmap <- ne_countries(returnclass = "sf")
#'
#' coronavirus <- update_coronavirus()
#'
#' coronavirus_points <- coronavirus_spatial() %>%
#'                        filter(date == "2020-03-08") %>%
#'                        filter(type == "confirmed")
#'
#' coronavirus_polys <- coronavirus_spatial(return_shape = "polygon")%>%
#'                        filter(date == "2020-03-08")%>%
#'                        filter(type == "confirmed")
#'
#' ggplot(worldmap) +
#'   geom_sf() +
#'   geom_sf(data = coronavirus_polys, aes(fill = log10(cases+1))) +
#'   geom_sf(data = coronavirus_points) +
#'   scale_fill_viridis_c() +
#'   theme_void()
#'
#' }

coronavirus_spatial <- function(return_shape = c("point", "polygon"),
                                updated_data = FALSE,
                                returncols = c("all", "simple","reduced"),
                                ...){
  if(updated_data) coronavirus <- update_coronavirus()

  #get a world map
  worldmap <- rnaturalearth::ne_countries(returnclass = "sf", ...) %>%
    select(-type)

  #filter data to confirmed
  coronavirus_sf <- coronavirus %>%
    sf::st_as_sf(coords = c("Long", "Lat"),
             remove = FALSE,
             crs = st_crs(worldmap))

  #get geospatial info about where the coronavirus is

  #if points join
  if(return_shape[1]=="point"){
    joined_corona <- sf::st_join(coronavirus_sf, worldmap)
  }else{
    joined_corona <- sf::st_join(worldmap,coronavirus_sf) %>%
    mutate(ifelse(is.na(cases), 0, NA)) #deal with countries with 0 cases so far
  }

  #select down to sane columns
  joined_corona <- switch(returncols[1],
                               "simple" = joined_corona %>% select(names(coronavirus_sf),
                                                                   admin, name_long, continent,
                                                                   region_un, subregion, region_wb),

                               "reduced" = joined_corona %>% select(name, name_long,
                                                                    names(coronavirus_sf),continent,
                                                                    region_un, subregion, region_wb,
                                                                    subunit, postal, formal_en,
                                                                    iso_a2, iso_a3, iso_n3,
                                                                    un_a3,
                                                                    pop_est, gdp_md_est),
                               joined_corona) #default

  joined_corona
}
