#!/bin/bash
#FLUX: --job-name=itrust-logistic_regression
#FLUX: -t=3600
#FLUX: --urgency=16

source ../.experiments_env/bin/activate
srun python logistic_regression.py ${SLURM_ARRAY_TASK_ID} context2_ONLY-ACTION-SPREAD20_K3_H4_P12-BINARY
