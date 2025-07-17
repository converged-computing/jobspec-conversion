#!/bin/bash
#FLUX: --job-name=itrust-decision_tree
#FLUX: -t=3600
#FLUX: --urgency=16

dataset="$1"
source ../.experiments_env/bin/activate
srun python decision_tree.py ${SLURM_ARRAY_TASK_ID} "$dataset"
