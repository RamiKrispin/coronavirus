#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset
#'
#' Daily summary of the Coronavirus (COVID-19) cases by state/province.
#'
#' @format A data frame with 7 variables.
#' \describe{
#'   \item{date}{Date in YYYY-MM-DD format.}
#'   \item{province}{Name of province/state, for countries where data is
#'   provided split across multiple provinces/states.}
#'   \item{country}{Name of country/region.}
#'   \item{lat}{Latitude of center of geographic region, defined as either
#'   country or, if available, province.}
#'   \item{long}{Longitude of center of geographic region, defined as either
#'   country or, if available, province.}
#'   \item{type}{An indicator for the type of cases (confirmed, death,
#'   recovered).}
#'   \item{cases}{Number of cases on given date.}
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
#'   group_by(country) %>%
#'   summarise(total = sum(cases)) %>%
#'   arrange(-total) %>%
#'   head(20)
#'
#' # Get the number of recovered cases in China by province
#' coronavirus %>%
#'   filter(type == "recovered", country == "China") %>%
#'   group_by(province) %>%
#'   summarise(total = sum(cases)) %>%
#'   arrange(-total)
#'
"coronavirus"

#' The COVID-19 Worldwide Vaccine Dataset
#'
#' Daily summary of the COVID-19 vaccination by country/province.
#'
#' @format A data frame with 8 variables.
#' \describe{
#'   \item{country_region}{Country or region name}
#'   \item{date}{Data collection date in YYYY-MM-DD format}
#'   \item{doses_admin}{Cumulative number of doses administered. When a vaccine requires multiple doses, each one is counted independently}
#'   \item{people_partially_vaccinated}{Cumulative number of people who received at least one vaccine dose. When the person receives a prescribed second dose, it is not counted twice}
#'   \item{people_fully_vaccinated}{Cumulative number of people who received all prescribed doses necessary to be considered fully vaccinated}
#'   \item{report_date_string}{Data report date in YYYY-MM-DD format}
#'   \item{uid}{Country code}
#'   \item{province_state}{Province or state if applicable}
#'   }
#' @source Johns Hopkins University Centers for Civic Impact
#' (JHU CCSE) COVID-19 \href{https://github.com/govex/COVID-19}{repository}.
#' @keywords datasets coronavirus COVID19 vaccine
#' @details The dataset provides the daily cumulative number of people who received vaccine (or at least one vaccine dose) by country and province (when applicable)
#' @examples
#' data(covid19_vaccine)
#'
#' head(covid19_vaccine)
#'
"covid19_vaccine"

#' World Population by Country Dataset
#'
#' World population by country between 1960 to 2020
#'
#' @format A data frame with 4 variables.
#' \describe{
#'   \item{country_name}{Country Name}
#'   \item{country_code}{Country abbreviations code}
#'   \item{year}{The year of the observation}
#'   \item{population}{Population}
#'   }
#' @source The World Bank Data \href{https://data.worldbank.org/indicator/SP.POP.TOTL?most_recent_year_desc=false}{website}.
#' @keywords datasets population country
#' @details The dataset provides worldwide popluation values by country between 1960 and 2020
#' @examples
#'
#' library(dplyr)
#' data(world_population)
#'
#' head(world_population)
#'
#' us_pop <- world_population %>%
#'   filter(country_code == "USA")
#' plot(us_pop$year, us_pop$population,
#'      type = "l", main = "US Population",
#'      xlab = "Source: World Bank",
#'      ylab = "Population",
#'      col = "blue")
"world_population"
