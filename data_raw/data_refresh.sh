#!/bin/bash

echo "Updating the total dataset"

 Rscript -e "source('./data_raw/data_refresh.R');
             data_refresh(env = '$1');
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
