#!/bin/bash
#FLUX: --job-name=portal_weekly_forecast
#FLUX: --queue=hpg2-compute
#FLUX: -t=10800
#FLUX: --urgency=16

date;hostname;pwd
source /etc/profile.d/modules.sh
module load git R singularity
rm -f portal_predictions_latest.sif
rm -rf pp_stack_test
rm -rf forecasts
singularity pull docker://weecology/portal_predictions
git clone https://github.com/weecology/pp_stack_test.git
cd pp_stack_test
singularity run ../portal_predictions_latest.sif Rscript stack_test.R
singularity run ../portal_predictions_latest.sif Rscript tests/testthat.R > ../testthat.log 2>&1
singularity run ../portal_predictions_latest.sif bash archive_hipergator.sh
