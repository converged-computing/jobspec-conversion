#!/bin/bash
#FLUX: --job-name=arid-soup-1568
#FLUX: -n=100
#FLUX: -t=10800
#FLUX: --urgency=16

module load python/3.10
module load scipy-stack
srun python3 MPI.py --part=$SLURM_ARRAY_TASK_ID
