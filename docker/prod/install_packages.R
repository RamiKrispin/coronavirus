# installing package imports packages
pkg_list <- c("pkgdown",
              "dplyr",
              "tibble",
              "devtools",
              "here",
              "lubridate",
              "magrittr",
              "purrr",
              "rmarkdown",
              "markdown",
              "tidyr",
              "testthat",
              "readr",
              "plotly",
              "DT",
              "remotes",
              "rcmdcheck",
              "Rcpp",
              "usethis",
              "qpdf",
              "reactable",
              "htmltools"
)


for(i in pkg_list){

  if(!i %in% rownames(installed.packages())){
    cat(paste0("\033[0;", 42, "m","Installing ", i,"\033[0m","\n"))
    install.packages(pkgs = i, repos = "https://cran.rstudio.com/")
  }


  if(!i %in% rownames(installed.packages())){
    stop(paste("Package", i, "is not available"))
  }
}

