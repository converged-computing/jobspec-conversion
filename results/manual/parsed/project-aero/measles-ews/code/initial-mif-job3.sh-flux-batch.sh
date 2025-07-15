#!/bin/bash
#FLUX: --job-name=stanky-hippo-9179
#FLUX: --priority=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
