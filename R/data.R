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
