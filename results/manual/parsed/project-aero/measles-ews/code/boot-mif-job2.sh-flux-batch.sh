#!/bin/bash
#FLUX: --job-name=gloopy-diablo-7184
#FLUX: --priority=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID bootstrap-fit-mif.R
