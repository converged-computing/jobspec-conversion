#!/bin/bash
#FLUX: --job-name=red-buttface-4235
#FLUX: -t=10800
#FLUX: --urgency=16

source /etc/profile
module load anaconda3-5.0.1
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python3 false_positive.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
