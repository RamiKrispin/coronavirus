#' Update the Package Datasets
#' @param silence A boolean, if set to TRUE, will automatically install updates without prompt question, by default set to FALSE
#' @description  Update the package datasets on the global environment with the most recent data on the Dev version
#' @details As the CRAN version is being updated every one-two months, the dev version of the package is being updated on a daily bases.
#' This function enables to refresh the package dataset to the most up-to-date data. Changes will be available on the global environment
#' @return A data.frame object
#' @source coronavirus - Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#'
#' covid_south_korea - Wikipedia article "2020 coronavirus outbreak in South Korea" \href{https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_South_Korea}{website}
#'
#' covid_iran - Wikipedia article "2020 coronavirus pandemic in Iran"  \href{https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Iran}{website}
#' @export update_datasets
#'
#' @examples
#'\dontrun{
#'
#' # update with a question prompt
#' update_datasets(silence = FALSE)
#'
#'
#' # update without a question prompt
#' update_datasets(silence = TRUE)
#' }

update_datasets <- function(silence = FALSE){
  flag <- FALSE

  coronavirus_current <- coronavirus::coronavirus
  iran_current <- coronavirus::covid_iran
  sk_current <- coronavirus::covid_south_korea


  coronavirus_git <- utils::read.csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/coronavirus_dataset.csv",
                                     stringsAsFactors = FALSE)

  iran_git <- utils::read.csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/iran/covid_iran_long.csv",
                              stringsAsFactors = FALSE)

  sk_git <- utils::read.csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/south_korea/covid_south_korea_long.csv",
                            stringsAsFactors = FALSE)


  coronavirus_git$date <- base::as.Date(coronavirus_git$date)
  iran_git$date <- base::as.Date(iran_git$date)
  sk_git$date <- base::as.Date(sk_git$date)


  if(!base::identical(coronavirus_git, coronavirus_current)){
    if(base::nrow(coronavirus_git) > base::nrow(coronavirus_current)){
      flag <- TRUE
    }
  }

  if(!base::identical(iran_git, iran_current)){
    if(base::nrow(iran_git) > base::nrow(iran_current)){
      flag <- TRUE
    }
  }

  if(!base::identical(sk_git, sk_current)){
    if(base::nrow(sk_git) > base::nrow(sk_current)){
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
          devtools::install_github("RamiKrispin/coronavirus")

          base::message("The data was refresed, please restart your session to have the new data available")
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
