#!/bin/bash
#FLUX: --job-name=strawberry-leg-6628
#FLUX: -t=36000
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
