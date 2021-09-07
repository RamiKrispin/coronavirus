
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
Coronavirus COVID-19 (2019-nCoV) epidemic. The raw data pulled from the
Johns Hopkins University Center for Systems Science and Engineering (JHU
CCSE) Coronavirus
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
#>         date    location location_type location_code location_code_type     data_type value      lat      long
#> 1 2020-03-15 Afghanistan       country            AF         iso_3166_2 recovered_new     0 33.93911 67.709953
#> 2 2021-01-31 Afghanistan       country            AF         iso_3166_2    deaths_new     0 33.93911 67.709953
#> 3 2021-02-02 Afghanistan       country            AF         iso_3166_2    deaths_new     1 33.93911 67.709953
#> 4 2021-01-30 Afghanistan       country            AF         iso_3166_2    deaths_new     1 33.93911 67.709953
#> 5 2020-03-14 Afghanistan       country            AF         iso_3166_2 recovered_new     0 33.93911 67.709953
#> 6 2020-03-16 Afghanistan       country            AF         iso_3166_2 recovered_new     1 33.93911 67.709953
```

## Dashboard

A supporting dashboard is available
[here](https://ramikrispin.github.io/coronavirus_dashboard/)

[<img src="man/figures/dashboard.png" width="100%" />](https://ramikrispin.github.io/coronavirus_dashboard/)

## Usage

``` r
data("coronavirus")
```

This `coronavirus` dataset has the following fields:

-   `date` - The date of the summary
-   `province` - The province or state, when applicable
-   `country` - The country or region name
-   `lat` - Latitude point
-   `long` - Longitude point
-   `type` - the type of case (i.e., confirmed, death)
-   `cases` - the number of daily cases (corresponding to the case type)

``` r
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
#>  1 US                39906426
#>  2 India             32988673
#>  3 Brazil            20877864
#>  4 United Kingdom     6973995
#>  5 France             6910865
#>  6 Russia             6894113
#>  7 Turkey             6412247
#>  8 Argentina          5202405
#>  9 Iran               5103537
#> 10 Colombia           4916980
#> 11 Spain              4877755
#> 12 Italy              4566126
#> 13 Indonesia          4123617
#> 14 Germany            4014858
#> 15 Mexico             3420880
#> 16 Poland             2890161
#> 17 South Africa       2814014
#> 18 Ukraine            2395616
#> 19 Peru               2154132
#> 20 Philippines        2061084
```

Summary of new cases during the past 24 hours by country and type (as of
2021-09-04):

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
#>    country        confirmed death recovered
#>    <chr>              <int> <int>     <int>
#>  1 US                 56170   527        NA
#>  2 India              42766   308        NA
#>  3 United Kingdom     36725   120        NA
#>  4 Brazil             21804   692        NA
#>  5 Philippines        20516   189        NA
#>  6 Iran               20404   515        NA
#>  7 Malaysia           19057   362        NA
#>  8 Russia             18400   776        NA
#>  9 Germany            18170    21        NA
#> 10 Japan              15999    60        NA
#> 11 Thailand           15942   257        NA
#> 12 Mexico             15586   647        NA
#> 13 France             13336    83        NA
#> 14 Vietnam             9521   347        NA
#> 15 South Africa        8410   182        NA
#> 16 Israel              7993    25        NA
#> 17 Cuba                7854    79        NA
#> 18 Pakistan            7727   140        NA
#> 19 Indonesia           6727   539        NA
#> 20 Italy               6156    56        NA
#> 21 Kazakhstan          4866     0        NA
#> 22 Iraq                4316    48        NA
#> 23 Morocco             4310    70        NA
#> 24 Portugal            3535    13        NA
#> 25 Serbia              3497    19        NA
#> 26 Azerbaijan          3305    40        NA
#> 27 Burma               3078   102        NA
#> 28 Netherlands         2816    12        NA
#> 29 Georgia             2684    83        NA
#> 30 Ukraine             2614    44        NA
#> 31 Guatemala           2556    48        NA
#> 32 Argentina           2486    88        NA
#> 33 Greece              2284   106        NA
#> 34 Tunisia             2209    63        NA
#> 35 Colombia            2099    72        NA
#> 36 Belarus             1946    12        NA
#> 37 Bangladesh          1743    61        NA
#> 38 Austria             1715     5        NA
#> 39 Ireland             1703     0        NA
#> 40 Australia           1670     3        NA
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
