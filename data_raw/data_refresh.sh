#!/bin/bash

echo "Updating the total dataset"

 Rscript -e "source('./data_raw/data_refresh.R');
             rmarkdown::render(input = './data_pipelines/covid19_cases.Rmd', knit_root_dir = '.', output_dir = './docs/data_pipelines');
             data_refresh_vaccine(url = 'https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/global_data/time_series_covid19_vaccine_global.csv',
                                  env = '$1');"

if [[ "$(git status --porcelain)" != "" ]]; then
    git config --global user.name 'RamiKrispin'
    git config --global user.email 'ramkrisp@umich.edu'
    git add csv/*.csv
    git add data/*.rda
    git commit -m "Auto update coronavirus data"
    git push
fi
