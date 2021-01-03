
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://RamiKrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
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
#>         date    location location_type location_code location_code_type  data_type value      lat      long
#> 1 2020-04-05 Afghanistan       country            AF         iso_3166_2  cases_new    38 33.93911 67.709953
#> 2 2020-08-12 Afghanistan       country            AF         iso_3166_2 deaths_new    10 33.93911 67.709953
#> 3 2020-08-10 Afghanistan       country            AF         iso_3166_2 deaths_new     8 33.93911 67.709953
#> 4 2020-08-15 Afghanistan       country            AF         iso_3166_2  cases_new    45 33.93911 67.709953
#> 5 2020-10-09 Afghanistan       country            AF         iso_3166_2  cases_new    77 33.93911 67.709953
#> 6 2020-04-03 Afghanistan       country            AF         iso_3166_2  cases_new    35 33.93911 67.709953
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
#>         date province     country      lat      long      type cases
#> 1 2020-01-22          Afghanistan 33.93911 67.709953 confirmed     0
#> 2 2020-01-23          Afghanistan 33.93911 67.709953 confirmed     0
#> 3 2020-01-24          Afghanistan 33.93911 67.709953 confirmed     0
#> 4 2020-01-25          Afghanistan 33.93911 67.709953 confirmed     0
#> 5 2020-01-26          Afghanistan 33.93911 67.709953 confirmed     0
#> 6 2020-01-27          Afghanistan 33.93911 67.709953 confirmed     0
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
#>  1 US                19968087
#>  2 India             10266674
#>  3 Brazil             7675973
#>  4 Russia             3127347
#>  5 France             2677666
#>  6 United Kingdom     2496231
#>  7 Turkey             2208652
#>  8 Italy              2107166
#>  9 Spain              1928265
#> 10 Germany            1760520
#> 11 Colombia           1642775
#> 12 Argentina          1625514
#> 13 Mexico             1426094
#> 14 Poland             1294878
#> 15 Iran               1225142
#> 16 Ukraine            1086997
#> 17 South Africa       1057161
#> 18 Peru               1015137
#> 19 Netherlands         808382
#> 20 Indonesia           743198
```

Summary of new cases during the past 24 hours by country and type (as of
2020-12-31):

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
#> # A tibble: 191 x 4
#> # Groups:   country [191]
#>    country        confirmed death recovered
#>    <chr>              <int> <int>     <int>
#>  1 US                227315  3419         0
#>  2 Brazil             56773  1074     34752
#>  3 United Kingdom     56029   965        65
#>  4 Russia             27329   579     28257
#>  5 Italy              23477   555     17421
#>  6 France             20042   251      1176
#>  7 Germany            19367   561      4756
#>  8 Spain              18047   148         0
#>  9 South Africa       18000   436     12074
#> 10 Czechia            17039   151      8098
#> 11 Colombia           16314   304     11239
#> 12 Turkey             14380   239     22021
#> 13 Poland             13464   535     10249
#> 14 Mexico             12159   910      8024
#> 15 Argentina          11586    82         0
#> 16 Ukraine            10117   223     12468
#> 17 Netherlands         9790   108       196
#> 18 Indonesia           8074   194      7356
#> 19 Portugal            7627    76      3260
#> 20 Canada              7143   134      3409
#> 21 Israel              6678    18      4037
#> 22 Iran                6389   128     10119
#> 23 Slovakia            6315    73      1544
#> 24 Peru                4641   106         0
#> 25 Japan               4540    49      1985
#> 26 Switzerland         4391    51         0
#> 27 Romania             4322   171      6737
#> 28 Panama              4046    47      2537
#> 29 Lebanon             3507    12      1499
#> 30 Hungary             2971   108      5868
#> 31 Serbia              2932    48         0
#> 32 Austria             2913    73      1962
#> 33 Malaysia            2525     8      1481
#> 34 Pakistan            2463    71      2156
#> 35 Slovenia            2412    32      1616
#> 36 Croatia             2391    60      1733
#> 37 Lithuania           2360    36      4543
#> 38 Belgium             2254    87         0
#> 39 Denmark             2254    42      4329
#> 40 Chile               2023   109      1787
#> # … with 151 more rows
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

<img src="man/figures/total_cases.png" width="100%" />

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

<img src="man/figures/treemap_conf.png" width="100%" />

## Data Sources

The raw data pulled and arranged by the Johns Hopkins University Center
for Systems Science and Engineering (JHU CCSE) from the following
resources:

-   World Health Organization (WHO): <https://www.who.int/> <br>
-   DXY.cn. Pneumonia. 2020. <http://3g.dxy.cn/newh5/view/pneumonia>.
    <br>
-   BNO News:
    <https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/>
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
    <https://www.canada.ca/en/public-health/services/diseases/coronavirus.html>
    <br>
-   Australia Government Department of Health:
    <https://www.health.gov.au/news/coronavirus-update-at-a-glance> <br>
-   European Centre for Disease Prevention and Control (ECDC):
    <https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases>
-   Ministry of Health Singapore (MOH):
    <https://www.moh.gov.sg/covid-19>
-   Italy Ministry of Health:
    <http://www.salute.gov.it/nuovocoronavirus>
-   1Point3Arces: <https://coronavirus.1point3acres.com/en>
-   WorldoMeters: <https://www.worldometers.info/coronavirus/>
-   COVID Tracking Project: <https://covidtracking.com/data>. (US
    Testing and Hospitalization Data. We use the maximum reported value
    from “Currently” and “Cumulative” Hospitalized for our
    hospitalization number reported for each state.)
-   French Government: <https://dashboard.covid19.data.gouv.fr/>
-   COVID Live (Australia): <https://www.covidlive.com.au/>
-   Washington State Department of Health:
    <https://www.doh.wa.gov/emergencies/coronavirus>
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
-   Colorado: <https://covid19.colorado.gov/covid-19-data>
