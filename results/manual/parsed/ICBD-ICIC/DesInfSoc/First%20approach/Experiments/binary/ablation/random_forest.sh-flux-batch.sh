#!/bin/bash
#FLUX: --job-name=itrust-random_forest
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --priority=16

source ../../.experiments_env/bin/activate
srun python random_forest.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY no-personality
