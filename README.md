
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://ramikrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

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
#>   Province.State Country.Region Lat Long       date cases      type
#> 1                   Afghanistan  33   65 2020-01-22     0 confirmed
#> 2                   Afghanistan  33   65 2020-01-23     0 confirmed
#> 3                   Afghanistan  33   65 2020-01-24     0 confirmed
#> 4                   Afghanistan  33   65 2020-01-25     0 confirmed
#> 5                   Afghanistan  33   65 2020-01-26     0 confirmed
#> 6                   Afghanistan  33   65 2020-01-27     0 confirmed
tail(coronavirus) 
#>       Province.State Country.Region     Lat     Long       date cases      type
#> 36031       Zhejiang          China 29.1832 120.0934 2020-03-08     7 recovered
#> 36032       Zhejiang          China 29.1832 120.0934 2020-03-09    15 recovered
#> 36033       Zhejiang          China 29.1832 120.0934 2020-03-10    15 recovered
#> 36034       Zhejiang          China 29.1832 120.0934 2020-03-11     4 recovered
#> 36035       Zhejiang          China 29.1832 120.0934 2020-03-12     2 recovered
#> 36036       Zhejiang          China 29.1832 120.0934 2020-03-13     0 recovered
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
#>  1 China          confirmed       80945
#>  2 China          recovered       64196
#>  3 Italy          confirmed       17660
#>  4 Iran           confirmed       11364
#>  5 Korea, South   confirmed        7979
#>  6 Spain          confirmed        5232
#>  7 Germany        confirmed        3675
#>  8 France         confirmed        3667
#>  9 China          death            3180
#> 10 Iran           recovered        2959
#> 11 US             confirmed        2179
#> 12 Italy          recovered        1439
#> 13 Italy          death            1266
#> 14 Switzerland    confirmed        1139
#> 15 Norway         confirmed         996
#> 16 Sweden         confirmed         814
#> 17 Denmark        confirmed         804
#> 18 Netherlands    confirmed         804
#> 19 United Kingdom confirmed         801
#> 20 Japan          confirmed         701
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-13):

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
#> # A tibble: 125 x 4
#> # Groups:   country [125]
#>    country        confirmed death recovered
#>    <chr>              <int> <int>     <int>
#>  1 Italy               5198   439       394
#>  2 Spain               2955    78        10
#>  3 Germany             1597     4        21
#>  4 France              1383    31         0
#>  5 Iran                1289    85         0
#>  6 US                   516     7         0
#>  7 Switzerland          487     7         0
#>  8 United Kingdom       342     0         0
#>  9 Netherlands          301     5         0
#> 10 Norway               294     0         0
#> 11 Belgium              245     0         0
#> 12 Sweden               215     0         0
#> 13 Austria              202     0         2
#> 14 Denmark              187     0         0
#> 15 Korea, South         110     0       177
#> 16 Brazil                99     0         0
#> 17 Finland               96     0         0
#> 18 Greece                91     0         0
#> 19 Canada                76     0         0
#> 20 Australia             72     0         2
#> 21 Estonia               63     0         0
#> 22 Japan                 62     3         0
#> 23 Qatar                 58     0         0
#> 24 Portugal              53     0         1
#> 25 Slovenia              52     0         0
#> 26 Malaysia              48     0         0
#> 27 Czechia               47     0         0
#> 28 Ireland               47     0         0
#> 29 Saudi Arabia          41     0         0
#> 30 Romania               40     0         1
#> 31 Indonesia             35     3         0
#> 32 Iceland               31     0         0
#> 33 Iraq                  30     1         9
#> 34 Israel                30     0         0
#> 35 Brunei                26     0         0
#> 36 Singapore             22     0         1
#> 37 Chile                 20     0         0
#> 38 Poland                19     1         0
#> 39 Russia                17     0         0
#> 40 Bulgaria              16     0         0
#> # … with 85 more rows
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
