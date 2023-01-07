#' Refresh the 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset in the Covid19R Project Format
#'
#' Daily summary of the Coronavirus (COVID-19) cases by state/province.
#' @return A tibble object
#' * date - The date in YYYY-MM-DD form
#' * location - The name of the location as provided by the data source.
#' * location_type - The type of location using the covid19R controlled vocabulary.
#' * location_code - A standardized location code using a national or international standard. Drawn from \href{https://github.com/olahol/iso-3166-2.js/}{iso-3166-2.js}'s version
#' * location_code_type The type of standardized location code being used according to the covid19R controlled vocabulary. Here we use `iso_3166_2`
#' * data_type - the type of data in that given row using the covid19R controlled vocabulary. Includes cases_new, deaths_new, recovered_new.
#' * value - number of cases of each data type
#' @export refresh_coronavirus_jhu
#' @return A data.frame object
#' @source coronavirus - Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#'
#' @examples
#' \dontrun{
#' # update the data
#' jhu_covid19_dat <- refresh_coronavirus_jhu()
#' }
#'
refresh_coronavirus_jhu <- function(){
  df <- NULL
  tryCatch(
    df <- readr::read_csv(file = "https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv",
                          col_types = readr::cols(date = readr::col_date(format = "%Y-%m-%d"),
                                           cases = readr::col_number(),
                                           continent_code = readr::col_character())),
    error = function(c) base::message(c)
    # warning = function(c) base::message(c),
    # message = function(c) base::message(c)
  )




  if(base::is.null(df)){
    base::message("Could not refresh the coronavirus dataset, please check your connection")
  } else{
    df$location <- ifelse(df$province == "" | is.na(df$province), df$country, paste(df$province, df$country, sep = ", "))
    df$location_type <-  ifelse(df$province== "" | is.na(df$province), "country", "state")

    # Fixes before merging in codes
    df$location <- gsub("Korea, South", "South Korea",  df$location)
    df$location <- gsub("Bonaire, Sint Eustatius and Saba",
                        "Bonaire and Sint Eustatius and Saba",  df$location)
    df$location <- gsub("^\\, ", "",  df$location )

    #get code table
    iso_3166_2_code_table <- readr::read_csv("https://github.com/RamiKrispin/coronavirus/raw/master/data_raw/iso_3166_2_code_table.csv",
                                             col_types = readr::cols(
                                               location = readr::col_character(),
                                               location_code = readr::col_character(),
                                               location_code_type = readr::col_character()
                                             ))

    # left join codes in
    df <- base::merge(df, iso_3166_2_code_table,
                      all.x = TRUE, by = "location")

    #    df$location_code <- paste(df$lat, df$long, sep = ", ")
    #    df$location_code_type <- "latitude, longitude"

    #data type
    df$data_type <- ifelse(df$type == "confirmed", "cases_new",
                           ifelse(df$type == "recovery", "recovered_new", "deaths_new"))
    df$value <- df$cases

    #zeroing out old columns
    df$province <- df$country <- df$type <- df$cases <-  NULL

    col_order <- c( "date", "location", "location_type",
                    "location_code", "location_code_type", "data_type",
                    "value", "lat", "long")
    # df$date <- as.Date(df$date)

    return(df[,col_order])
  }
}



#' Get information about the datasets provided by the coronavirus package
#'
#' @description Returns information about the datasets in this package for covid19R harvesting
#'
#' @return a tibble of information about the datasets in this package
#' @export get_info_coronavirus
#'
#' @examples
#' \dontrun{
#'
#' # get the dataset info from this package
#' get_info_coronavirus()
#' }
#'
get_info_coronavirus <- function(){
  data.frame(
    data_set_name = "coronavirus_jhu",
    package_name = "coronavirus",
    function_to_get_data = "refresh_coronavirus_jhu*",
    data_details = "The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset from the Johns Hopkins University Center for Systems Science and Engineering",
    data_url = "https://systems.jhu.edu/research/public-health/ncov/",
    license_url = "https://github.com/CSSEGISandData/COVID-19/",
    data_types = "cases_new, recovered_new, deaths_new",
    location_types = "country, state",
    spatial_extent = "global",
    has_geospatial_info = TRUE
  )
}
