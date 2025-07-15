#!/bin/bash
#FLUX: --job-name=rainbow-cherry-0169
#FLUX: --priority=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID bootstrap-fit-mif.R
