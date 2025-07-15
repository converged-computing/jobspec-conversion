#!/bin/bash
#FLUX: --job-name=angry-malarkey-0876
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
