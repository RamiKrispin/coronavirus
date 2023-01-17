#!/bin/bash

echo "Updating the total dataset"

quarto render ./data_pipelines/covid19_cases.qmd --to html
quarto render ./data_pipelines/vaccine_data.qmd --to html

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
