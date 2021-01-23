# installing package imports packages
pkg_list <- c("dplyr",
              "tibble",
              "devtools",
              "here",
              "lubridate",
              "magrittr",
              "purrr",
              "rmarkdown",
              "tidyr",
              "testthat",
              "readr",
              "usethis"
              )



for(i in pkg_list){

  if(!i %in% rownames(installed.packages())){

    install.packages(pkgs = i,
                     repos = "https://cran.rstudio.com/",
                     dependencies = TRUE)
  }
}

flag <- FALSE

for(i in pkg_list){

  if(!i %in% rownames(installed.packages())){
    cat(i, "...Failed\n")
    flag <- TRUE
  } else {
    cat(i, "...OK\n")
  }
}

if(flag){
  stop("Failed to install one or more packages...")
}

