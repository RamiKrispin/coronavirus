#' Update the Package Datasets
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
#' update_datasets()
#' }

update_datasets <- function(){
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


  coronavirus_git$date <- as.Date(coronavirus_git$date)
  iran_git$date <- as.Date(iran_git$date)
  sk_git$date <- as.Date(sk_git$date)


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
    q <- base::tolower(base::readline("Updates are available on the coronavirus Dev version, do you want to update? n/Y"))

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
