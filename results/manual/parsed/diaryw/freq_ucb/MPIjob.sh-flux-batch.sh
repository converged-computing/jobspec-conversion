#!/bin/bash
#FLUX: --job-name=blank-onion-3112
#FLUX: -n=100
#FLUX: -t=10800
#FLUX: --urgency=16

module load python/3.10
module load scipy-stack
srun python3 MPI.py --part=$SLURM_ARRAY_TASK_ID
