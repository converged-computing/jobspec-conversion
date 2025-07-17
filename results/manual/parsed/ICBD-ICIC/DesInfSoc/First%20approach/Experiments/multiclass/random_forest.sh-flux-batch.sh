#!/bin/bash
#FLUX: --job-name=itrust-random_forest
#FLUX: -t=3600
#FLUX: --urgency=16

dataset="$1"
source ../.experiments_env/bin/activate
srun python random_forest.py ${SLURM_ARRAY_TASK_ID} "$dataset"
