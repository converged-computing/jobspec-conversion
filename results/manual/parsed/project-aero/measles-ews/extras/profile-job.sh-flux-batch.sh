#!/bin/bash
#FLUX: --job-name=grated-toaster-4115
#FLUX: --priority=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID likelihood-profile-mifs.R
