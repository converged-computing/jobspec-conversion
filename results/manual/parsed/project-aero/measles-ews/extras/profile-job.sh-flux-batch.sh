#!/bin/bash
#FLUX: --job-name=placid-carrot-4830
#FLUX: -t=288000
#FLUX: --urgency=16

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID likelihood-profile-mifs.R
