#!/bin/bash
#FLUX: --job-name=nerdy-frito-1332
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID bootstrap-fit-mif.R
