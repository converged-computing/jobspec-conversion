#!/bin/bash
#FLUX: --job-name=novel
#FLUX: -t=10920
#FLUX: --priority=16

module purge
module load anaconda3/2021.5
python main.py $SLURM_ARRAY_TASK_ID 0 100 2000
