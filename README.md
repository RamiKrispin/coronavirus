
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus

<!-- badges: start -->

<!-- badges: end -->

The coronavirus package provides a formated irregular time series
dataset of the 2019 Novel Coronavirus COVID-19 (2019-nCoV) epidemic. The
raw data pulled from the Johns Hopkins University Center for Systems
Science and Engineering (JHU CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

## Installation

You can install the released version of coronavirus from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("coronavirus")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("RamiKrispin/coronavirus")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(coronavirus)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
