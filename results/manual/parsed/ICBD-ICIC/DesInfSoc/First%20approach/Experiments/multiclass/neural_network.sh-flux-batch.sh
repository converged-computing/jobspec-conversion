#!/bin/bash
#FLUX: --job-name=itrust-neural_network
#FLUX: -t=3600
#FLUX: --urgency=16

dataset="$1"
source ../.experiments_env/bin/activate
srun python neural_network.py ${SLURM_ARRAY_TASK_ID} "$dataset"
