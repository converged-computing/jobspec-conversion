#!/bin/bash
#FLUX: --job-name=quoridor
#FLUX: -c=4
#FLUX: -t=86460
#FLUX: --urgency=16

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)
module load anaconda3/2021.5
conda activate torch-cpu
python train.py
