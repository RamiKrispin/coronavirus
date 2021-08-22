### Package Development Environment

The docker folder has three sub-folders each with the docker builds:

* `dev` - development environment for developing and testing the docker images for Github Actions. Currently using R version 4.1.0
* `prod` - production environment for  deploying in Github Actions
* `rstudio` - a docker with RStudio and the packages dependencies for development environment


For launching the RStudion on the docker environment use on the terminal:

``` bash
docker run --rm -p 8787:8787 -e PASSWORD=YOUR_PASSWORD -e USER=YOUR_USERNAME-v ~/YOUR_coronavirus_PATH:/home/rstudio/coronavirus rkrispin/corona_rstudio:dev
```

Where the `PASSWORD` and `USER` arguments set the password and username for login to RStudio, and `~/YOUR_coronavirus_PATH` is the corresponding path of the package on your machine. The docker is set to `8787`. Once the docker is launch you can login to RStudio on your browser using the following address `http://localhost:8787/`

