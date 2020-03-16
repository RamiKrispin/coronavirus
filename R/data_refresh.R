#' Update the Package Datasets
#' @description  Update the package datasets from the Dev version
#' @details As the CRAN version is being updated every one-two months, the dev version of the package is being updated on a daily bases.
#' This function enables to refresh the package dataset to the most up-to-date data
#' @return A data.frame object
#' @source Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#' @export update_datasets
#'
#' @examples
#'\dontrun{
#' update_datasets()
#' }
update_datasets <- function(){
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
      save(coronavirus, file = paste(.libPaths(), "coronavirus/data/coronavirus.rda", sep = "/"))
      print("The coronavirus was update...")
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
        print("The covid_italy was update...")
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
      q <- base::tolower(base::readline("Updates for the covid_south_korea dataset are available. Do you want to update the dataset? N/y"))

      if(q == "y" || q == "Y" || q == "yes"){
        covid_south_korea <<- df3
        save(covid_south_korea, file = paste(.libPaths(), "coronavirus/data/covid_south_korea.rda", sep = "/"))
        print("The covid_south_korea was update...")
      }
    }
  }


}
