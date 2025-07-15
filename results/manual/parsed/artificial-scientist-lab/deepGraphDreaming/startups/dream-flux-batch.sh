#!/bin/bash
#FLUX: --job-name=expensive-lamp-5978
#FLUX: -t=86400
#FLUX: --priority=16

module load python/3.9
module load scipy-stack
source env/bin/activate
srun python dream.py $SLURM_ARRAY_TASK_ID
