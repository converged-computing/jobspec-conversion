#!/bin/bash
#FLUX: --job-name=itrust-random_forest
#FLUX: -t=600
#FLUX: --priority=16

features="$1"
source ../../.experiments_env/bin/activate
srun python random_forest.py ${SLURM_ARRAY_TASK_ID} context_SPREAD20_K3_H4_P12-BINARY "$features"
