#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset
#'
#' Daily summary of the Coronavirus (COVID-19) cases by state/province.
#'
#' @format A data frame with 7 variables.
#' \describe{
#'   \item{Province.State}{Name of province/state, for countries where data is
#'   provided split across multiple provinces/states.}
#'   \item{Country.Region}{Name of country/region.}
#'   \item{Lat}{Latitude of center of geographic region, defined as either
#'   Country.Region or, if available, Province.State.}
#'   \item{Long}{Longitude of center of geographic region, defined as either
#'   Country.Region or, if available, Province.State.}
#'   \item{date}{Date in YYYY-MM-DD format.}
#'   \item{cases}{Number of cases on given date.}
#'   \item{type}{An indicator for the type of cases (confirmed, death,
#'   recovered).}
#'   }
#' @source Johns Hopkins University Center for Systems Science and Engineering
#' (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}.
#' @keywords datasets coronavirus COVID19
#' @details The dataset contains the daily summary of Coronavirus cases
#' (confirmed, death, and recovered), by state/province.
#' @examples
#' data(coronavirus)
#'
#' require(dplyr)
#'
#' # Get top confirmed cases by state
#' coronavirus %>%
#'   filter(type == "confirmed") %>%
#'   group_by(Country.Region) %>%
#'   summarise(total = sum(cases)) %>%
#'   arrange(-total) %>%
#'   head(20)
#'
#' # Get the number of recovered cases in Mainland China by province
#' coronavirus %>%
#'   filter(type == "recovered", Country.Region == "Mainland China") %>%
#'   group_by(Province.State) %>%
#'   summarise(total = sum(cases)) %>%
#'   arrange(-total)
#'
"coronavirus"


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) South Korea Outbreak Dataset
#'
#' Daily summary of the Coronavirus (COVID-19) confirmed cases in South Korea by
#' province and city.
#'
#' @format A data frame with 4 variables.
#' \describe{
#'   \item{date}{Date in YYYY-MM-DD format.}
#'   \item{city}{Name of city.}
#'   \item{province}{Name of province.}
#'   \item{total}{Number of confirmed cases.}
#'   }
#' @source Wikipedia contributors. 2020 coronavirus pandemic in South Korea.
#' In Wikipedia, The Free Encyclopedia. Retrieved from
#' \href{https://en.wikipedia.org/w/index.php?title=2020_coronavirus_pandemic_in_South_Korea&oldid=951626301}{here}.
#' @keywords datasets coronavirus COVID19 South Korea
#' @details The dataset contains the daily summary of the Coronavirus confirmed
#' cases in South Korea by province and city.
#' @examples
#' data(covid_south_korea)
#'
#' require(dplyr)
#'
#' # Get summary of total cases by city
#'
#' covid_south_korea %>%
#'   group_by(city) %>%
#'   summarise(total_cases = sum(total))
#'
"covid_south_korea"


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Iran Outbreak Dataset
#'
#' Daily summary of the Coronavirus (COVID-19) confirmed cases in Iran by region
#' and province.
#'
#' @format A data frame with 4 variables.
#' \describe{
#'   \item{date}{Date in YYYY-MM-DD format.}
#'   \item{region}{Name of region.}
#'   \item{province}{Name of province.}
#'   \item{total}{Number of confirmed cases.}
#'   }
#' @source Wikipedia contributors. 2020 coronavirus pandemic in Iran.
#' In Wikipedia, The Free Encyclopedia. Retrieved from
#' \href{https://en.wikipedia.org/w/index.php?title=2020_coronavirus_pandemic_in_Iran&oldid=951436728}{here}.
#' @keywords datasets coronavirus COVID19 Iran
#' @details The dataset contains the cases in Iran by region and province.
#' @examples
#' data(covid_iran)
#'
#' require(dplyr)
#'
#' # Get summary of total cases by province
#'
#' covid_iran %>%
#'   group_by(province) %>%
#'   summarise(total = sum(cases))
#'
"covid_iran"
