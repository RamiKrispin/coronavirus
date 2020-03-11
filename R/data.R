#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) cases by state/province.
#'
#'
#' @format A tbl object
#' @source Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#' @keywords datasets coronavirus COVID19
#' @details The dataset contains the daily summary of Coronavirus cases (confirmed, death, and recovered), by state/province
#' @examples
#'
#' data(coronavirus)
#'
#' require(dplyr)
#'
#' # Get top confirmed cases by state
#'
#' coronavirus %>%
#'  filter(type == "confirmed") %>%
#'  group_by(Country.Region) %>%
#'  summarise(total = sum(cases)) %>%
#'  arrange(-total) %>%
#'  head(20)
#'
#' # Get the number of recovered cases in Mainland China by province
#'  coronavirus %>%
#'     filter(type == "recovered", Country.Region == "Mainland China") %>%
#'     group_by(Province.State) %>%
#'     summarise(total = sum(cases)) %>%
#'     arrange(-total)
#'
"coronavirus"

#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Italy Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) confirmed cases in Italy by region
#'
#'
#' @format A data.frame object
#' @source Wikipedia article "2020 coronavirus outbreak in Italy" \href{https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_Italy}{website}
#' @keywords datasets coronavirus COVID19 Italy
#' @details The dataset contains the daily summary of the Coronavirus confirmed cases in Italy by region
#' @examples
#'
#' data(covid_italy)
#'
#' require(dplyr)
#'
#' # Get summary by sub region of totalcases
#'
#' covid_italy %>%
#' group_by(sub_region) %>%
#' summarise(total_cases = sum(total))
#'

"covid_italy"

