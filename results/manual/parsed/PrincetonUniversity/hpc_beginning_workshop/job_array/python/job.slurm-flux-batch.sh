#!/bin/bash
#FLUX: --job-name=array-job
#FLUX: -t=60
#FLUX: --urgency=16

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)
module purge
module load anaconda3/2023.9
python myscript.py
