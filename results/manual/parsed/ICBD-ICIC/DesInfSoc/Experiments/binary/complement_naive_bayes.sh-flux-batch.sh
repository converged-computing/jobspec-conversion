#!/bin/bash
#FLUX: --job-name=itrust-complement_naive_bayes
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

source ../.experiments_env/bin/activate
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context2_ONLY-ACTION-SPREAD20_K3_H4_P12-BINARY
