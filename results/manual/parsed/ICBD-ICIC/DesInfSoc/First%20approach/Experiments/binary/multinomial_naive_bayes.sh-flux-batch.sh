#!/bin/bash
#FLUX: --job-name=itrust-multinomial_naive_bayes
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

source ../.experiments_env/bin/activate
srun python multinomial_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY
