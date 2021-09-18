
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://RamiKrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/RamiKrispin/coronavirus)](https://github.com/RamiKrispin/coronavirus/commit/master)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/coronavirus)](https://cran.r-project.org/package=coronavirus)

<!-- badges: end -->

The coronavirus package provides a tidy format dataset of the 2019 Novel
Coronavirus COVID-19 (2019-nCoV) epidemic and the vaccination efforts by
country. The raw data is being pulled from the Johns Hopkins University
Center for Systems Science and Engineering (JHU CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

More details available
[here](https://RamiKrispin.github.io/coronavirus/), and a `csv` format
of the package dataset available
[here](https://github.com/RamiKrispin/coronavirus/tree/master/csv)

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

<figcaption>
Source: Centers for Disease Control and Prevention’s Public Health Image
Library
</figcaption>

## Important Note

As this an ongoing situation, frequent changes in the data format may
occur, please visit the package news to get updates about those changes

## Installation

Install the CRAN version:

``` r
install.packages("coronavirus")
```

Install the Github version (refreshed on a daily bases):

``` r
# install.packages("devtools")
devtools::install_github("RamiKrispin/coronavirus")
```

## Datasets

The package provides the following two datasets:

-   **coronavirus** - tidy (long) format of the JHU CCSE
    [datasets](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).
    That includes the following columns:

    -   `date` - The date of the observation, using `Date` class
    -   `location` - The name of the location as provided by John
        Hopkins raw data
    -   `location_type` - The type of the location field, either
        `country` or `state`
    -   `location_code` - The location code, using the `ios_3166_2`
        format
    -   `location_code_type` - The location code type (`ios_3166_2`)
    -   `data_type` - The case type,
        `c("recovered_new", "cases_new", "deaths_new" )`
    -   `value` - The number of cases
    -   `lat` - The latitude code
    -   `long` - The longitude code

-   **covid19\_vaccine** - a tidy (long) format of the the Johns Hopkins
    [Centers for Civic Impact](https://civicimpact.jhu.edu/) global
    vaccination
    [dataset](https://github.com/govex/COVID-19/tree/master/data_tables/vaccine_data)
    by country. This dataset includes the following columns:

    -   `country_region` - Country or region name
    -   `date` - Data collection date in YYYY-MM-DD format
    -   `doses_admin` - Cumulative number of doses administered. When a
        vaccine requires multiple doses, each one is counted
        independently
    -   `people_partially_vaccinated` - Cumulative number of people who
        received at least one vaccine dose. When the person receives a
        prescribed second dose, it is not counted twice
    -   `people_fully_vaccinated` - Cumulative number of people who
        received all prescribed doses necessary to be considered fully
        vaccinated
    -   `report_date_string` - Data report date in YYYY-MM-DD format
    -   `uid` - Country code
    -   `province_state` - Province or state if applicable
    -   `iso2` - Officially assigned country code identifiers with
        two-letter
    -   `iso3` - Officially assigned country code identifiers with
        three-letter
    -   `code3` - UN country code
    -   `fips` - Federal Information Processing Standards code that
        uniquely identifies counties within the USA
    -   `lat` - Latitude
    -   `long` - Longitude
    -   `combined_key` - Country and province (if applicable)
    -   `population` - Country or province population
    -   `continent_name` - Continent name
    -   `continent_code` - Continent code

## Data refresh

While the **coronavirus** [CRAN
version](https://cran.r-project.org/package=coronavirus) is updated
every month or two, the [Github (Dev)
version](https://github.com/RamiKrispin/coronavirus) is updated on a
daily bases. The `update_dataset` function enables to overcome this gap
and keep the installed version with the most recent data available on
the Github version:

``` r
library(coronavirus)
update_dataset()
```

**Note:** must restart the R session to have the updates available

Alternatively, you can pull the data using the
[Covid19R](https://covid19r.github.io/documentation/) project [data
standard
format](https://covid19r.github.io/documentation/data-format-standard.html)
with the `refresh_coronavirus_jhu` function:

``` r
covid19_df <- refresh_coronavirus_jhu()
head(covid19_df)
#>         date    location location_type location_code location_code_type  data_type value      lat      long
#> 1 2020-12-30 Afghanistan       country            AF         iso_3166_2 deaths_new     7 33.93911 67.709953
#> 2 2021-04-02 Afghanistan       country            AF         iso_3166_2 deaths_new     6 33.93911 67.709953
#> 3 2021-03-22 Afghanistan       country            AF         iso_3166_2  cases_new    50 33.93911 67.709953
#> 4 2021-04-03 Afghanistan       country            AF         iso_3166_2 deaths_new     1 33.93911 67.709953
#> 5 2020-12-27 Afghanistan       country            AF         iso_3166_2 deaths_new    10 33.93911 67.709953
#> 6 2021-04-01 Afghanistan       country            AF         iso_3166_2 deaths_new     5 33.93911 67.709953
```

## Usage

``` r
data("coronavirus")

head(coronavirus)
#>         date province country     lat      long      type cases
#> 1 2020-01-22  Alberta  Canada 53.9333 -116.5765 confirmed     0
#> 2 2020-01-23  Alberta  Canada 53.9333 -116.5765 confirmed     0
#> 3 2020-01-24  Alberta  Canada 53.9333 -116.5765 confirmed     0
#> 4 2020-01-25  Alberta  Canada 53.9333 -116.5765 confirmed     0
#> 5 2020-01-26  Alberta  Canada 53.9333 -116.5765 confirmed     0
#> 6 2020-01-27  Alberta  Canada 53.9333 -116.5765 confirmed     0
```

Summary of the total confrimed cases by country (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 2
#>    country        total_cases
#>    <chr>                <int>
#>  1 US                41785903
#>  2 India             33381728
#>  3 Brazil            21069017
#>  4 United Kingdom     7373451
#>  5 Russia             7110656
#>  6 France             7021091
#>  7 Turkey             6766978
#>  8 Iran               5378408
#>  9 Argentina          5234851
#> 10 Colombia           4936052
#> 11 Spain              4926324
#> 12 Italy              4623155
#> 13 Indonesia          4181309
#> 14 Germany            4127158
#> 15 Mexico             3549229
#> 16 Poland             2895947
#> 17 South Africa       2873415
#> 18 Ukraine            2435404
#> 19 Philippines        2304192
#> 20 Peru               2164380
```

Summary of new cases during the past 24 hours by country and type (as of
2021-09-16):

``` r
library(tidyr)

coronavirus %>% 
  filter(date == max(date)) %>%
  select(country, type, cases) %>%
  group_by(country, type) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)
#> # A tibble: 195 x 4
#> # Groups:   country [195]
#>    country            confirmed death recovered
#>    <chr>                  <int> <int>     <int>
#>  1 US                    157957  3393        NA
#>  2 Brazil                 34407   649        NA
#>  3 India                  34403   320        NA
#>  4 Turkey                 28118   262        NA
#>  5 United Kingdom         26619   159        NA
#>  6 Philippines            21181   276        NA
#>  7 Russia                 19288   774        NA
#>  8 Malaysia               18815   346        NA
#>  9 Iran                   18021   453        NA
#> 10 Thailand               13894   188        NA
#> 11 France                 13272    38        NA
#> 12 Germany                11816    63        NA
#> 13 Vietnam                10489   239        NA
#> 14 Cuba                    7628    78        NA
#> 15 Serbia                  7602    31        NA
#> 16 Mexico                  7040   435        NA
#> 17 Botswana                6608     6        NA
#> 18 Israel                  6191    13        NA
#> 19 Ukraine                 6050   121        NA
#> 20 Italy                   5115    67        NA
#> 21 Canada                  4671    21        NA
#> 22 Japan                   4626    58        NA
#> 23 Romania                 4441    71        NA
#> 24 South Africa            4214   311        NA
#> 25 Spain                   4075   101        NA
#> 26 Iraq                    3923    52        NA
#> 27 Azerbaijan              3847    60        NA
#> 28 Ireland                 3765     0        NA
#> 29 Kazakhstan              3317     0        NA
#> 30 Indonesia               3145   237        NA
#> 31 Pakistan                2928    68        NA
#> 32 Costa Rica              2901    30        NA
#> 33 West Bank and Gaza      2501    15        NA
#> 34 Argentina               2493   132        NA
#> 35 Morocco                 2432    46        NA
#> 36 Belgium                 2359     8        NA
#> 37 Greece                  2322    43        NA
#> 38 Sri Lanka               2271   118        NA
#> 39 Switzerland             2267    11        NA
#> 40 Netherlands             2217     8        NA
#> # … with 155 more rows
```

Plotting the total cases by type worldwide:

``` r
library(plotly)

coronavirus %>% 
  group_by(type, date) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases) %>%
  arrange(date) %>%
  mutate(active = confirmed - death - recovered) %>%
  mutate(active_total = cumsum(active),
                recovered_total = cumsum(recovered),
                death_total = cumsum(death)) %>%
  plot_ly(x = ~ date,
                  y = ~ active_total,
                  name = 'Active', 
                  fillcolor = '#1f77b4',
                  type = 'scatter',
                  mode = 'none', 
                  stackgroup = 'one') %>%
  add_trace(y = ~ death_total, 
             name = "Death",
             fillcolor = '#E41317') %>%
  add_trace(y = ~recovered_total, 
            name = 'Recovered', 
            fillcolor = 'forestgreen') %>%
  layout(title = "Distribution of Covid19 Cases Worldwide",
         legend = list(x = 0.1, y = 0.9),
         yaxis = list(title = "Number of Cases"),
         xaxis = list(title = "Source: Johns Hopkins University Center for Systems Science and Engineering"))
```

<img src="man/figures/total_cases.svg" width="100%" />

Plot the confirmed cases distribution by counrty with treemap plot:

``` r
conf_df <- coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases) %>%
  mutate(parents = "Confirmed") %>%
  ungroup() 
  
  plot_ly(data = conf_df,
          type= "treemap",
          values = ~total_cases,
          labels= ~ country,
          parents=  ~parents,
          domain = list(column=0),
          name = "Confirmed",
          textinfo="label+value+percent parent")
```

<img src="man/figures/treemap_conf.svg" width="100%" />

``` r
data(covid19_vaccine)

head(covid19_vaccine)
#>   country_region       date doses_admin people_partially_vaccinated people_fully_vaccinated report_date_string uid province_state iso2 iso3 code3 fips      lat      long combined_key population
#> 1    Afghanistan 2021-02-22           0                           0                       0         2021-02-22   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 2    Afghanistan 2021-02-23           0                           0                       0         2021-02-23   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 3    Afghanistan 2021-02-24           0                           0                       0         2021-02-24   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 4    Afghanistan 2021-02-25           0                           0                       0         2021-02-25   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 5    Afghanistan 2021-02-26           0                           0                       0         2021-02-26   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 6    Afghanistan 2021-02-27           0                           0                       0         2021-02-27   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#>   continent_name continent_code
#> 1           Asia             AS
#> 2           Asia             AS
#> 3           Asia             AS
#> 4           Asia             AS
#> 5           Asia             AS
#> 6           Asia             AS
```

Plot the top 20 vaccinated countries:

``` r
covid19_vaccine %>% 
  filter(date == max(date),
         !is.na(population)) %>% 
  mutate(fully_vaccinated_ratio = people_fully_vaccinated / population) %>%
  arrange(- fully_vaccinated_ratio) %>%
  slice_head(n = 20) %>%
  arrange(fully_vaccinated_ratio) %>%
  mutate(country = factor(country_region, levels = country_region)) %>%
  plot_ly(y = ~ country,
          x = ~ round(100 * fully_vaccinated_ratio, 2),
          text = ~ paste(round(100 * fully_vaccinated_ratio, 1), "%"),
          textposition = 'auto',
          orientation = "h",
          type = "bar") %>%
  layout(title = "Percentage of Fully Vaccineted Population - Top 20 Countries",
         yaxis = list(title = ""),
         xaxis = list(title = "Source: Johns Hopkins Centers for Civic Impact",
                      ticksuffix = "%"))

```

<img src="man/figures/top20_countries.svg" width="100%" />

## Dashboard

**Note:** Currently, the dashboard is under maintenance due to recent
changes in the data structure. Please see this
[issue](https://github.com/RamiKrispin/coronavirus_dashboard/issues/25)

A supporting dashboard is available
[here](https://ramikrispin.github.io/coronavirus_dashboard/)

[<img src="man/figures/dashboard.png" width="100%" />](https://ramikrispin.github.io/coronavirus_dashboard/)

## Data Sources

The raw data pulled and arranged by the Johns Hopkins University Center
for Systems Science and Engineering (JHU CCSE) from the following
resources:

-   World Health Organization (WHO): <https://www.who.int/> <br>
-   DXY.cn. Pneumonia. 2020.
    <https://ncov.dxy.cn/ncovh5/view/pneumonia>. <br>
-   BNO News:
    <https://bnonews.com/index.php/2020/04/the-latest-coronavirus-cases/>
    <br>
-   National Health Commission of the People’s Republic of China (NHC):
    <br> http:://www.nhc.gov.cn/xcs/yqtb/list\_gzbd.shtml <br>
-   China CDC (CCDC):
    http:://weekly.chinacdc.cn/news/TrackingtheEpidemic.htm <br>
-   Hong Kong Department of Health:
    <https://www.chp.gov.hk/en/features/102465.html> <br>
-   Macau Government: <https://www.ssm.gov.mo/portal/> <br>
-   Taiwan CDC:
    <https://sites.google.com/cdc.gov.tw/2019ncov/taiwan?authuser=0>
    <br>
-   US CDC: <https://www.cdc.gov/coronavirus/2019-ncov/index.html> <br>
-   Government of Canada:
    <https://www.canada.ca/en/public-health/services/diseases/2019-novel-coronavirus-infection/symptoms.html>
    <br>
-   Australia Government Department of
    Health:<https://www.health.gov.au/news/health-alerts/novel-coronavirus-2019-ncov-health-alert>
    <br>
-   European Centre for Disease Prevention and Control (ECDC):
    <https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases>
-   Ministry of Health Singapore (MOH):
    <https://www.moh.gov.sg/covid-19>
-   Italy Ministry of Health:
    <https://www.salute.gov.it/nuovocoronavirus>
-   1Point3Arces: <https://coronavirus.1point3acres.com/en>
-   WorldoMeters: <https://www.worldometers.info/coronavirus/>
-   COVID Tracking Project: <https://covidtracking.com/data>. (US
    Testing and Hospitalization Data. We use the maximum reported value
    from “Currently” and “Cumulative” Hospitalized for our
    hospitalization number reported for each state.)
-   French Government: <https://dashboard.covid19.data.gouv.fr/>
-   COVID Live (Australia): <https://covidlive.com.au/>
-   Washington State Department of
    Health:<https://www.doh.wa.gov/Emergencies/COVID19>
-   Maryland Department of Health: <https://coronavirus.maryland.gov/>
-   New York State Department of Health:
    <https://health.data.ny.gov/Health/New-York-State-Statewide-COVID-19-Testing/xdss-u53e/data>
-   NYC Department of Health and Mental Hygiene:
    <https://www1.nyc.gov/site/doh/covid/covid-19-data.page> and
    <https://github.com/nychealth/coronavirus-data>
-   Florida Department of Health Dashboard:
    <https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/arcgis/rest/services/Florida_COVID19_Cases/FeatureServer/0>
    and
    <https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86>
-   Palestine (West Bank and Gaza): <https://corona.ps/details>
-   Israel:
    <https://govextra.gov.il/ministry-of-health/corona/corona-virus/>
-   Colorado: <https://covid19.colorado.gov/data>)
