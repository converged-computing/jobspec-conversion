#!/bin/bash
#FLUX: --job-name=psycho-lemon-3394
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
