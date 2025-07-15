#!/bin/bash
#FLUX: --job-name=advice-fit
#FLUX: --queue=c2_cpu
#FLUX: --urgency=16

SUBJECT=$1
export SUBJECT
INPUT_DIRECTORY=$2
export INPUT_DIRECTORY
RESULTS=$3
export RESULTS
module load matlab/2022a
run_file='/media/labs/rsmith/lab-members/cgoldman/Wellbeing/advise_task/scripts/main_advise_recover.m'
matlab -nodisplay -nosplash < ${run_file}
