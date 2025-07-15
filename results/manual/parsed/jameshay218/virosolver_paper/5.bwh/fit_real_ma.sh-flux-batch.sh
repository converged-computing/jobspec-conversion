#!/bin/bash
#FLUX: --job-name=fugly-signal-1333
#FLUX: --priority=16

export R_LIBS_USER='$HOME/apps/R_4.0.2'

echo $SLURM_ARRAY_TASK_ID
mkdir -p jobout/${SLURM_JOB_NAME}
module load gcc/9.3.0-fasrc01 #Load gcc
module load R/4.0.2-fasrc01 #Load R module
export R_LIBS_USER=$HOME/apps/R_4.0.2
R CMD BATCH --quiet --no-restore --no-save 5.bwh/5.fit_ma_gp.R jobout/${SLURM_JOB_NAME}/BWH_${SLURM_ARRAY_TASK_ID}.Rout
