
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

The coronavirus package provides a tidy format dataset of the 2019 Novel
Coronavirus COVID-19 (2019-nCoV) epidemic. The raw data pulled from the
Johns Hopkins University Center for Systems Science and Engineering (JHU
CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

More details available
[here](https://ramikrispin.github.io/coronavirus/), and a `csv` format
of the package dataset available
[here](https://github.com/RamiKrispin/coronavirus-csv)

A summary dashboard is available
[here](https://ramikrispin.github.io/coronavirus_dashboard/)

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

<figcaption>

Source: Centers for Disease Control and Prevention’s Public Health Image
Library

</figcaption>

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

## Usage

The package contains a single dataset - `coronavirus`:

``` r
library(coronavirus) 

data("coronavirus")
```

This `coronavirus` dataset has the following fields:

``` r
head(coronavirus) 
#>   Province.State Country.Region     Lat     Long       date cases      type
#> 1                         Japan 36.0000 138.0000 2020-01-22     2 confirmed
#> 2                   South Korea 36.0000 128.0000 2020-01-22     1 confirmed
#> 3                      Thailand 15.0000 101.0000 2020-01-22     2 confirmed
#> 4          Anhui Mainland China 31.8257 117.2264 2020-01-22     1 confirmed
#> 5        Beijing Mainland China 40.1824 116.4142 2020-01-22    14 confirmed
#> 6      Chongqing Mainland China 30.0572 107.8740 2020-01-22     6 confirmed
tail(coronavirus) 
#>      Province.State Country.Region     Lat     Long       date cases      type
#> 3431       Shanghai Mainland China 31.2020 121.4491 2020-03-09     1 recovered
#> 3432         Shanxi Mainland China 37.5777 112.2922 2020-03-09     1 recovered
#> 3433        Sichuan Mainland China 30.6171 102.7103 2020-03-09     2 recovered
#> 3434         Taiwan         Taiwan 23.7000 121.0000 2020-03-09     2 recovered
#> 3435        Tianjin Mainland China 39.3054 117.3230 2020-03-09     2 recovered
#> 3436       Zhejiang Mainland China 29.1832 120.0934 2020-03-09    15 recovered
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [15]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <int>
#>  1 Mainland China confirmed       80735
#>  2 Mainland China recovered       58735
#>  3 Italy          confirmed        9172
#>  4 South Korea    confirmed        7478
#>  5 Iran           confirmed        7161
#>  6 Mainland China death            3120
#>  7 Iran           recovered        2394
#>  8 France         confirmed        1209
#>  9 Germany        confirmed        1176
#> 10 Spain          confirmed        1073
#> 11 Italy          recovered         724
#> 12 Others         confirmed         696
#> 13 US             confirmed         605
#> 14 Japan          confirmed         511
#> 15 Italy          death             463
#> 16 Switzerland    confirmed         374
#> 17 Netherlands    confirmed         321
#> 18 UK             confirmed         321
#> 19 Sweden         confirmed         248
#> 20 Belgium        confirmed         239
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-09):

``` r
library(tidyr)

coronavirus %>% 
  filter(date == max(date)) %>%
  select(country = Country.Region, type, cases) %>%
  group_by(country, type) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)
#> # A tibble: 49 x 4
#> # Groups:   country [49]
#>    country          confirmed recovered death
#>    <chr>                <int>     <int> <int>
#>  1 Italy                 1797       102    97
#>  2 Iran                   595       260    43
#>  3 Spain                  400         2    11
#>  4 South Korea            164        NA     3
#>  5 Germany                136        NA     2
#>  6 France                  83        NA    NA
#>  7 US                      68        NA     1
#>  8 Netherlands             56        NA    NA
#>  9 Denmark                 55        NA    NA
#> 10 UK                      48        NA     1
#> 11 Sweden                  45         1    NA
#> 12 Belgium                 39        NA    NA
#> 13 Switzerland             37        NA    NA
#> 14 Mainland China          36      1415    23
#> 15 Norway                  29         1    NA
#> 16 Austria                 27         2    NA
#> 17 Malaysia                18        NA    NA
#> 18 Australia               15        NA    NA
#> 19 Canada                  13        NA     1
#> 20 Indonesia               13        NA    NA
#> 21 Bahrain                 10        10    NA
#> 22 Philippines             10        NA    NA
#> 23 Japan                    9        NA    11
#> 24 Iceland                  8        NA    NA
#> 25 Finland                  7        NA    NA
#> 26 Egypt                    6        11    NA
#> 27 Brazil                   5        NA    NA
#> 28 Poland                   5        NA    NA
#> 29 Costa Rica               4        NA    NA
#> 30 India                    4        NA    NA
#> 31 Latvia                   4        NA    NA
#> 32 Saudi Arabia             4        NA    NA
#> 33 Qatar                    3        NA    NA
#> 34 Albania                  2        NA    NA
#> 35 Cyprus                   2        NA    NA
#> 36 Georgia                  2        NA    NA
#> 37 Hungary                  2        NA    NA
#> 38 Ireland                  2        NA    NA
#> 39 St. Martin               2        NA    NA
#> 40 Algeria                  1        NA    NA
#> 41 Brunei                   1        NA    NA
#> 42 Ecuador                  1        NA    NA
#> 43 Hong Kong                1         1    NA
#> 44 Nigeria                  1        NA    NA
#> 45 Peru                     1        NA    NA
#> 46 Saint Barthelemy        -2        NA    NA
#> 47 Belarus                 NA         1    NA
#> 48 Iraq                    NA         9    NA
#> 49 Taiwan                  NA         2    NA
```

## Data Sources

The raw data pulled and arranged by the Johns Hopkins University Center
for Systems Science and Engineering (JHU CCSE) from the following
resources:

  - World Health Organization (WHO): <https://www.who.int/> <br>
  - DXY.cn. Pneumonia. 2020. <http://3g.dxy.cn/newh5/view/pneumonia>.
    <br>
  - BNO News:
    <https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/>
    <br>
  - National Health Commission of the People’s Republic of China (NHC):
    http:://www.nhc.gov.cn/xcs/yqtb/list\_gzbd.shtml
  - China CDC (CCDC):
    http:://weekly.chinacdc.cn/news/TrackingtheEpidemic.htm <br>
  - Hong Kong Department of Health:
    <https://www.chp.gov.hk/en/features/102465.html> <br>
  - Macau Government: <https://www.ssm.gov.mo/portal/> <br>
  - Taiwan CDC:
    <https://sites.google.com/cdc.gov.tw/2019ncov/taiwan?authuser=0>
    <br>
  - US CDC: <https://www.cdc.gov/coronavirus/2019-ncov/index.html> <br>
  - Government of Canada:
    <https://www.canada.ca/en/public-health/services/diseases/coronavirus.html>
    <br>
  - Australia Government Department of Health:
    <https://www.health.gov.au/news/coronavirus-update-at-a-glance> <br>
  - European Centre for Disease Prevention and Control (ECDC):
    <https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases>
    <br>

<br>
