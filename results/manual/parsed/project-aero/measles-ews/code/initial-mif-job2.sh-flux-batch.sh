#!/bin/bash
#FLUX --job-name=hairy-signal-2256
#FLUX -t=36000
#FLUX --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
