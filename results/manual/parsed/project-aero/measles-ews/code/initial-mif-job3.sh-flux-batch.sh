#!/bin/bash
#FLUX: --job-name=joyous-spoon-0414
#FLUX: -t=36000
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
