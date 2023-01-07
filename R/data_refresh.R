#' Update the coronavirus Dataset
#' @param silence A boolean, if set to TRUE, will automatically install updates without prompt question, by default set to FALSE
#' @description  Update the package datasets on the global environment with the most recent data on the Dev version
#' @details As the CRAN version is being updated every one-two months, the dev version of the package is being updated on a daily bases.
#' This function enables to refresh the package dataset to the most up-to-date data. Changes will be available on the global environment
#' @return A data.frame object
#' @source coronavirus - Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#' @export update_dataset
#'
#' @examples
#'\dontrun{
#'
#' # update with a question prompt
#' update_dataset(silence = FALSE)
#'
#'
#' # update without a question prompt
#' update_dataset(silence = TRUE)
#' }

update_dataset <- function(silence = FALSE){
  flag <- FALSE

  coronavirus_current <- coronavirus::coronavirus


  year_start <- 2020
  year_end <- as.numeric(format(Sys.Date(), "%Y"))

  coronavirus_git <- lapply(year_start:year_end, function(i){
    cat(paste0("\033[4;", 32, "m","Loading ", i, " data","\033[0m","\n"))
    url <- paste("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/coronavirus_",
                 i,
                 ".csv",
                 sep = "")
    df <- readr::read_csv(url,
                          col_types = readr::cols(
                            date = readr::col_date(format = ""),
                            province = readr::col_character(),
                            country = readr::col_character(),
                            lat = readr::col_double(),
                            long = readr::col_double(),
                            type = readr::col_character(),
                            cases = readr::col_double(),
                            uid = readr::col_double(),
                            iso2 = readr::col_character(),
                            iso3 = readr::col_character(),
                            code3 = readr::col_double(),
                            combined_key = readr::col_character(),
                            population = readr::col_double(),
                            continent_name = readr::col_character(),
                            continent_code = readr::col_character()
                          ))

    return(df)
  }) |>
    dplyr::bind_rows()

  coronavirus_git$date <- base::as.Date(coronavirus_git$date)


  if(!base::identical(coronavirus_git, coronavirus_current)){
    if(base::nrow(coronavirus_git) > base::nrow(coronavirus_current)){
      flag <- TRUE
    }
  }



  if(flag){
    if(!silence){
      q <- base::tolower(base::readline("Updates are available on the coronavirus Dev version, do you want to update? n/Y"))
    } else {
      q <- "y"
    }
    if(q == "y" | q == "yes"){

      base::tryCatch(
        expr = {
          devtools::install_github("RamiKrispin/coronavirus",
                                   upgrade = "never",
                                   ref = "master")

          # base::message("The data was refresed, please restart your session to have the new data available")
          # If library is loaded, auto onload and load the library to have the new data available
          if ("coronavirus" %in% names(utils::sessionInfo()$otherPkgs)) {
            detach(package:coronavirus, unload = TRUE)
            library(coronavirus)
          }
        },
        error = function(e){
          message('Caught an error!')
          print(e)
        },
        warning = function(w){
          message('Caught an warning!')
          print(w)
        }

      )
    }
  } else {
    base::message("No updates are available")
  }


}
