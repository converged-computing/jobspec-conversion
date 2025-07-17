#!/bin/bash
#FLUX: --job-name=dream_output
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.9
module load scipy-stack
source env/bin/activate
srun python dream.py $SLURM_ARRAY_TASK_ID
