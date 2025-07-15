#!/bin/bash
#FLUX: --job-name=itrust-random_forest
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --priority=16

source ../.experiments_env/bin/activate
srun python random_forest.py ${SLURM_ARRAY_TASK_ID} context2_ONLY-ACTION-SPREAD20_K3_H4_P12-BINARY
