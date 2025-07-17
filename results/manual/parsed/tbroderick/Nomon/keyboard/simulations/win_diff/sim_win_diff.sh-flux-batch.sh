#!/bin/bash
#FLUX: --job-name=purple-bike-5161
#FLUX: --urgency=16

source /etc/profile
module load anaconda3-5.0.1
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python3 win_diff_opt.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
