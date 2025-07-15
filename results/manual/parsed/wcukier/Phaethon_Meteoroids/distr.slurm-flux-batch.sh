#!/bin/bash
#FLUX: --job-name=distr
#FLUX: -t=14340
#FLUX: --urgency=16

module purge
module load anaconda3/2021.5
python main.py $SLURM_ARRAY_TASK_ID 2 100 2000
