#!/bin/bash

echo "Updating the total dataset"

 Rscript -e "source('./data_raw/data_refresh.R');
             rmarkdown::render(input = './data_pipelines/covid19_cases.Rmd', knit_root_dir = '.', output_dir = './docs/data_pipelines');
             rmarkdown::render(input = './data_pipelines/vaccine_data.Rmd', knit_root_dir = '.', output_dir = './docs/data_pipelines');"

if [[ "$(git status --porcelain)" != "" ]]; then
    git config --global user.name 'RamiKrispin'
    git config --global user.email 'ramkrisp@umich.edu'
    git add csv/*.csv
    git add data/*.rda
    git add data_pipelines/*.*
    git add docs/data_pipelines/*.html
    git commit -m "Auto update coronavirus data"
    git push
fi
