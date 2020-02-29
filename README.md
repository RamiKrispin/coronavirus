
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
#> 2304         Shanxi Mainland China 37.5777 112.2922 2020-02-28     5 recovered
#> 2305        Sichuan Mainland China 30.6171 102.7103 2020-02-28    17 recovered
#> 2306         Taiwan         Taiwan 23.7000 121.0000 2020-02-28     1 recovered
#> 2307       Xinjiang Mainland China 41.1129  85.2401 2020-02-28     9 recovered
#> 2308         Yunnan Mainland China 24.9740 101.4870 2020-02-28     6 recovered
#> 2309       Zhejiang Mainland China 29.1832 120.0934 2020-02-28    43 recovered
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [14]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <int>
#>  1 Mainland China confirmed       78824
#>  2 Mainland China recovered       36291
#>  3 Mainland China death            2788
#>  4 South Korea    confirmed        2337
#>  5 Italy          confirmed         888
#>  6 Others         confirmed         705
#>  7 Iran           confirmed         388
#>  8 Japan          confirmed         228
#>  9 Hong Kong      confirmed          94
#> 10 Singapore      confirmed          93
#> 11 Iran           recovered          73
#> 12 Singapore      recovered          62
#> 13 US             confirmed          62
#> 14 France         confirmed          57
#> 15 Germany        confirmed          48
#> 16 Italy          recovered          46
#> 17 Kuwait         confirmed          45
#> 18 Thailand       confirmed          41
#> 19 Bahrain        confirmed          36
#> 20 Iran           death              34
```

Summary of new cases during the past 24 hours by country and type (as of
2020-02-28):

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
#> # A tibble: 32 x 4
#> # Groups:   country [32]
#>    country              confirmed recovered death
#>    <chr>                    <int>     <int> <int>
#>  1 South Korea                571        NA    NA
#>  2 Mainland China             326      3393    44
#>  3 Italy                      233         1     4
#>  4 Iran                       143        24     8
#>  5 France                      19        NA    NA
#>  6 Spain                       17        NA    NA
#>  7 Japan                       14        NA    NA
#>  8 United Arab Emirates         6         1    NA
#>  9 Norway                       5        NA    NA
#> 10 UK                           5        NA    NA
#> 11 Bahrain                      3        NA    NA
#> 12 Croatia                      2        NA    NA
#> 13 Germany                      2        NA    NA
#> 14 Hong Kong                    2         6    NA
#> 15 Kuwait                       2        NA    NA
#> 16 Romania                      2        NA    NA
#> 17 Taiwan                       2         1    NA
#> 18 US                           2         1    NA
#> 19 Azerbaijan                   1        NA    NA
#> 20 Belarus                      1        NA    NA
#> 21 Canada                       1        NA    NA
#> 22 Greece                       1        NA    NA
#> 23 Iceland                      1        NA    NA
#> 24 Israel                       1        NA    NA
#> 25 Lithuania                    1        NA    NA
#> 26 Mexico                       1        NA    NA
#> 27 New Zealand                  1        NA    NA
#> 28 Nigeria                      1        NA    NA
#> 29 North Ireland                1        NA    NA
#> 30 Thailand                     1         6    NA
#> 31 Egypt                       NA         1    NA
#> 32 Others                      NA        NA    -3
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
