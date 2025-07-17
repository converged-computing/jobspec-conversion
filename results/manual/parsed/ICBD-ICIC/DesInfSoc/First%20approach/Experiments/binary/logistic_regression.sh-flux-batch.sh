#!/bin/bash
#FLUX: --job-name=itrust-logistic_regression
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --urgency=16

source ../.experiments_env/bin/activate
srun python logistic_regression.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY
