#!/bin/bash
#FLUX: --job-name=purple-spoon-9674
#FLUX: --priority=16

echo test1
module load anaconda/2020b
echo test2
echo test3
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "Number of Tasks: " $SLURM_ARRAY_TASK_COUNT
python svm_models.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_COUNT
