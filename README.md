
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
#>             Province.State      Country.Region     Lat      Long       date cases  type
#> 3713     Placer County, CA                  US 39.0916 -120.8039 2020-03-10    -1 death
#> 3714 Santa Rosa County, FL                  US 30.7690  -86.9824 2020-03-10    -1 death
#> 3715  Snohomish County, WA                  US 48.0330 -121.8339 2020-03-10    -1 death
#> 3716                Taiwan Taipei and environs 23.7000  121.0000 2020-03-10     1 death
#> 3717                Taiwan              Taiwan 23.7000  121.0000 2020-03-10    -1 death
#> 3718            Washington                  US 47.4009 -121.4905 2020-03-10    23 death
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [16]
#>    Country.Region             type      total_cases
#>    <chr>                      <chr>           <dbl>
#>  1 Mainland China             confirmed       80757
#>  2 Mainland China             recovered       58735
#>  3 Italy                      confirmed       10149
#>  4 Iran (Islamic Republic of) confirmed        8042
#>  5 Republic of Korea          confirmed        7513
#>  6 Mainland China             death            3136
#>  7 Iran                       recovered        2394
#>  8 France                     confirmed        1784
#>  9 Spain                      confirmed        1695
#> 10 Germany                    confirmed        1457
#> 11 US                         confirmed         959
#> 12 Italy                      recovered         724
#> 13 Others                     confirmed         696
#> 14 Italy                      death             631
#> 15 Japan                      confirmed         581
#> 16 Switzerland                confirmed         491
#> 17 Norway                     confirmed         400
#> 18 Netherlands                confirmed         382
#> 19 UK                         confirmed         382
#> 20 Sweden                     confirmed         355
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-10):

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
#> # A tibble: 93 x 3
#> # Groups:   country [93]
#>    country                        confirmed death
#>    <chr>                              <dbl> <dbl>
#>  1 Iran (Islamic Republic of)          8042   291
#>  2 Republic of Korea                   7513    54
#>  3 Italy                                977   168
#>  4 Spain                                622     7
#>  5 France                               575    14
#>  6 US                                   354     6
#>  7 Germany                              281    NA
#>  8 Norway                               195    NA
#>  9 Denmark                              172    NA
#> 10 Hong Kong SAR                        120     3
#> 11 Switzerland                          117     1
#> 12 Sweden                               107    NA
#> 13 Japan                                 70    -7
#> 14 Netherlands                           61     1
#> 15 UK                                    61     2
#> 16 Austria                               51    NA
#> 17 Taipei and environs                   47     1
#> 18 Viet Nam                              31    NA
#> 19 United Arab Emirates                  29    NA
#> 20 Belgium                               28    NA
#> 21 occupied Palestinian territory        25    NA
#> 22 Mainland China                        22    16
#> 23 Israel                                19    NA
#> 24 Australia                             16    -1
#> 25 Greece                                16    NA
#> 26 Bahrain                               15    NA
#> 27 San Marino                            15     1
#> 28 Slovenia                              15    NA
#> 29 India                                 13    NA
#> 30 Ireland                               13    NA
#> 31 Philippines                           13    NA
#> 32 Malaysia                              12    NA
#> 33 Iceland                               11    NA
#> 34 Iraq                                  11     1
#> 35 Portugal                              11    NA
#> 36 Czech Republic                        10    NA
#> 37 Finland                               10    NA
#> 38 Macao SAR                             10    NA
#> 39 Pakistan                              10    NA
#> 40 Romania                               10    NA
#> 41 Russian Federation                    10    NA
#> 42 Singapore                             10    NA
#> 43 Lebanon                                9     1
#> 44 Albania                                8    NA
#> 45 Indonesia                              8    NA
#> 46 Brazil                                 6    NA
#> 47 Poland                                 6    NA
#> 48 Qatar                                  6    NA
#> 49 Argentina                              5    NA
#> 50 Chile                                  5    NA
#> 51 Kuwait                                 5    NA
#> 52 Saudi Arabia                           5    NA
#> 53 Egypt                                  4    NA
#> 54 North Macedonia                        4    NA
#> 55 Peru                                   4    NA
#> 56 Serbia                                 4    NA
#> 57 Slovakia                               4    NA
#> 58 South Africa                           4    NA
#> 59 Belarus                                3    NA
#> 60 Republic of Moldova                    3    NA
#> 61 Thailand                               3    NA
#> 62 Tunisia                                3    NA
#> 63 Azerbaijan                             2    NA
#> 64 Bosnia and Herzegovina                 2    NA
#> 65 Canada                                 2    NA
#> 66 Colombia                               2    NA
#> 67 Croatia                                2    NA
#> 68 Estonia                                2    NA
#> 69 Latvia                                 2    NA
#> 70 Luxembourg                             2    NA
#> 71 Maldives                               2    NA
#> 72 Malta                                  2    NA
#> 73 Oman                                   2    NA
#> 74 Saint Martin                           2    NA
#> 75 Afghanistan                            1    NA
#> 76 Burkina Faso                           1    NA
#> 77 Channel Islands                        1    NA
#> 78 Cyprus                                 1    NA
#> 79 Holy See                               1    NA
#> 80 Mongolia                               1    NA
#> 81 Morocco                                1     1
#> 82 Panama                                 1    NA
#> 83 Moldova                               -1    NA
#> 84 Vatican City                          -1    NA
#> 85 St. Martin                            -2    NA
#> 86 Macau                                -10    NA
#> 87 Russia                               -17    NA
#> 88 Palestine                            -22    NA
#> 89 Vietnam                              -30    NA
#> 90 Taiwan                               -45    -1
#> 91 Hong Kong                           -115    -3
#> 92 Iran                               -7161  -237
#> 93 South Korea                        -7478   -53
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
