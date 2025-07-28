#!/bin/bash
#FLUX: --job-name=dinosaur-nalgas-2184
#FLUX: -t=288000
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID likelihood-profile-mifs.R
