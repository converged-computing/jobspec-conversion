#!/bin/bash
#FLUX: --job-name=itrust-naive_bayes
#FLUX: -t=3600
#FLUX: --urgency=16

dataset="$1"
source ../.experiments_env/bin/activate
srun python naive_bayes.py ${SLURM_ARRAY_TASK_ID} "$dataset"
