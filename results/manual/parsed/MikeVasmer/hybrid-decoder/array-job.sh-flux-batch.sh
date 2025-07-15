#!/bin/bash
#FLUX: --job-name=hybrid
#FLUX: -t=86400
#FLUX: --priority=16

pwd
echo "SLURM_JOB_ID=$SLURM_JOB_ID"
date
module load python 
module load scipy-stack
file="input/04_09_20d.csv"
line=$SLURM_ARRAY_TASK_ID
python monte_carlo.py $file $line $line
date
