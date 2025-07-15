#!/bin/bash
#FLUX: --job-name=sticky-carrot-7660
#FLUX: --priority=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID global-search-mif.R
