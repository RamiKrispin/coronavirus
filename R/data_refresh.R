#' Update the Package Datasets
#' @description  Update the package datasets on the global environment with the most recent data on the Dev version
#' @details As the CRAN version is being updated every one-two months, the dev version of the package is being updated on a daily bases.
#' This function enables to refresh the package dataset to the most up-to-date data. Changes will be available on the global environment
#' @return A data.frame object
#' @source coronavirus - Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#'
#' covid_italy - Wikipedia article "2020 coronavirus outbreak in Italy" \href{https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_Italy}{website}
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


  # Update the coronavirus dataset
  df1 <- read.csv(file = "https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/coronavirus_dataset.csv", stringsAsFactors = FALSE)


  df1$date <- as.Date(df1$date)

  if(identical(df1, coronavirus::coronavirus)){
    print("The coronavirus data set is up-to-date")
  } else {
    l_date <- max(coronavirus::coronavirus$date)
    g_date <- max(df1$date)

    if(g_date > l_date & base::nrow(df1) > base::nrow(coronavirus::coronavirus)){
      q <- base::tolower(base::readline("Updates for the coronavirus dataset are available. Do you want to update the dataset? N/y"))

      if(q == "y" || q == "Y" || q == "yes"){
        coronavirus <<- df1

        print("The 'coronavirus' dataset was updated on the global envirunment")
        flag <- TRUE
      }
    }
  }


  # Update the coronavirus dataset
  df2 <- read.csv(file = "https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/italy/covid_italy_long.csv", stringsAsFactors = FALSE)


  df2$date <- as.Date(df2$date)

  if(identical(df2, coronavirus::covid_italy)){
    print("The covid_italy data set is up-to-date")
  } else{
    l_date <- max(coronavirus::covid_italy$date)
    g_date <- max(df2$date)

    if(g_date > l_date & base::nrow(df2) > base::nrow(coronavirus::covid_italy)){
      q <- base::tolower(base::readline("Updates for the covid_italy dataset are available. Do you want to update the dataset? N/y"))

      if(q == "y" || q == "Y" || q == "yes"){
        covid_italy <<- df2
        save(covid_italy, file = paste(.libPaths(), "coronavirus/data/covid_italy.rda", sep = "/"))
        print("The 'covid_italy' dataset was updated on the global envirunment")

        flag <- TRUE
      }
    }
  }


  # Update the South Korea dataset
  df3 <- read.csv(file = "https://raw.githubusercontent.com/RamiKrispin/coronavirus-csv/master/south_korea/covid_south_korea_long.csv", stringsAsFactors = FALSE)


  df3$date <- as.Date(df3$date)

  if(identical(df3, coronavirus::covid_south_korea)){
    print("The covid_italy data set is up-to-date")
  } else{
    l_date <- max(coronavirus::covid_south_korea$date)
    g_date <- max(df3$date)

    if(g_date > l_date & base::nrow(df3) > base::nrow(coronavirus::covid_south_korea)){
      q <- base::tolower(base::readline("Updates for the covid_south_korea dataset are available. Do you want to update it? N/y"))

      if(q == "y" || q == "Y" || q == "yes"){
        covid_south_korea <<- df3
        print("The 'covid_south_korea' dataset was updated on the global envirunment")
        flag <- TRUE
      }
    }
  }


  # Update the Iran dataset
  df4 <- read.csv(file = "https://github.com/RamiKrispin/coronavirus-csv/blob/master/iran/covid_iran_long.csv", stringsAsFactors = FALSE)


  df4$date <- as.Date(df4$date)

  if(identical(df4, coronavirus::covid_iran)){
    print("The covid_iran dataset is up-to-date")
  } else{
    l_date <- max(coronavirus::covid_iran$date)
    g_date <- max(df4$date)

    if(g_date > l_date & base::nrow(df4) > base::nrow(coronavirus::covid_iran)){
      q <- base::tolower(base::readline("Updates for the covid_iran dataset are available. Do you want to update it? N/y"))

      if(q == "y" || q == "Y" || q == "yes"){
        covid_south_korea <<- df4
        print("The 'covid_iran' dataset was updated on the global envirunment")
        flag <- TRUE
      }
    }
  }

  df5 <- covid19us::get_states_daily()
  flag <- TRUE
  print("The covid_us_states dataset is up-to-date.")

  if(flag){
    print("To update the dataset on the package itself please install the package dev version from Github")
  }

}
