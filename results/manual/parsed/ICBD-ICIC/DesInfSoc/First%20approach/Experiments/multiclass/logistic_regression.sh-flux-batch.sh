#!/bin/bash
#FLUX: --job-name=itrust-logistic_regression
#FLUX: -t=3600
#FLUX: --priority=16

dataset="$1"
source ../.experiments_env/bin/activate
srun python logistic_regression.py ${SLURM_ARRAY_TASK_ID} "$dataset"
