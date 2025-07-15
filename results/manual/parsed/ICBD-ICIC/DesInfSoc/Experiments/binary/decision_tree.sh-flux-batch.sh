#!/bin/bash
#FLUX: --job-name=itrust-decision_tree
#FLUX: -t=3600
#FLUX: --priority=16

source ../.experiments_env/bin/activate
srun python decision_tree.py ${SLURM_ARRAY_TASK_ID} context2_ONLY-ACTION-SPREAD20_K3_H4_P12-BINARY
