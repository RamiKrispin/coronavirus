#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) cases by state/province.
#'
#'
#' @format A data.frame object
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


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) South Korea Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) confirmed cases in South Korea by province and city
#'
#'
#' @format A data.frame object
#' @source Wikipedia article "2020 coronavirus outbreak in South Korea" \href{https://en.wikipedia.org/wiki/2020_coronavirus_outbreak_in_South_Korea}{website}
#' @keywords datasets coronavirus COVID19 South Korea
#' @details The dataset contains the daily summary of the Coronavirus confirmed cases in South Korea by province and city
#' @examples
#'
#' data(covid_south_korea)
#'
#' require(dplyr)
#'
#' # Get summary of total cases by city
#'
#' covid_south_korea %>%
#' group_by(city) %>%
#' summarise(total_cases = sum(total))
#'

"covid_south_korea"


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Iran Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) confirmed cases in Iran by region and province
#' @format A data.frame object
#' @source Wikipedia article "2020 coronavirus pandemic in Iran"  \href{https://en.wikipedia.org/wiki/2020_coronavirus_pandemic_in_Iran}{website}
#' @keywords datasets coronavirus COVID19 Iran
#' @details The dataset contains the cases in Iran by region and province
#' @examples
#'
#' data(covid_iran)
#'
#' require(dplyr)
#'
#' # Get summary of total cases by province
#'
#' covid_iran %>%
#' group_by(province) %>%
#' summarise(total = sum(cases))
#'

"covid_iran"


