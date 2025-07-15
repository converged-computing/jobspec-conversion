#!/bin/bash
#FLUX: --job-name=itrust-decision_tree
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

source ../../.experiments_env/bin/activate
srun python decision_tree.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY no-personality
