#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: --queue=shared
#FLUX: -t=1380
#FLUX: --urgency=16

module load python/3.8.5-fasrc01
source activate pt38
srun -c 1 python quick_train.py newloss_"${SLURM_JOB_ID}"_"${SLURM_ARRAY_TASK_ID}" -k ${SLURM_ARRAY_TASK_ID} -t 1
