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
#'   \item{uid}{Country code}
#'   \item{iso2}{Officially assigned country code identifiers with two-letter}
#'   \item{iso3}{Officially assigned country code identifiers with three-letter}
#'   \item{code3}{UN country code}
#'   \item{combined_key}{Country and province (if applicable)}
#'   \item{population}{Country or province population}
#'   \item{continent_name}{Continent name}
#'   \item{continent_code}{Continent code}
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
#'   \item{date}{Data collection date in YYYY-MM-DD format}
#'   \item{country_region}{Country or region name}
#'   \item{continent_name}{Continent name}
#'   \item{continent_code}{Continent code}
#'   \item{combined_key}{Country and province (if applicable)}
#'   \item{doses_admin}{Cumulative number of doses administered. When a vaccine requires multiple doses, each one is counted independently}
#'   \item{people_at_least_one_dose}{Cumulative number of people who received at least one vaccine dose. When the person receives a prescribed second dose, it is not counted twice}
#'   \item{population}{Country or province population}
#'   \item{uid}{Country code}
#'   \item{iso2}{Officially assigned country code identifiers with two-letter}
#'   \item{iso3}{Officially assigned country code identifiers with three-letter}
#'   \item{code3}{UN country code}
#'   \item{fips}{Federal Information Processing Standards code that uniquely identifies counties within the USA}
#'   \item{lat}{Latitude}
#'   \item{long}{Longitude}


#'
#'   }
#' @source
#'
#' - Vaccine data - Johns Hopkins University Centers for Civic Impact
#' (JHU CCSE) COVID-19 \href{https://github.com/govex/COVID-19}{repository}.
#'
#' - Country code (uid, iso2, iso3, etc.) are sourced from this \href{https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data}{repository},
#' see \href{https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data#uid-lookup-table-logic}{section 4}
#' for full data resources.
#'
#' - Continent code mapping is sourced from \href{https://datahub.io/JohnSnowLabs/country-and-continent-codes-list}{DATA HUB}
#'
#' @keywords datasets coronavirus COVID19 vaccine
#' @details The dataset provides the daily cumulative number of people who received vaccine (or at least one vaccine dose) by country and province (when applicable)
#' @examples
#' data(covid19_vaccine)
#'
#' head(covid19_vaccine)
#'
"covid19_vaccine"
